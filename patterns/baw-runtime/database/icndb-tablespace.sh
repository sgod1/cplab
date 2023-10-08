#!/bin/bash

pod=$1

db="icndb"
tsu="icn_user"
ts="icndb_tbs"

./pod-create-tablespace.sh $pod $db $tsu $ts
