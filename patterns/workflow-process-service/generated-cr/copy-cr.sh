#!/bin/bash -x

cr=${1:-"ibm_cp4a_cr_final.yaml"}

COPYDIR=$SCRIPTS/generated-cr

basedir=`pwd`
if [[ ! -z $WPS_GIT ]]; then
    basedir=$WPS_GIT/generated-cr
fi

mkdir -p $COPYDIR
cp $basedir/$cr $COPYDIR
