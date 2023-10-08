#!/bin/bash

pod=$1

db="bawtos"
tsu="bawtos_user"
ts="pg_default"

./pod-create-tablespace $pod $db $tsu $ts
