## cp4ba_db_server.property
## Please input the value for the multiple database server/instance name, this key supports comma-separated lists. ##
## (NOTES: The value (CAN NOT CONTAIN DOT CHARACTER) is alias name for database server/instance, it is not real database server/instance host name.) ##
DB_SERVER_LIST="gcddb,bawdocs,bawdos,bawtos,chosdb,aeosdb,icndb,aaedb,cloudpak9"

####################################################
## Property for Database Server "gcddb" required by IBM Cloud Pak for Business Automation on postgresql type database ##
####################################################
## Provide the database type from your infrastructure. The possible values are "db2" or "db2HADR" or "oracle" or "sqlserver" "postgresql".
gcddb.DATABASE_TYPE="postgresql"

## Provide the database server name or IP address of the database server.
gcddb.DATABASE_SERVERNAME="cluster-gcddb-rw.$namespace.svc.cluster.local"

## Provide the database server port. For Db2, the default is "50000". For Oracle, the default is "1521". For Postgresql, the default is "5432".
gcddb.DATABASE_PORT="5432"

## The parameter is used to support database connection over SSL for database. Default value is "true"
gcddb.DATABASE_SSL_ENABLE="True"
 
## Whether your PostgreSQL database enables server only or both server and client authentication. Default value is "True" for enabling both server and client authentication, "False" is for enabling server-only authentication.
gcddb.POSTGRESQL_SSL_CLIENT_SERVER="False"

## The name of the secret that contains the DB2/Oracle/MSSQLServer/PostgreSQL SSL certificate.
gcddb.DATABASE_SSL_SECRET_NAME="ibm-cp4ba-db-ssl-secret-for-gcddb"

## If POSTGRESQL_SSL_CLIENT_SERVER is "True" and DATABASE_SSL_ENABLE is "True", please get "<your-server-certification: root.crt>" "<your-client-certification: client.crt>" "<your-client-key: client.key>" from server and client, and copy into this directory.Default value is "/cp4ba/501/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs/cert-kubernetes/scripts/cp4ba-prerequisites/propertyfile/cert/db/cloudpak1".

## If POSTGRESQL_SSL_CLIENT_SERVER is "False" and DATABASE_SSL_ENABLE is "True", please get the SSL certificate file (rename db-cert.crt) from server and then copy into this directory.Default value is "/cp4ba/501/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs/cert-kubernetes/scripts/cp4ba-prerequisites/propertyfile/cert/db/cloudpak1".
gcddb.DATABASE_SSL_CERT_FILE_FOLDER="$CERTKUBE/scripts/cp4ba-prerequisites/propertyfile/cert/db/gcddb"

####################################################
## Property for Database Server "bawdocs" required by IBM Cloud Pak for Business Automation on postgresql type database ##
####################################################
## Provide the database type from your infrastructure. The possible values are "db2" or "db2HADR" or "oracle" or "sqlserver" "postgresql".
bawdocs.DATABASE_TYPE="postgresql"

## Provide the database server name or IP address of the database server.
bawdocs.DATABASE_SERVERNAME="cluster-bawdocs-rw.$namespace.svc.cluster.local"

## Provide the database server port. For Db2, the default is "50000". For Oracle, the default is "1521". For Postgresql, the default is "5432".
bawdocs.DATABASE_PORT="5432"

## The parameter is used to support database connection over SSL for database. Default value is "true"
bawdocs.DATABASE_SSL_ENABLE="True"
 
## Whether your PostgreSQL database enables server only or both server and client authentication. Default value is "True" for enabling both server and client authentication, "False" is for enabling server-only authentication.
bawdocs.POSTGRESQL_SSL_CLIENT_SERVER="False"

## The name of the secret that contains the DB2/Oracle/MSSQLServer/PostgreSQL SSL certificate.
bawdocs.DATABASE_SSL_SECRET_NAME="ibm-cp4ba-db-ssl-secret-for-bawdocs"

