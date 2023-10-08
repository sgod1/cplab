#!/bin/bash -x

pod=$1

db=$2
tsu=$3
ts=$4

tsloc="/var/lib/postgresql/data/ts"

cmd1="create tablespace $ts owner $tsu location $tsloc"
cmd2="grant create on tablespace $ts to $tsu"

oc exec $pod -- mkdir -p "$tsloc"
oc exec $pod -- psql -d $db -U postgres -c "$cmd1"
oc exec $pod -- psql -d $db -U postgres -c "$cmd2"
