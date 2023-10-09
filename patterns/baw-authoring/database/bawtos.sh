#!/bin/bash

pod=$1
env=$2

# read env file
. $env

db="bawtos"
user="bawtos_user"
password="$bawtos"

tbs="bawtos_tbs"

./pod-create-database.sh $pod $db $user $password
./pod-create-tablespace.sh $pod $db $user $tbs
