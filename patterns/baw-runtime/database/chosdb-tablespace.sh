#!/bin/bash

pod=$1

db="chosdb"
tsu="chos_user"
ts="chosdb_tbs"

./pod-create-tablespace $pod $db $tsu $ts
