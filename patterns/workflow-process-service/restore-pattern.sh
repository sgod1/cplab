#!/bin/bash -x

currdir=`pwd`
basedir=${WPS_GIT:$currdir}

# copy prereq property files
$basedir/prereq/copy-properties.sh

# copy genereated cr
$basedir/generated-cr/copy-cr.sh

# copy kustomize
$basedir/kustomize/copy-kustomize.sh

# apply production overlay
cd $SCRIPTS/kustomize

oc kustomize overlay/prod > kustomized-cr-prod.yaml

# apply dev overlay
oc kustomize overlay/dev > kustomized-cr-dev.yaml

cd $currdir
