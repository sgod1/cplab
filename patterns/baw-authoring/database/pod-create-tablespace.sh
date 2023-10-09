#!/bin/bash

pod=$1
db=$2
user=$3
tbs=$4

tsloc="/var/lib/postgresql/data/$tbs"

cmd="mkdir -p $tsloc"
echo "cmd => " $cmd
oc exec $pod -c postgres  -- mkdir -p $tsloc

cmd="create tablespace $tbs owner $user location '$tsloc'"
echo "cmd => " $cmd
oc exec $pod -c postgres  -- psql -d $db -U postgres -c "$cmd"

cmd="grant create on tablespace $tbs to $user"
echo "cmd => " $cmd
oc exec $pod -c postgres  -- psql -d $db -U postgres -c "$cmd"
