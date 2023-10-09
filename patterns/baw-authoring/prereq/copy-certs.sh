#!/bin/bash

envfile=$1

. $envfile

DBCERTDIR=$CERTKUBE/scripts/cp4ba-prerequisites/propertyfile/cert/db
CERTFILE="db-cert.crt"

mkdir -p $DBCERTDIR/cloudpak
#echo $cloudpak_cert > $DBCERTDIR/gcddb/$CERTFILE
