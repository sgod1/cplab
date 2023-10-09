#!/bin/bash

envfile=$1
outfile=$2

# load env file
. $envfile

cat <<EOF > $outfile
## cat cp4ba_db_server.property
## Please input the value for the multiple database server/instance name, this key supports comma-separated lists. ##
## (NOTES: The value (CAN NOT CONTAIN DOT CHARACTER) is alias name for database server/instance, it is not real database server/instance host name.) ##
DB_SERVER_LIST="cloudpak"

####################################################
## Property for Database Server "cloudpak" required by IBM Cloud Pak for Business Automation on postgresql type database ##
####################################################
## Provide the database type from your infrastructure. The possible values are "db2" or "db2HADR" or "oracle" or "sqlserver" "postgresql".
cloudpak.DATABASE_TYPE="postgresql"

## Provide the database server name or IP address of the database server.
cloudpak.DATABASE_SERVERNAME="cluster-cloudpak-rw.$pgnamespace.svc.cluster.local"

## Provide the database server port. For Db2, the default is "50000". For Oracle, the default is "1521". For Postgresql, the default is "5432".
cloudpak.DATABASE_PORT="5432"

## The parameter is used to support database connection over SSL for database. Default value is "true"
cloudpak.DATABASE_SSL_ENABLE="True"
 
## Whether your PostgreSQL database enables server only or both server and client authentication. Default value is "True" for enabling both server and client authentication, "False" is for enabling server-only authentication.
cloudpak.POSTGRESQL_SSL_CLIENT_SERVER="False"

## The name of the secret that contains the DB2/Oracle/MSSQLServer/PostgreSQL SSL certificate.
cloudpak.DATABASE_SSL_SECRET_NAME="ibm-cp4ba-db-ssl-secret-for-cloudpak"

## If POSTGRESQL_SSL_CLIENT_SERVER is "True" and DATABASE_SSL_ENABLE is "True", please get "<your-server-certification: root.crt>" "<your-client-certification: client.crt>" "<your-client-key: client.key>" from server and client, and copy into this directory.Default value is "/cp4ba/501/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs/cert-kubernetes/scripts/cp4ba-prerequisites/propertyfile/cert/db/cloudpak".
## If POSTGRESQL_SSL_CLIENT_SERVER is "False" and DATABASE_SSL_ENABLE is "True", please get the SSL certificate file (rename db-cert.crt) from server and then copy into this directory.Default value is "/cp4ba/501/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs/cert-kubernetes/scripts/cp4ba-prerequisites/propertyfile/cert/db/cloudpak".
cloudpak.DATABASE_SSL_CERT_FILE_FOLDER="$CERTKUBE/scripts/cp4ba-prerequisites/propertyfile/cert/db/cloudpak"
EOF