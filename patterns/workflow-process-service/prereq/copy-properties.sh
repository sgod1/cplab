#!/bin/bash -x

PROPDIR=$CERTKUBE/scripts/cp4ba-prerequisites/propertyfile

mkdir -p $PROPDIR

cp ./cp4ba_LDAP.property $PROPDIR

cp ./cp4ba_user_profile.property $PROPDIR
