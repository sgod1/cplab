#!/bin/bash

pod=$1

db="gcddb"
tsu="gcd_user"
ts="gcddb_tbs"

./pod-create-tablespace $pod $db $tsu $ts
