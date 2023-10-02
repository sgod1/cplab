#!/bin/bash -x

CP4BA=cp4ba

# set a project
oc project $CP4BA

# step 1:
# create catalog sources
oc apply -f $OPOLM/catalog_source.yaml

# step 2:
# install singleton services
$CP3PT0/setup_singleton.sh --enable-licensing --license-accept

# step 3:
# create operator group
cat <<EOF > $OPOLM/cp4ba_operator_group.yaml
apiVersion: operators.coreos.com/v1alpha2
kind: OperatorGroup
metadata:
  name: ibm-cp4a-operator-catalog-group
  namespace: $CP4BA
spec:
  targetNamespaces:
  - $CP4BA
EOF

oc apply -f $OPOLM/cp4ba_operator_group.yaml

# step 5:
# subscribe to cloud pak operator in one-namespace mode
CHANNEL="v23.1"

cat <<EOF > $OPOLM/cp4ba_subscription.yaml
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: ibm-cp4a-operator-catalog-subscription
  namespace: $CP4BA
spec:
  channel: $CHANNEL
  name: ibm-cp4a-operator
  installPlanApproval: Automatic
  source: ibm-cp4a-operator-catalog
  sourceNamespace: openshift-marketplace
EOF

oc apply -f $OPOLM/cp4ba_subscription.yaml
