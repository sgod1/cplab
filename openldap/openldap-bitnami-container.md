### Deploy OpenLdap Bitnami container

By default, Bitnami ldap container is preconfigured with 2 users, and one group.

```
suffix: dc=example,dc=org
admin dn: cn=admin,dc=example,dc=org
admin password: adminpassword

Users:
cn=user01,ou=users,dc=example,dc=org
user01 password: bitnami1
objectClass: inetOrgPerson

cn=user02,ou=users,dc=example,dc=org
user02 password: bitnami2
objectClass: inetOrgPerson

Group:
cn=readers,ou=users,dc=example,dc=org
objectClass: groupOfNames
member: cn=user01,ou=users,dc=example,dc=org
member: cn=user02,ou=users,dc=example,dc=org
```

>Create `~/cp4ba/openldap` directory.
```
mkdir ~/cp4ba/openldap
```

>Change to `~/cp4ba/openldap` directory and create `openldap` project for bitnami openldap.

```
cd ~/cp4ba/openldap
oc new-project openldap
```

>Bitnami ldap container requires specific user id.
>Grant `anyuid` scc to `default` service account in `openldap` project.

```
oc project openldap
oc adm policy add-scc-to-user -z default anyuid
```

>Create `openldap` deployment

```
cat <<EOF > openldap-deployment.yaml
kind: Deployment
apiVersion: apps/v1
metadata:
  annotations:
  name: openldap
  namespace: openldap
  labels:
    app: openldap
spec:
  replicas: 1
  selector:
    matchLabels:
      app: openldap
  template:
    metadata:
      labels:
        app: openldap
        deployment: openldap
    spec:
      containers:
        - name: openldap
          image: docker.io/bitnami/openldap:latest
          ports:
            - containerPort: 1389
              protocol: TCP
            - containerPort: 1636
              protocol: TCP
          securityContext:
            readOnlyRootFilesystem: false
            runAsUser: 1001
            runAsGroup: 0
          resources: {}
          terminationMessagePath: /dev/termination-log
          terminationMessagePolicy: File
          imagePullPolicy: Always
      restartPolicy: Always
      terminationGracePeriodSeconds: 30
      dnsPolicy: ClusterFirst
      serviceAccountName: default
      schedulerName: default-scheduler
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 25%
      maxSurge: 25%
  revisionHistoryLimit: 10
  progressDeadlineSeconds: 600
EOF
```

```
apply -f openldap-deployment.yaml
```

>Create `openldap` service.

This service can be used to access ldap from within the cluster.

```
cat <<EOF > openldap-service.yaml
kind: Service
apiVersion: v1
metadata:
  name: openldap
  namespace: openldap
  labels:
    app: openldap
spec:
  ipFamilies:
    - IPv4
  ports:
    - name: 1389-tcp
      protocol: TCP
      port: 1389
      targetPort: 1389
    - name: 1636-tcp
      protocol: TCP
      port: 1636
      targetPort: 1636
  internalTrafficPolicy: Cluster
  type: ClusterIP
  ipFamilyPolicy: SingleStack
  sessionAffinity: None
  selector:
    app: openldap
    deployment: openldap
EOF
```

```
apply -f openldap-service.yaml
```

>Create `nodeport` to access ldap server from outside the clsuter on port `31389`.

```
cat <<EOF > openldap-nodeport.yaml
apiVersion: v1
kind: Service
metadata:
  name: openldap-nodeport
  namespace: openldap
  labels:
    app: openldap
spec:
  type: NodePort
  sessionAffinity: None
  ports:
    - port: 1389
      protocol: TCP
      nodePort: 31389
      name: openldap
  selector:
    app: openldap
    deployment: openldap
EOF
```

```
apply -f openldap-nodeport.yaml
```

### Validate openldap deployment.

>Validate internal in-cluster ldap search:

```
oc get pods -n openldap
NAME                        READY   STATUS    RESTARTS   AGE
openldap-75654cb8b9-mwjd7   1/1     Running   0          173m

oc exec openldap-75654cb8b9-mwjd7 -- ldapsearch -x -H ldap://openldap.openldap.svc:1389 -b "dc=example,dc=org" -s sub -D "cn=admin,dc=example,dc=org" -x -w adminpassword
```

>Validate external ldap search:

Here `worker.domain.name` is any worker node in the cluster and `31389` is node port allocated on each node.

```
ldapsearch -H ldap://worker.domain.name:31389  -b "dc=example,dc=org" -s sub -D "cn=admin,dc=example,dc=org" -x -w adminpassword
```

Expected search output:

```
# extended LDIF
#
# LDAPv3
# base <dc=example,dc=org> with scope subtree
# filter: (objectclass=*)
# requesting: ALL
#

# example.org
dn: dc=example,dc=org
objectClass: dcObject
objectClass: organization
dc: example
o: example

# users, example.org
dn: ou=users,dc=example,dc=org
objectClass: organizationalUnit
ou: users

# user01, users, example.org
dn: cn=user01,ou=users,dc=example,dc=org
cn: User1
cn: user01
sn: Bar1
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
userPassword:: Yml0bmFtaTE=
uid: user01
uidNumber: 1000
gidNumber: 1000
homeDirectory: /home/user01

# user02, users, example.org
dn: cn=user02,ou=users,dc=example,dc=org
cn: User2
cn: user02
sn: Bar2
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
userPassword:: Yml0bmFtaTI=
uid: user02
uidNumber: 1001
gidNumber: 1001
homeDirectory: /home/user02

# readers, users, example.org
dn: cn=readers,ou=users,dc=example,dc=org
cn: readers
objectClass: groupOfNames
member: cn=user01,ou=users,dc=example,dc=org
member: cn=user02,ou=users,dc=example,dc=org

# search result
search: 2
result: 0 Success

# numResponses: 6
# numEntries: 5
```
