#!/bin/bash -x

BUILDDIR=$1

mkdir -p $BUILDDIR

cp ./Dockerfile $BUILDDIR
cp ./create-bastion-buildconfig.sh $BUILDDIR
cp ./build-bastion.sh $BUILDDIR
cp ./clone-git-repo.sh $BUILDDIR
cp ./oc-login.sh $BUILDDIR
cp ./set-cloudpak-project.sh $BUILDDIR
