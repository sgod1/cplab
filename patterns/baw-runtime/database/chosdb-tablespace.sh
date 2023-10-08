#!/bin/bash

pod=$1

db="chosdb"
tsu="chos_user"
ts="chosdb_tbs"

./pod-create-tablespace.sh $pod $db $tsu $ts
