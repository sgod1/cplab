#!/bin/bash

pod=$1

db="bawdocs"
tsu="bawdocs_user"
ts="bawdocs_tbs"

./pod-create-tablespace.sh $pod $db $tsu $ts
