#!/bin/bash

envfile=$1
outfile=$2

# read env file
. $envfile

CIE=${CONTENT_INITIALIZATION_ENABLE:-"Yes"}

CIE_WF=${CONTENT_INITIALIZATION_CPE_OBJ_STORE_ENABLE_WORKFLOW:-"Yes"}

cat <<EOF > $outfile
## cat cp4ba_user_profile.property
####################################################
## USER Property for CP4BA ##
####################################################
## Use this parameter to specify the license for the CP4A deployment and
## the possible values are: non-production and production and if not set, the license will
## be defaulted to production.  This value could be different from the other licenses in the CR.
CP4BA.CP4BA_LICENSE="production"

## FileNet Content Manager (FNCM) license and possible values are: user, non-production, and production.
## This value could be different from the rest of the licenses.
CP4BA.FNCM_LICENSE="production"

## Business Automation Workflow (BAW) license and possible values are: user, non-production, and production.
## This value could be different from the other licenses in the CR.
CP4BA.BAW_LICENSE="production"

## On OCP 3.x and 4.x, the User script will populate these three (3) parameters based on your input for "production" deployment.
## If you manually deploying without using the User script, then you would provide the different storage classes for the slow, medium
## and fast storage parameters below.  If you only have 1 storage class defined, then you can use that 1 storage class for all 3 parameters.
## sc_block_storage_classname is for Zen, Zen requires/recommends block storage (RWO) for metastoreDB
CP4BA.SLOW_FILE_STORAGE_CLASSNAME="ocs-storagecluster-cephfs"
CP4BA.MEDIUM_FILE_STORAGE_CLASSNAME="ocs-storagecluster-cephfs"
CP4BA.FAST_FILE_STORAGE_CLASSNAME="ocs-storagecluster-cephfs"
CP4BA.BLOCK_STORAGE_CLASS_NAME="ocs-storagecluster-ceph-rbd"

####################################################
## USER Property for FNCM ##
####################################################
## Provide the user name for P8Domain. For example: "CEAdmin"
CONTENT.APPLOGIN_USER="user01"

## Provide the user password for P8Domain.
CONTENT.APPLOGIN_PASSWORD="$APPLOGIN_PASSWORD"

## Provide LTPA key password for FNCM deployment.
CONTENT.LTPA_PASSWORD="$LTPA_PASSWORD"

## Provide keystore password for FNCM deployment.
CONTENT.KEYSTORE_PASSWORD="$KEYSTORE_PASSWORD"

####################################################
## USER Property for Content initialization ##
####################################################
## Enable/disable ECM (FNCM) / BAN initialization (e.g., creation of P8 domain, creation/configuration of object stores,
## creation/configuration of CSS servers, and initialization of Navigator (ICN).
## The default valuse is "Yes", set "No" to disable.
CONTENT_INITIALIZATION.ENABLE="$CIE"

## user name for GCD administrator, for example, "CEAdmin". This parameter accepts comma-separated lists (without spacing), for example, "CEAdmin1,CEAdmin2"
CONTENT_INITIALIZATION.LDAP_ADMIN_USER_NAME="user01"

## Names of groups containing GCD administrators, for example, "P8Administrators". This parameter accepts comma-separated lists (without spacing), for example, "P8Group1,P8Group2"
CONTENT_INITIALIZATION.LDAP_ADMINS_GROUPS_NAME="readers"

## user name and group name for object store admin, for example, "CEAdmin" or "P8Administrators". This parameter accepts comma-separated lists (without spacing), for example, "P8Group1,P8Group2"
CONTENT_INITIALIZATION.CPE_OBJ_STORE_ADMIN_USER_GROUPS="readers"

## Specify whether to enable workflow for the object store, the default vaule is "Yes"
CONTENT_INITIALIZATION.CPE_OBJ_STORE_ENABLE_WORKFLOW="$CIE_WF"

## Specify a table space for the workflow data.
CONTENT_INITIALIZATION.CPE_OBJ_STORE_WORKFLOW_DATA_TBL_SPACE="bawtos_tbs"

## Designate an LDAP group for the workflow admin group.
CONTENT_INITIALIZATION.CPE_OBJ_STORE_WORKFLOW_ADMIN_GROUP="readers"

## Designate an LDAP group for the workflow config group
CONTENT_INITIALIZATION.CPE_OBJ_STORE_WORKFLOW_CONFIG_GROUP="readers"

## Provide a name for the connection point
CONTENT_INITIALIZATION.CPE_OBJ_STORE_WORKFLOW_PE_CONN_POINT_NAME="peconn"

####################################################
## USER Property for BAN ##
####################################################
## Provide the user name for the Navigator administrator. For example: "BANAdmin"
BAN.APPLOGIN_USER="user01"

## Provide the user password for the Navigator administrator.
BAN.APPLOGIN_PASSWORD="$APPLOGIN_PASSWORD"

## Provide LTPA key password for BAN deployment.
BAN.LTPA_PASSWORD="$LTPA_PASSWORD"

## Provide keystore password for BAN deployment.
BAN.KEYSTORE_PASSWORD="$KEYSTORE_PASSWORD"

## Provide the user name for jMail used by BAN. For example: "jMailAdmin"
BAN.JMAIL_USER_NAME=""

## Provide the user password for jMail used by BAN.
BAN.JMAIL_USER_PASSWORD=""

####################################################
## USER Property for BAS ##
####################################################
## Designate an existing LDAP user for the BAStudio admin user.
BASTUDIO.ADMIN_USER="user01"
EOF