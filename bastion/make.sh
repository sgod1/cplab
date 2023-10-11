#!/bin/bash

# env vars: <BUILDDIR>, GIT_ROOT, IBM_ENTITLEMENT_KEY, OC_TAR, CASE_TAR, <OPENLDAP_NS>, <BASTION_NS>, <MKTRACE>

if [[ $MKTRACE == "trace" ]]; then
    echo turing trace on
    set -x
fi

currdir=`pwd`

builddir=${1:-$BUILDDIR}
gitroot=$GIT_ROOT
ibmkey=$IBM_ENTITLEMENT_KEY
openldap_ns=${OPENLDAP_NS:-"openldap"}
bastion_ns=${BASTION_NS:-"bastion"}

octar=${OC_TAR:-"oc-4.12.35-linux.tar.gz"}
casetar=${CASE_TAR:-"ibm-cp-automation-5.0.1.tgz"}

if [[ ! -d $builddir ]]; then
    echo Build directory "$builddir" does not exist
    exit 1
fi

if [[ ! -f $builddir/$octar ]]; then
    echo Openshfit binary tar "$builddir/$octar" not found
    exit 1
fi

if [[ ! -f $builddir/$casetar ]]; then
    echo Cloud pak case tar "$builddir/$casetar" not found
    exit 1
fi

if [[ -z $ibmkey ]]; then
    echo IBM_ENTITLEMENT_KEY variable requred
    exit 1
fi

if [[ -z $gitroot ]]; then
    echo GIT_ROOT variable required
    exit 1
fi

# copy build scripts to build dir
cd $gitroot/bastion
./copy-build-scripts.sh $builddir

# build bastion container image
cd $builddir
./create-bastion-buildconfig.sh

authtoken=`oc whoami -t`
./build-bastion.sh $authtoken

# deploy openldap container to openldap ns
cd $gitroot/openldap
./deploy-bitnami-openldap.sh $openldap_ns

# create cloud pak project 1
cp_ns="cp4ba1"
oc new-project $cp_ns

cd $gitroot/bastion
./create-entitlement-key.sh $ibmkey $cp_ns
./authorize_pull_image_from.sh $bastion_ns

# create cloud pak project 2
cp_ns="cp4ba1"
oc new-project $cp_ns

cd $gitroot/bastion
./create-entitlement-key.sh $ibmkey $cp_ns
./authorize_pull_image_from.sh $bastion_ns

cd $currdir

echo Make complete
