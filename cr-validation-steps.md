### Pre-deployment cloud pak CR validation steps.

Run validation steps before applying cloud pak CR.<br/>

Log on the lab container.

#### Validate openldap search.

>Validate internal in-cluster ldap search:

```
oc get pods -n openldap
NAME                        READY   STATUS    RESTARTS   AGE
openldap-75654cb8b9-mwjd7   1/1     Running   0          173m

oc exec -n openldap openldap-75654cb8b9-mwjd7 -- ldapsearch -x -H ldap://openldap.openldap.svc:1389 -b "dc=example,dc=org" -s sub -D "cn=admin,dc=example,dc=org" -x -w adminpassword
```

>Validate external ldap search:

Here `$WORKER` is worker node in the cluster and `31389` is node port allocated on each node.

```
ldapsearch -H ldap:/$WORKER:31389  -b "dc=example,dc=org" -s sub -D "cn=admin,dc=example,dc=org" -x -w adminpassword
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

#### Validate cloud pak CR.

> Run prerequisite script in 'validate' mode. Make sure it completes without errors.

Note: if you see errors from validation script, fix errors and rerun validation again.

```
cd $CERTKUBE/scripts
./cp4a-prerequisites.sh -m validate
```

```
*****************************************************
Validating the prerequisites before you install CP4BA
*****************************************************

============== Checking Slow/Medium/Fast/Block storage class required by CP4BA ==============

[INFO] Checking the storage class: "ocs-storagecluster-cephfs"...
......

[✔] Verification storage class: "ocs-storagecluster-cephfs", PASSED!

[INFO] Checking the storage class: "ocs-storagecluster-cephfs"...
......

[✔] Verification storage class: "ocs-storagecluster-cephfs", PASSED!

[INFO] Checking the storage class: "ocs-storagecluster-cephfs"...
......

[✔] Verification storage class: "ocs-storagecluster-cephfs", PASSED!

[INFO] Checking the storage class: "ocs-storagecluster-ceph-rbd"...
......

[✔] Verification storage class: "ocs-storagecluster-ceph-rbd", PASSED!
============== Checking the Kubernetes secret required by CP4BA existing in cluster or not ==============

[✔] Found secret "ldap-bind-secret" in Kubernetes cluster, PASSED!

============== All secrets created in Kubernetes cluster, PASSED! ==============

============== Checking LDAP connection required by CP4BA ==============

Checking connection for LDAP server "worker1.cloudpak.szesto.io" using Bind DN "cn=admin,dc=example,dc=org"..
Binding...
Binding with principal: cn=admin,dc=example,dc=org
Connected to: ldap://worker1.cloudpak.szesto.io:31389
Binding took 107 ms
Total time taken: 107 ms

[✔] Connected to LDAP "worker1.cloudpak.szesto.io" using BindDN:"cn=admin,dc=example,dc=org" successfuly, PASSED!
```
