#!/bin/bash -x

cloudpak_project=${1:-"cp4ba1"}

export CLOUDPAK_PROJECT=$cloudpak_project
oc project $cloudpak_project
