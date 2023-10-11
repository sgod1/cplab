#!/bin/bash -x

token=${1:-"null-token"}

echo $token > auth-token

oc start-build bastion --from-dir . --follow

