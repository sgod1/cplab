#!/bin/bash -x

envfile=$1

PROPDIR=$CERTKUBE/scripts/cp4ba-prerequisites/propertyfile

mkdir -p $PROPDIR

cp ./cp4ba_LDAP.property $PROPDIR

./cp4ba_db_name_user.property.sh $envfile $PROPDIR/cp4ba_db_name_user.property

./cp4ba_db_server.property.sh $envfile $PROPDIR/cp4ba_db_server.property

./cp4ba_user_profile.property.sh $envfile $PROPDIR/cp4ba_user_profile.property
