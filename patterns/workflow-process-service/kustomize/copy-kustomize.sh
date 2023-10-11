#!/bin/bash -x

KUST=$SCRIPTS/kustomize

basedir=`pwd`
if [[ ! -z $WPS_GIT ]]; then
    basedir=$WPS_GIT/kustomize
fi

mkdir -p $KUST

cp -r $basedir/base $KUST
cp -r $basedir/overlay $KUST

cr="ibm_cp4a_cr_final.yaml"

# copy generated cr to kustomize
if [[ -f $SCRIPTS/generated-cr/$cr ]]
then
    # copy from scripts
    cp $SCRIPTS/generated-cr/$cr $KUST/base
else
    # copy from git
    cp $WPS_GIT/generated-cr/$cr $KUST/base
fi
