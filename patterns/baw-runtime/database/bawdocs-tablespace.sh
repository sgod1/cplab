#!/bin/bash

pod=$1

db="bawdocs"
tsu="bawdocs_user"
ts="bawdocs_tbs"

./pod-create-tablespace $pod $db $tsu $ts
