#!/bin/bash

pod=$1
env=$2

# read env file
. $env

db="bawdocs"
user="bawdocs_user"
password="$bawdocs"

tbs="bawdocs_tbs"

./pod-create-database.sh $pod $db $user $password
./pod-create-tablespace.sh $pod $db $user $tbs
