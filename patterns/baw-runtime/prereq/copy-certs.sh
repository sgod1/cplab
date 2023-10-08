#!/bin/bash -x

envfile=$1

. $envfile

DBCERTDIR=$CERTKUBE/scripts/cp4ba-prerequisites/propertyfile/cert/db
CERTFILE="db-cert.crt"

mkdir -p $DBCERTDIR/gcddb
echo $gcddb_cert > $DBCERTDIR/gcddb/$CERTFILE

mkdir -p $DBCERTDIR/bawdocs 
echo $bawdocs_cert > $DBCERTDIR/bawdocs/$CERTFILE

mkdir -p $DBCERTDIR/bawdos 
echo $bawdos_cert > $DBCERTDIR/bawdos/$CERTFILE

mkdir -p $DBCERTDIR/bawtos
echo $bawtos_cert > $DBCERTDIR/bawtos/$CERTFILE

mkdir -p $DBCERTDIR/chosdb 
echo $chosdb_cert > $DBCERTDIR/chosdb/$CERTFILE

mkdir -p $DBCERTDIR/aeosdb 
echo $aeosdb_cert > $DBCERTDIR/aeosdb/$CERTFILE

mkdir -p $DBCERTDIR/icndb
echo $icndb_cert > $DBCERTDIR/icndb/$CERTFILE

mkdir -p $DBCERTDIR/aaedb 
echo $aaedb_cert > $DBCERTDIR/aaedb/$CERTFILE

mkdir -p $DBCERTDIR/bawdb
echo $bawdb_cert > $DBCERTDIR/bawdb/$CERTFILE
