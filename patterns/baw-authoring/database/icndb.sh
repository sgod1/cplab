#!/bin/bash

pod=$1
env=$2

# read env file
. $env

db=icndb
user=icn_user
password=$icndb

tbs=icndb_tbs

./pod-create-database.sh $pod $db $user $password
./pod-create-tablespace.sh $pod $db $user $tbs
