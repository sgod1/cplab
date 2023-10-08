#!/bin/bash

pod=$1

db="bawdos"
tsu="bawdos_user"
ts="bawdos_tbs"

./pod-create-tablespace $pod $db $tsu $ts
