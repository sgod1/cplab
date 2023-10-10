#!/bin/bash -x

# example: authorize-pull-image-from.sh bastion

from=${1:-"bastion"}
to=${2:-`oc project --short`}

oc policy add-role-to-user system:image-puller system:serviceaccount:"$to":default --namespace=$from