## If POSTGRESQL_SSL_CLIENT_SERVER is "True" and DATABASE_SSL_ENABLE is "True", please get "<your-server-certification: root.crt>" "<your-client-certification: client.crt>" "<your-client-key: client.key>" from server and client, and copy into this directory.Default value is "/cp4ba/501/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs/cert-kubernetes/scripts/cp4ba-prerequisites/propertyfile/cert/db/cloudpak2".

## If POSTGRESQL_SSL_CLIENT_SERVER is "False" and DATABASE_SSL_ENABLE is "True", please get the SSL certificate file (rename db-cert.crt) from server and then copy into this directory.Default value is "/cp4ba/501/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs/cert-kubernetes/scripts/cp4ba-prerequisites/propertyfile/cert/db/cloudpak2".
bawdocs.DATABASE_SSL_CERT_FILE_FOLDER="$CERTKUBE/scripts/cp4ba-prerequisites/propertyfile/cert/db/bawdocs"

####################################################
## Property for Database Server "bawdos" required by IBM Cloud Pak for Business Automation on postgresql type database ##
####################################################
## Provide the database type from your infrastructure. The possible values are "db2" or "db2HADR" or "oracle" or "sqlserver" "postgresql".
bawdos.DATABASE_TYPE="postgresql"

## Provide the database server name or IP address of the database server.
bawdos.DATABASE_SERVERNAME="cluster-bawdos-rw.$namespace.svc.cluster.local"

## Provide the database server port. For Db2, the default is "50000". For Oracle, the default is "1521". For Postgresql, the default is "5432".
bawdos.DATABASE_PORT="5432"

## The parameter is used to support database connection over SSL for database. Default value is "true"
bawdos.DATABASE_SSL_ENABLE="True"
 
## Whether your PostgreSQL database enables server only or both server and client authentication. Default value is "True" for enabling both server and client authentication, "False" is for enabling server-only authentication.
bawdos.POSTGRESQL_SSL_CLIENT_SERVER="False"

## The name of the secret that contains the DB2/Oracle/MSSQLServer/PostgreSQL SSL certificate.
bawdos.DATABASE_SSL_SECRET_NAME="ibm-cp4ba-db-ssl-secret-for-bawdos"

## If POSTGRESQL_SSL_CLIENT_SERVER is "True" and DATABASE_SSL_ENABLE is "True", please get "<your-server-certification: root.crt>" "<your-client-certification: client.crt>" "<your-client-key: client.key>" from server and client, and copy into this directory.Default value is "/cp4ba/501/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs/cert-kubernetes/scripts/cp4ba-prerequisites/propertyfile/cert/db/cloudpak3".

## If POSTGRESQL_SSL_CLIENT_SERVER is "False" and DATABASE_SSL_ENABLE is "True", please get the SSL certificate file (rename db-cert.crt) from server and then copy into this directory.Default value is "/cp4ba/501/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs/cert-kubernetes/scripts/cp4ba-prerequisites/propertyfile/cert/db/cloudpak3".
bawdos.DATABASE_SSL_CERT_FILE_FOLDER="$CERTKUBE/scripts/cp4ba-prerequisites/propertyfile/cert/db/bawdos"

####################################################
## Property for Database Server "bawtos" required by IBM Cloud Pak for Business Automation on postgresql type database ##
####################################################
## Provide the database type from your infrastructure. The possible values are "db2" or "db2HADR" or "oracle" or "sqlserver" "postgresql".
bawtos.DATABASE_TYPE="postgresql"

## Provide the database server name or IP address of the database server.
bawtos.DATABASE_SERVERNAME="cluster-bawtos-rw.$namespace.svc.cluster.local"

## Provide the database server port. For Db2, the default is "50000". For Oracle, the default is "1521". For Postgresql, the default is "5432".
bawtos.DATABASE_PORT="5432"

## The parameter is used to support database connection over SSL for database. Default value is "true"
bawtos.DATABASE_SSL_ENABLE="True"
 
## Whether your PostgreSQL database enables server only or both server and client authentication. Default value is "True" for enabling both server and client authentication, "False" is for enabling server-only authentication.
bawtos.POSTGRESQL_SSL_CLIENT_SERVER="False"

