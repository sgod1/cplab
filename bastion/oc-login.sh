#!/bin/bash -x

oc login api:6443 --insecure-skip-tls-verify=true --token=`cat auth-token`
