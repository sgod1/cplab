#!/bin/bash

envfile=$1
outfile=$2

# read env file
. $envfile

cat <<EOF > $outfile
## cp4ba_db_name_user.property
####################################################
## FNCM's Property for GCD Database Name and User on postgresql type database ##
####################################################
## Provide the name of the database for the GCD of P8Domain. For example: "GCDDB"
cloudpak.GCD_DB_NAME="gcddb"
## Provide the user name of the database for the GCD of P8Domain. For example: "dbuser1"
cloudpak.GCD_DB_USER_NAME="gcd_user"
## Provide the password of the database user for the GCD of P8Domain.
cloudpak.GCD_DB_USER_PASSWORD="$gcddb"

###################################################
## FNCM's Property for Object store Database Name and User on postgresql type database ##
###################################################
## Provide the name of the database for the object store required by BAW authoring or BAW Runtime. For example: "BAWDOCS"
cloudpak.BAWDOCS_DB_NAME="bawdocs"
## Provide the user name for the object store database required by BAW authoring or BAW Runtime. For example: "dbuser1"
cloudpak.BAWDOCS_DB_USER_NAME="bawdocs_user"
## Provide the password for the user of Object Store of P8Domain.
cloudpak.BAWDOCS_DB_USER_PASSWORD="$bawdocs"

## Provide the name of the database for the object store required by BAW authoring or BAW Runtime. For example: "BAWDOS"
cloudpak.BAWDOS_DB_NAME="bawdos"
## Provide the user name for the object store database required by BAW authoring or BAW Runtime. For example: "dbuser1"
cloudpak.BAWDOS_DB_USER_NAME="bawdos_user"
## Provide the password for the user of Object Store of P8Domain.
cloudpak.BAWDOS_DB_USER_PASSWORD="$bawdos"

## Provide the name of the database for the object store required by BAW authoring or BAW Runtime. For example: "BAWTOS"
cloudpak.BAWTOS_DB_NAME="bawtos"
## Provide the user name for the object store database required by BAW authoring or BAW Runtime. For example: "dbuser1"
cloudpak.BAWTOS_DB_USER_NAME="bawtos_user"
## Provide the password for the user of Object Store of P8Domain.
cloudpak.BAWTOS_DB_USER_PASSWORD="$bawtos"

## Provide the name of the database for Case History when Case History Emitter is enabled. For example: "CHOS"
cloudpak.CHOS_DB_NAME="chosdb"
## Provide the user name for the object store database required by Case History when Case History Emitter is enabled. For example: "dbuser1"
cloudpak.CHOS_DB_USER_NAME="chos_user"
## Provide the password for the user of Object Store of P8Domain.
cloudpak.CHOS_DB_USER_PASSWORD="$chosdb"

####################################################
## BAN's Property for ICN Database Name and User on postgresql type database ##
####################################################
## Provide the name of the database for ICN (Navigator). For example: "ICNDB"
cloudpak.ICN_DB_NAME="icndb"
## Provide the user name of the database for ICN (Navigator). For example: "dbuser1"
cloudpak.ICN_DB_USER_NAME="icn_user"
## Provide the password of the database user for ICN (Navigator). 
cloudpak.ICN_DB_USER_PASSWORD="$icndb"

####################################################
## Business Automation Studio's Property for Studio database required on postgresql type database ##
####################################################
## Provide the database name for Business Automation Studio database . For example: "BASDB"
cloudpak.STUDIO_DB_NAME="basdb"
## Provide the user name of the database for the Business Automation Studio database. For example: "dbuser1"
cloudpak.STUDIO_DB_USER_NAME="bas_user"
## Provide the password for the user of Business Automation Studio database.
cloudpak.STUDIO_DB_USER_PASSWORD="$basdb"
EOF