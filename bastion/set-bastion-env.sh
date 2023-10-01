#!/bin/bash -x

CASEVERSION=501

export CERTK8s=/cp4ba/$CASEVERSION/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs
export CERTKUBE=$CERTK8s/cert-kubernetes

export PATTERNS=$CERTKUBE/descriptors/patterns
export SCRIPTS=$CERTKUBE/scripts
export CASEGEN=/cp4ba/cplab/case-scripts
export KUST=/cp4ba/cplab/kustomize
export OPOLM=$CERTKUBE/descriptors/op-olm
export CP3PT0=$CERTKUBE/scripts/cpfs/installer_scripts/cp3pt0-deployment
