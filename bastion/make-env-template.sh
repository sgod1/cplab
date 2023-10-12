#!/bin/bash

# environment template for make.sh script
# copy this file to make-env.sh and pass to make.sh, or run . make-env.sh

# set to 'trace' to turn make.sh tracing on
export MKTRACE="trace"

# build location, outside of git tree, required
# contains oc_tar, case_tar
export BUILDDIR="<required>"

# cplab git root directory
export GIT_ROOT="<required>"

# cloud pak entitlement key, required
export IBM_ENTITLEMENT_KEY="<required>"

# oc tar name at $builddir location, if not default, optional
# export OC_TAR="<optional>"

# case tar name at $builddir location, if not default, optional
# export CASE_TAR="<optional>"

# openldap namespace, optional
# export OPENLDAP_NS="<optional>"

# bastion shell namespace, optional
# export BASTION_NS="<optional>"
