#!/bin/bash

pod=$1
env=$2

# read env file
. $env

db="bawdos"
user="bawdos_user"
password="$bawdos"

tbs="bawdos_tbs"

./pod-create-database.sh $pod $db $user $password
./pod-create-tablespace.sh $pod $db $user $tbs
