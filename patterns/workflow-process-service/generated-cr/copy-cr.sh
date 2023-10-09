#!/bin/bash -x

cr=${1:-"ibm_cp4a_cr_final.yaml"}

COPYDIR=$SCRIPTS/generated-cr

mkdir -p $COPYDIR
cp $cr $COPYDIR
