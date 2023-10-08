#!/bin/bash

pod=$1

db="aeosdb"
tsu="aeos_user"
ts="aeosdb_tbs"

./pod-create-tablespace.sh $pod $db $tsu $ts