## The name of the secret that contains the DB2/Oracle/MSSQLServer/PostgreSQL SSL certificate.
bawtos.DATABASE_SSL_SECRET_NAME="ibm-cp4ba-db-ssl-secret-for-bawtos"

## If POSTGRESQL_SSL_CLIENT_SERVER is "True" and DATABASE_SSL_ENABLE is "True", please get "<your-server-certification: root.crt>" "<your-client-certification: client.crt>" "<your-client-key: client.key>" from server and client, and copy into this directory.Default value is "/cp4ba/501/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs/cert-kubernetes/scripts/cp4ba-prerequisites/propertyfile/cert/db/cloudpak4".

## If POSTGRESQL_SSL_CLIENT_SERVER is "False" and DATABASE_SSL_ENABLE is "True", please get the SSL certificate file (rename db-cert.crt) from server and then copy into this directory.Default value is "/cp4ba/501/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs/cert-kubernetes/scripts/cp4ba-prerequisites/propertyfile/cert/db/cloudpak4".
bawtos.DATABASE_SSL_CERT_FILE_FOLDER="$CERTKUBE/scripts/cp4ba-prerequisites/propertyfile/cert/db/bawtos"

####################################################
## Property for Database Server "chosdb" required by IBM Cloud Pak for Business Automation on postgresql type database ##
####################################################
## Provide the database type from your infrastructure. The possible values are "db2" or "db2HADR" or "oracle" or "sqlserver" "postgresql".
chosdb.DATABASE_TYPE="postgresql"

## Provide the database server name or IP address of the database server.
chosdb.DATABASE_SERVERNAME="cluster-chosdb-rw.$namespace.svc.cluster.local"

## Provide the database server port. For Db2, the default is "50000". For Oracle, the default is "1521". For Postgresql, the default is "5432".
chosdb.DATABASE_PORT="5432"

## The parameter is used to support database connection over SSL for database. Default value is "true"
chosdb.DATABASE_SSL_ENABLE="True"
 
## Whether your PostgreSQL database enables server only or both server and client authentication. Default value is "True" for enabling both server and client authentication, "False" is for enabling server-only authentication.
chosdb.POSTGRESQL_SSL_CLIENT_SERVER="False"

## The name of the secret that contains the DB2/Oracle/MSSQLServer/PostgreSQL SSL certificate.
chosdb.DATABASE_SSL_SECRET_NAME="ibm-cp4ba-db-ssl-secret-for-chosdb"

## If POSTGRESQL_SSL_CLIENT_SERVER is "True" and DATABASE_SSL_ENABLE is "True", please get "<your-server-certification: root.crt>" "<your-client-certification: client.crt>" "<your-client-key: client.key>" from server and client, and copy into this directory.Default value is "/cp4ba/501/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs/cert-kubernetes/scripts/cp4ba-prerequisites/propertyfile/cert/db/cloudpak5".

## If POSTGRESQL_SSL_CLIENT_SERVER is "False" and DATABASE_SSL_ENABLE is "True", please get the SSL certificate file (rename db-cert.crt) from server and then copy into this directory.Default value is "/cp4ba/501/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs/cert-kubernetes/scripts/cp4ba-prerequisites/propertyfile/cert/db/cloudpak5".
chosdb.DATABASE_SSL_CERT_FILE_FOLDER="$CERTKUBE/scripts/cp4ba-prerequisites/propertyfile/cert/db/chosdb"

####################################################
## Property for Database Server "aeosdb" required by IBM Cloud Pak for Business Automation on postgresql type database ##
####################################################
## Provide the database type from your infrastructure. The possible values are "db2" or "db2HADR" or "oracle" or "sqlserver" "postgresql".
aeosdb.DATABASE_TYPE="postgresql"

## Provide the database server name or IP address of the database server.
aeosdb.DATABASE_SERVERNAME="cluster-aeosdb-rw.$namespace.svc.cluster.local"

## Provide the database server port. For Db2, the default is "50000". For Oracle, the default is "1521". For Postgresql, the default is "5432".
aeosdb.DATABASE_PORT="5432"

