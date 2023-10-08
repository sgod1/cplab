#!/bin/bash -x

envfile=$1

PROPDIR=$CERTKUBE/scripts/cp4ba-prerequisites/propertyfile

mkdir -p $PROPDIR

cp ./cp4ba_LDAP.property $PROPDIR

./cp4ba_db_name_user.property.sh $envfile $PROPDIR/cp4ba_db_name_user.property

namespace="$postgresns"

cat ./cp4ba_db_server.property.sh > $PROPDIR/cp4ba_db_server.property

APPLOGIN_USER="$user"
APPLOGIN_PASSWORD="$password"
LTPA_PASSWORD="$ltpa"
KEYSTORE_PASSWORD="$keystore"
CPE_OBJ_STORE_WORKFLOW_DATA_TBL_SPACE=""
CPE_OBJ_STORE_WORKFLOW_PE_CONN_POINT_NAME=""
JMAIL_USER_NAME=""
JMAIL_USER_PASSWORD=""
ADMIN_USER="$admin"

cat ./cp4ba_user_profile.property.sh > $PROPDIR/cp4ba_user_profile.property
