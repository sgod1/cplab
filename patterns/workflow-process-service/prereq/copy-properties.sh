#!/bin/bash -x

PROPDIR=$CERTKUBE/scripts/cp4ba-prerequisites/propertyfile

mkdir -p $PROPDIR

basedir=`pwd`
if [[ ! -z $WPS_GIT ]]; then
    basedir=$WPS_GIT/prereq
fi

cp $basedir/cp4ba_LDAP.property $PROPDIR

cp $basedir/cp4ba_user_profile.property $PROPDIR

touch $PROPDIR/cp4ba_db_name_user.property
touch $PROPDIR/cp4ba_db_server.property
