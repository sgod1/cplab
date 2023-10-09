#!/bin/bash

pod=$1
env=$2

# read env file
. $env

db="gcddb"
user="gcd_user"
password="$gcddb"

tbs="gcddb_tbs"

./pod-create-database.sh $pod $db $user $password
./pod-create-tablespace.sh $pod $db $user $tbs
