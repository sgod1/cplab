#!/bin/bash

pod=$1
env=$2

# read env file
. $env

db="basdb"
user="bas_user"
password="$basdb"

./pod-create-database.sh $pod $db $user $password

cmd="CREATE SCHEMA IF NOT EXISTS $user AUTHORIZATION $user"
echo "cmd => " $cmd
oc exec $pod -c postgres  -- psql -d $db -U $user -c "$cmd"