## The parameter is used to support database connection over SSL for database. Default value is "true"
aeosdb.DATABASE_SSL_ENABLE="True"
 
## Whether your PostgreSQL database enables server only or both server and client authentication. Default value is "True" for enabling both server and client authentication, "False" is for enabling server-only authentication.
aeosdb.POSTGRESQL_SSL_CLIENT_SERVER="False"

## The name of the secret that contains the DB2/Oracle/MSSQLServer/PostgreSQL SSL certificate.
aeosdb.DATABASE_SSL_SECRET_NAME="ibm-cp4ba-db-ssl-secret-for-aeosdb"

## If POSTGRESQL_SSL_CLIENT_SERVER is "True" and DATABASE_SSL_ENABLE is "True", please get "<your-server-certification: root.crt>" "<your-client-certification: client.crt>" "<your-client-key: client.key>" from server and client, and copy into this directory.Default value is "/cp4ba/501/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs/cert-kubernetes/scripts/cp4ba-prerequisites/propertyfile/cert/db/cloudpak6".

## If POSTGRESQL_SSL_CLIENT_SERVER is "False" and DATABASE_SSL_ENABLE is "True", please get the SSL certificate file (rename db-cert.crt) from server and then copy into this directory.Default value is "/cp4ba/501/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs/cert-kubernetes/scripts/cp4ba-prerequisites/propertyfile/cert/db/cloudpak6".
aeosdb.DATABASE_SSL_CERT_FILE_FOLDER="$CERTKUBE/scripts/cp4ba-prerequisites/propertyfile/cert/db/aeosdb"

####################################################
## Property for Database Server "icndb" required by IBM Cloud Pak for Business Automation on postgresql type database ##
####################################################
## Provide the database type from your infrastructure. The possible values are "db2" or "db2HADR" or "oracle" or "sqlserver" "postgresql".
icndb.DATABASE_TYPE="postgresql"

## Provide the database server name or IP address of the database server.
icndb.DATABASE_SERVERNAME="cluster-icndb-rw.$namespace.svc.cluster.local"

## Provide the database server port. For Db2, the default is "50000". For Oracle, the default is "1521". For Postgresql, the default is "5432".
icndb.DATABASE_PORT="5432"

## The parameter is used to support database connection over SSL for database. Default value is "true"
icndb.DATABASE_SSL_ENABLE="True"
 
## Whether your PostgreSQL database enables server only or both server and client authentication. Default value is "True" for enabling both server and client authentication, "False" is for enabling server-only authentication.
icndb.POSTGRESQL_SSL_CLIENT_SERVER="False"

## The name of the secret that contains the DB2/Oracle/MSSQLServer/PostgreSQL SSL certificate.
icndb.DATABASE_SSL_SECRET_NAME="ibm-cp4ba-db-ssl-secret-for-icndb"

## If POSTGRESQL_SSL_CLIENT_SERVER is "True" and DATABASE_SSL_ENABLE is "True", please get "<your-server-certification: root.crt>" "<your-client-certification: client.crt>" "<your-client-key: client.key>" from server and client, and copy into this directory.Default value is "/cp4ba/501/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs/cert-kubernetes/scripts/cp4ba-prerequisites/propertyfile/cert/db/cloudpak7".

## If POSTGRESQL_SSL_CLIENT_SERVER is "False" and DATABASE_SSL_ENABLE is "True", please get the SSL certificate file (rename db-cert.crt) from server and then copy into this directory.Default value is "/cp4ba/501/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs/cert-kubernetes/scripts/cp4ba-prerequisites/propertyfile/cert/db/cloudpak7".
icndb.DATABASE_SSL_CERT_FILE_FOLDER="$CERTKUBE/scripts/cp4ba-prerequisites/propertyfile/cert/db/icndb"

####################################################
## Property for Database Server "aaedb" required by IBM Cloud Pak for Business Automation on postgresql type database ##
####################################################
## Provide the database type from your infrastructure. The possible values are "db2" or "db2HADR" or "oracle" or "sqlserver" "postgresql".
aaedb.DATABASE_TYPE="postgresql"

