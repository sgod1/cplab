#!/bin/bash

pod=$1

db="bawtos"
tsu="bawtos_user"
ts="pg_default"

./pod-create-tablespace.sh $pod $db $tsu $ts
