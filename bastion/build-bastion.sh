#!/bin/bash -x

oc start-build bastion --from-dir . --follow

