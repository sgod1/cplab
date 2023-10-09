#!/bin/bash -x

KUST=$SCRIPTS/kustomize

mkdir -p $KUST

cp -r base $KUST
cp -r overlay $KUST

cr="ibm_cp4a_cr_final.yaml"

if [[ -f $SCRIPTS/generated-cr/$cr ]]
then
    cp $SCRIPTS/generated-cr/$cr $KUST/base
else
    cp $WPS_GIT/generated-cr/$cr $KUST/base
fi
