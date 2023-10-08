#!/bin/bash

pod=$1

db="icndb"
tsu="icn_user"
ts="icndb_tbs"

./pod-create-tablespace $pod $db $tsu $ts
