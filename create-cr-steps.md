### Steps to Generate Workflow Process Authoring CR

These are steps to create `Workflow Process Authoring CR` using scripts in the CP4BA CASE package.<br/>
These steps follow documentation and provde comments and required values.

When all steps are completed, CR is generated in

```
$CERTKUBE/scripts/generated-cr/ibm_cp4a_cr_final.yaml
```

Before you start, set your project and working directory.

```
oc project cp4ba

cd $KUBECERT/scripts
```

> Query storage classes, we will use them as input to prerequisites script:
```
oc get sc
NAME                          PROVISIONER                             RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
ocs-storagecluster-ceph-rbd   openshift-storage.rbd.csi.ceph.com      Delete          Immediate              true                   15d
ocs-storagecluster-ceph-rgw   openshift-storage.ceph.rook.io/bucket   Delete          Immediate              false                  15d
ocs-storagecluster-cephfs     openshift-storage.cephfs.csi.ceph.com   Delete          Immediate              true                   15d
openshift-storage.noobaa.io   openshift-storage.noobaa.io/obc         Delete          Immediate              false                  15d
```

> Run prerequisite script in `property` mode:
```
cd $CERTKUBE/scripts
./cp4a-prerequisites.sh -m property
```

> Select *option 8 - Workflow Process Service Authoring*, hit return, and hit return again on the second screen and third screens.

> For LDAP configuration, select *Yes*.

> For LDAP type, select *option 2 - IBM Tivoli Directory Server / Security Directory Server*

> For slow storage class, enter *ocs-storagecluster-cephfs*

> For medium storage class, enter *ocs-storagecluster-cephfs*

> For fast storage class, enter *ocs-storagecluster-cephfs*

> For block storage class, enter *ocs-storagecluster-ceph-rbd*

> For external Postgresql, enter *No*. Workflow Process Service Authoring Operator will provision an EDB postgreSQL database.

> Change to `cp4ba-prerequisites/propertyfile` directory and edit propery files.

```
cd $CERTKUBE/scripts/cp4ba-prerequisites/propertyfile
```

> Edit `cp4ba_LDAP.property` file:

Note that openldap server that we deployed to the cluster can be accessed internally by pods running on the cluster<br/>
or externally from outside the cluster.

When running prerequisites script in `validation` mode we must use external LDAP_SERVER and external LDAP_PORT.<br/>
External values: LDAP_SERVER="any-worker-node-domain-name", LDAP_PORT=31389

When running in pods it is better to use internal LDAP_SERVER and internal LDAP_PORT.
Internal values: LDAP_SERVER="openldap.openldap.svc", LDAP_PORT="1389"

```
###########################
## Property file for TDS ##
###########################
## The possible values are: "IBM Security Directory Server" or "Microsoft Active Directory"
LDAP_TYPE="IBM Security Directory Server"

## The name of the LDAP server to connect
LDAP_SERVER="worker1.cloudpak.szesto.io"

## The port of the LDAP server to connect.  Some possible values are: 389, 636, etc.
LDAP_PORT="31389"

## The LDAP base DN.  For example, "dc=example,dc=com", "dc=abc,dc=com", etc
LDAP_BASE_DN="dc=example,dc=org"

## The LDAP bind DN. For example, "uid=user1,dc=example,dc=com", "uid=user1,dc=abc,dc=com", etc.
LDAP_BIND_DN="cn=admin,dc=example,dc=org"

## The password for LDAP bind DN.
LDAP_BIND_DN_PASSWORD="adminpassword"

## Enable SSL/TLS for LDAP communication. Refer to Knowledge Center for more info.
LDAP_SSL_ENABLED="False"

## The name of the secret that contains the LDAP SSL/TLS certificate.
LDAP_SSL_SECRET_NAME="ibm-cp4ba-ldap-ssl-secret"

## If enabled LDAP SSL, you need copy the SSL certificate file (named ldap-cert.crt) into this directory. Default value is "/Users/simon/cp4ba/502/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs/cert-kubernetes/scripts/cp4ba-prerequisites/propertyfile/cert/ldap"
LDAP_SSL_CERT_FILE_FOLDER="/path/to/homedir/cp4ba/502/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs/cert-kubernetes/scripts/cp4ba-prerequisites/propertyfile/cert/ldap"

## The LDAP user name attribute. Semicolon-separated list that must include the first RDN user distinguished names. One possible value is "*:uid" for TDS and "user:sAMAccountName" for AD. Refer to Knowledge Center for more info.
LDAP_USER_NAME_ATTRIBUTE="*:uid"

## The LDAP user display name attribute. One possible value is "cn" for TDS and "sAMAccountName" for AD. Refer to Knowledge Center for more info.
LDAP_USER_DISPLAY_NAME_ATTR="cn"

## The LDAP group base DN.  For example, "dc=example,dc=com", "dc=abc,dc=com", etc
LDAP_GROUP_BASE_DN="ou=users,dc=example,dc=org"

## The LDAP group name attribute.  One possible value is "*:cn" for TDS and "*:cn" for AD. Refer to Knowledge Center for more info.
LDAP_GROUP_NAME_ATTRIBUTE="*:cn"

## The LDAP group display name attribute.  One possible value for both TDS and AD is "cn". Refer to Knowledge Center for more info.
LDAP_GROUP_DISPLAY_NAME_ATTR="cn"

## The LDAP group membership search filter string.  One possible value is "(|(&(objectclass=groupofnames)(member={0}))(&(objectclass=groupofuniquenames)(uniquemember={0})))" for TDS, and "(&(cn=%v)(objectcategory=group))" for AD.
LDAP_GROUP_MEMBERSHIP_SEARCH_FILTER="(|(&(objectclass=groupofnames)(member={0}))(&(objectclass=groupofuniquenames)(uniquemember={0})))"

## The LDAP group membership ID map.  One possible value is "groupofnames:member" for TDS and "memberOf:member" for AD.
LDAP_GROUP_MEMBER_ID_MAP="groupofnames:member"

## One possible value is "(&(cn=%v)(objectclass=person))"
LC_USER_FILTER="(&(cn=%v)(objectclass=inetOrgPerson))"

## One possible value is "(&(cn=%v)(|(objectclass=groupofnames)(objectclass=groupofuniquenames)(objectclass=groupofurls)))"
LC_GROUP_FILTER="(&(cn=%v)(|(objectclass=groupofnames)(objectclass=groupofuniquenames)(objectclass=groupofurls)))"
```

