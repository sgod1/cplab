#!/bin/bash

key=$1
ns=${2:-`oc project --short`}
email=${3:-"admin@cloudpak.com"}

secret="ibm-entitlement-key"
registry="cp.icr.io"
user="cp"

oc -n $ns create secret docker-registry $secret --docker-server=$registry --docker-username=$user --docker-password=$key --docker-email=$email
