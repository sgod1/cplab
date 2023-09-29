#!/bin/bash -x

oc new-build --strategy docker --binary --name bastion
