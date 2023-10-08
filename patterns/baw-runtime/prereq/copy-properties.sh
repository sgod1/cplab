#!/bin/bash -x

envfile=$1

PROPDIR=$CERTKUBE/scripts/cp4ba-prerequisites/propertyfile

mkdir -p $PROPDIR

cp ./cp4ba_LDAP.property $PROPDIR

./cp4ba_db_name_user.property.sh $envfile $PROPDIR/cp4ba_db_name_user.property

./cp4ba_db_server.property.sh $envfile $PROPDIR/cp4ba_db_server.property

./cp4ba_user_profile.property.sh $envfile $PROPDIR/cp4ba_user_profile.property

DBCERTDIR=$CERTKUBE/scripts/cp4ba-prerequisites/propertyfile/cert/db
CERTFILE="db-cert.crt"

mkdir -p $DBCERTDIR/gcddb
cp $dgcdb_cert $DBCERTDIR/gcddb/$CERTFILE

mkdir -p $DBCERTDIR/bawdocs 
cp $bawdocs_cert $DBCERTDIR/bawdocs/$CERTFILE

mkdir -p $DBCERTDIR/bawdos 
cp $bawdos_cert $DBCERTDIR/bawdos/$CERTFILE

mkdir -p $DBCERTDIR/bawtos
cp $bawtos_cert $DBCERTDIR/bawtos/$CERTFILE

mkdir -p $DBCERTDIR/chosdb 
cp $chosdb_cert $DBCERTDIR/chosdb/$CERTFILE

mkdir -p $DBCERTDIR/aeosdb 
cp $aeosdb_cert $DBCERTDIR/aeosdb/$CERTFILE

mkdir -p $DBCERTDIR/icndb
cp $icndb_cert $DBCERTDIR/icndb/$CERTFILE

mkdir -p $DBCERTDIR/aaedb 
cp $aaedb_cert $DBCERTDIR/aaedb/$CERTFILE

mkdir -p $DBCERTDIR/bawdb
cp $bawdb_cert $DBCERTDIR/bawdb/$CERTFILE