> Edit `cp4ba_user_profile.property` file

Set ba studio admin user to `user01`.

```
####################################################
## USER Property for CP4BA ##
####################################################
## Use this parameter to specify the license for the CP4A deployment and
## the possible values are: non-production and production and if not set, the license will
## be defaulted to production.  This value could be different from the other licenses in the CR.
CP4BA.CP4BA_LICENSE="production"

## On OCP 3.x and 4.x, the User script will populate these three (3) parameters based on your input for "production" deployment.
## If you manually deploying without using the User script, then you would provide the different storage classes for the slow, medium
## and fast storage parameters below.  If you only have 1 storage class defined, then you can use that 1 storage class for all 3 parameters.
## sc_block_storage_classname is for Zen, Zen requires/recommends block storage (RWO) for metastoreDB
CP4BA.SLOW_FILE_STORAGE_CLASSNAME="ocs-storagecluster-cephfs"
CP4BA.MEDIUM_FILE_STORAGE_CLASSNAME="ocs-storagecluster-cephfs"
CP4BA.FAST_FILE_STORAGE_CLASSNAME="ocs-storagecluster-cephfs"
CP4BA.BLOCK_STORAGE_CLASS_NAME="ocs-storagecluster-ceph-rbd"

####################################################
## USER Property for BAS ##
####################################################
## Designate an existing LDAP user for the BAStudio admin user.
BASTUDIO.ADMIN_USER="user01"
```

> Run prerequisite script in `generate` mode:
```
cd $CERTKUBE/scripts
./cp4a-prerequisites.sh -m generate
```

> `generated` mode created ldap bind secret yaml:

```
cd $CERTKUBE/scripts

cat cp4ba-prerequisites/secret_template/ldap-bind-secret.yaml 

# YAML template for ldap-bind-secret secret
---
kind: Secret
apiVersion: v1
type: Opaque
metadata:
  name: ldap-bind-secret
  # DO NOT change the content of metadata.labels
  labels:
    name: ldap-bind-secret
stringData:
  ldapUsername: "cn=admin,dc=example,dc=org"
  ldapPassword: "adminpassword"
```

> Set current project to `cp4ba` and apply ldap-bind-secret.yaml

```
cd $CERTKUBE/scripts
oc project cp4ba

oc apply -f cp4ba-prerequisites/secret_template/ldap-bind-secret.yaml
secret/ldap-bind-secret created
```

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

> Run CR generation script

```
oc project cp4ba
cd $CERTKUBE/scripts

./cp4a-deployment
```

> For License Accept, select: *Yes*

> For Content CR, select: *No*

> For Deployment Type, select: `2`, *Production*

> Hit `Enter` for selected capabilities

> For deployment profile, select: `1`, *small*

> For Cloud Platform, select: `2`, *Openshift Container Platform (OCP) - Private Cloud*

> For default IAM admin user, select: *No*

> Enter user name: *user01*

> Hit `Enter` for JDBC driver URL

> At the summary screen, select: *Yes*, Proceed with deployment.

```
Creating the Custom Resource of the Cloud Pak for Business Automation operator...

Applying value in property file into final CR
[✔] Applied value in property file into final CR under $CERTKUBE/scripts/generated-cr
Please confirm final custom resource under $CERTKUBE/scripts/generated-cr

The custom resource file used is: "$CERTKUBE/scripts/generated-cr/ibm_cp4a_cr_final.yaml"
```
