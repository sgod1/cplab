envfile=$1
outfile=$2
. $envfile
cat <<EOF >$outfile
## cp4ba_db_name_user.property 
==================================================================================================================
NOTES: Please change the "<DB_SERVER_NAME>" variable to assign each database to a database server or instance.
       The "<DB_SERVER_NAME>" must be in [gcddb bawdocs bawdos bawtos chosdb aeosdb icndb aaedb bawdb]
==================================================================================================================

####################################################
## FNCM's Property for GCD Database Name and User on postgresql type database ##
####################################################
## Provide the name of the database for the GCD of P8Domain. For example: "GCDDB"
gcddb.GCD_DB_NAME="GCDDB"
## Provide the user name of the database for the GCD of P8Domain. For example: "dbuser1"
gcddb.GCD_DB_USER_NAME="gcd_user"
## Provide the password of the database user for the GCD of P8Domain.
gcddb.GCD_DB_USER_PASSWORD="$gcddb"

###################################################
## FNCM's Property for Object store Database Name and User on postgresql type database ##
###################################################
## Provide the name of the database for the object store required by BAW authoring or BAW Runtime. For example: "BAWDOCS"
bawdocs.BAWDOCS_DB_NAME="BAWDOCS"
## Provide the user name for the object store database required by BAW authoring or BAW Runtime. For example: "dbuser1"
bawdocs.BAWDOCS_DB_USER_NAME="bawdocs_user"
## Provide the password for the user of Object Store of P8Domain.
bawdocs.BAWDOCS_DB_USER_PASSWORD="$bawdocs"

## Provide the name of the database for the object store required by BAW authoring or BAW Runtime. For example: "BAWDOS"
bawdos.BAWDOS_DB_NAME="BAWDOS"
## Provide the user name for the object store database required by BAW authoring or BAW Runtime. For example: "dbuser1"
bawdos.BAWDOS_DB_USER_NAME="bawdos_user"
## Provide the password for the user of Object Store of P8Domain.
bawdos.BAWDOS_DB_USER_PASSWORD="$bawdos"

## Provide the name of the database for the object store required by BAW authoring or BAW Runtime. For example: "BAWTOS"
bawtos.BAWTOS_DB_NAME="BAWTOS"
## Provide the user name for the object store database required by BAW authoring or BAW Runtime. For example: "dbuser1"
bawtos.BAWTOS_DB_USER_NAME="bawtos_user"
## Provide the password for the user of Object Store of P8Domain.
bawtos.BAWTOS_DB_USER_PASSWORD="$bawtos"

## Provide the name of the database for Case History when Case History Emitter is enabled. For example: "CHOS"
chosdb.CHOS_DB_NAME="CHOS"
## Provide the user name for the object store database required by Case History when Case History Emitter is enabled. For example: "dbuser1"
chosdb.CHOS_DB_USER_NAME="chos_user"
## Provide the password for the user of Object Store of P8Domain.
chosdb.CHOS_DB_USER_PASSWORD="$chosdb"

## Provide the name of the database for the object store required by AE Data Persistent. For example: "AEOS"
aeosdb.AEOS_DB_NAME="AEOS"
## Provide the user name of the database for the object store required by AE Data Persistent. For example: "dbuser1"
aeosdb.AEOS_DB_USER_NAME="aeos_user"
## Provide the password for the user of Object Store of P8Domain. 
aeosdb.AEOS_DB_USER_PASSWORD="$aeosdb"

####################################################
## BAN's Property for ICN Database Name and User on postgresql type database ##
####################################################
## Provide the name of the database for ICN (Navigator). For example: "ICNDB"
icndb.ICN_DB_NAME="ICNDB"
## Provide the user name of the database for ICN (Navigator). For example: "dbuser1"
icndb.ICN_DB_USER_NAME="icn_user"
## Provide the password of the database user for ICN (Navigator). 
icndb.ICN_DB_USER_PASSWORD="$icndb"

####################################################
## Application Engine's Property for Application Engine database required on postgresql type database ##
####################################################
## Provide the database name for runtime application engine. For example: "AAEDB"
aaedb.APP_ENGINE_DB_NAME="AAEDB"
## Provide the user name of the database for the Application Engine database. For example: "dbuser1"
aaedb.APP_ENGINE_DB_USER_NAME="aae_user"
## Provide the password for the user of Application Engine database. 
aaedb.APP_ENGINE_DB_USER_PASSWORD="$aaedb"

####################################################
## Business Automation Workflow Runtime's Property for database on postgresql ##
####################################################
## Provide the user name of the database for Business Automation Workflow Runtime. For example: "dbuser1"
bawdb.BAW_RUNTIME_DB_USER_NAME="baw_user"
## Provide the password for the user of database for Business Automation Workflow Runtime .
bawdb.BAW_RUNTIME_DB_USER_PASSWORD="$bawdb"
## Provide the database name for Business Automation Workflow Runtime. For example: "BAWDB"
bawdb.BAW_RUNTIME_DB_NAME="BAWDB"
## Provide the schema name that is used to qualify unqualified database objects in dynamically prepared SQL statements when
## the schema name is different from the user name of the database for Business Automation Workflow.
bawdb.BAW_RUNTIME_DB_CURRENT_SCHEMA="baw_user"
EOF