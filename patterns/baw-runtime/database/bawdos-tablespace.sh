#!/bin/bash

pod=$1

db="bawdos"
tsu="bawdos_user"
ts="bawdos_tbs"

./pod-create-tablespace.sh $pod $db $tsu $ts
