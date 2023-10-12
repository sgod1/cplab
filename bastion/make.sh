#!/bin/bash

# env vars: <BUILDDIR>, GIT_ROOT, IBM_ENTITLEMENT_KEY, OC_TAR, CASE_TAR, <OPENLDAP_NS>, <BASTION_NS>, <MKTRACE>

envfile=$1

if [[ -z $envfile ]]; then
    echo input environment file required
    exit 1
fi

# load env file
. $envfile

if [[ $MKTRACE == "trace" ]]; then
    echo turing trace on
    set -x
fi

currdir=`pwd`
currproj=`oc project --short`

builddir=$BUILDDIR
gitroot=$GIT_ROOT
ibmkey=$IBM_ENTITLEMENT_KEY

openldap_ns=${OPENLDAP_NS:-"openldap"}
bastion_ns=${BASTION_NS:-"bastion"}
cp1_ns="cp4ba1"
cp2_ns="cp4ba2"

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

# create all required projects
oc new-project $bastion_ns
oc new-project $openldap_ns
oc new-project $cp1_ns
oc new-project $cp2_ns

# copy build scripts to build dir
cd $gitroot/bastion
./copy-build-scripts.sh $builddir

# build bastion container image
oc project $bastion_ns

cd $builddir
./create-bastion-buildconfig.sh

authtoken=`oc whoami -t`
./build-bastion.sh $authtoken

# deploy openldap container to openldap ns
oc project $openldap_ns

cd $gitroot/openldap
./deploy-bitnami-openldap.sh $openldap_ns

# cloud pak project 1
oc project $cp1_ns

cd $gitroot/bastion
./create-entitlement-key.sh $ibmkey $cp1_ns
./authorize-pull-image-from.sh $bastion_ns

# cloud pak project 2
oc project $cp2_ns

cd $gitroot/bastion
./create-entitlement-key.sh $ibmkey $cp2_ns
./authorize-pull-image-from.sh $bastion_ns

cd $currdir
oc project $currproj

echo Make complete