## Provide the database server name or IP address of the database server.
aaedb.DATABASE_SERVERNAME="cluster-aaedb-rw.$namespace.svc.cluster.local"

## Provide the database server port. For Db2, the default is "50000". For Oracle, the default is "1521". For Postgresql, the default is "5432".
aaedb.DATABASE_PORT="5432"

## The parameter is used to support database connection over SSL for database. Default value is "true"
aaedb.DATABASE_SSL_ENABLE="True"
 
## Whether your PostgreSQL database enables server only or both server and client authentication. Default value is "True" for enabling both server and client authentication, "False" is for enabling server-only authentication.
aaedb.POSTGRESQL_SSL_CLIENT_SERVER="False"

## The name of the secret that contains the DB2/Oracle/MSSQLServer/PostgreSQL SSL certificate.
aaedb.DATABASE_SSL_SECRET_NAME="ibm-cp4ba-db-ssl-secret-for-aaedb"

## If POSTGRESQL_SSL_CLIENT_SERVER is "True" and DATABASE_SSL_ENABLE is "True", please get "<your-server-certification: root.crt>" "<your-client-certification: client.crt>" "<your-client-key: client.key>" from server and client, and copy into this directory.Default value is "/cp4ba/501/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs/cert-kubernetes/scripts/cp4ba-prerequisites/propertyfile/cert/db/cloudpak8".

## If POSTGRESQL_SSL_CLIENT_SERVER is "False" and DATABASE_SSL_ENABLE is "True", please get the SSL certificate file (rename db-cert.crt) from server and then copy into this directory.Default value is "/cp4ba/501/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs/cert-kubernetes/scripts/cp4ba-prerequisites/propertyfile/cert/db/cloudpak8".
aaedb.DATABASE_SSL_CERT_FILE_FOLDER="$CERTKUBE/scripts/cp4ba-prerequisites/propertyfile/cert/db/aaedb"

####################################################
## Property for Database Server "bawdb" required by IBM Cloud Pak for Business Automation on postgresql type database ##
####################################################
## Provide the database type from your infrastructure. The possible values are "db2" or "db2HADR" or "oracle" or "sqlserver" "postgresql".
bawdb.DATABASE_TYPE="postgresql"

## Provide the database server name or IP address of the database server.
bawdb.DATABASE_SERVERNAME="cluster-bawdb-rw.$namespace.svc.cluster.local"

## Provide the database server port. For Db2, the default is "50000". For Oracle, the default is "1521". For Postgresql, the default is "5432".
bawdb.DATABASE_PORT="5432"

## The parameter is used to support database connection over SSL for database. Default value is "true"
bawdb.DATABASE_SSL_ENABLE="True"
 
## Whether your PostgreSQL database enables server only or both server and client authentication. Default value is "True" for enabling both server and client authentication, "False" is for enabling server-only authentication.
bawdb.POSTGRESQL_SSL_CLIENT_SERVER="False"

## The name of the secret that contains the DB2/Oracle/MSSQLServer/PostgreSQL SSL certificate.
bawdb.DATABASE_SSL_SECRET_NAME="ibm-cp4ba-db-ssl-secret-for-bawdb"

## If POSTGRESQL_SSL_CLIENT_SERVER is "True" and DATABASE_SSL_ENABLE is "True", please get "<your-server-certification: root.crt>" "<your-client-certification: client.crt>" "<your-client-key: client.key>" from server and client, and copy into this directory.Default value is "/cp4ba/501/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs/cert-kubernetes/scripts/cp4ba-prerequisites/propertyfile/cert/db/cloudpak9".

## If POSTGRESQL_SSL_CLIENT_SERVER is "False" and DATABASE_SSL_ENABLE is "True", please get the SSL certificate file (rename db-cert.crt) from server and then copy into this directory.Default value is "/cp4ba/501/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs/cert-kubernetes/scripts/cp4ba-prerequisites/propertyfile/cert/db/cloudpak9".
bawdb.DATABASE_SSL_CERT_FILE_FOLDER="$CERTKUBE/scripts/cp4ba-prerequisites/propertyfile/cert/db/bawdb"
