#!/bin/bash

pod=$1
db=$2
user=$3
password=$4

# cat ban/postgresql/cloudpak/createICNDB.sql 
# create user 
cmd="CREATE ROLE $user WITH INHERIT LOGIN ENCRYPTED PASSWORD '$password'"
echo "cmd => " $cmd
oc exec $pod -c postgres  -- psql -d postgres -U postgres -c "$cmd"

# create database
cmd="create database $db owner $user template template0 encoding UTF8"
echo "cmd => " $cmd
oc exec $pod -c postgres  -- psql -d postgres -U postgres -c "$cmd"

cmd="revoke connect on database $db from public"
echo "cmd => " $cmd
oc exec $pod -c postgres  -- psql -d $db -U postgres -c "$cmd"

cmd="grant all privileges on database $db to $user"
echo "cmd => " $cmd
oc exec $pod -c postgres  -- psql -d $db -U postgres -c "$cmd"

cmd="grant connect, temp, create on database $db to $user"
echo "cmd => " $cmd
oc exec $pod -c postgres  -- psql -d $db -U postgres -c "$cmd"
