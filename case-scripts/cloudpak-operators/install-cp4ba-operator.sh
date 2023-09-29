#!/bin/bash -x

CP4BA=cp4ba

# create cloud pak project
oc new-project $CP4BA

# create catalog sources
oc apply -f $OPOLM/catalog_source.yaml

# install singleton services
$CP3PT0/setup_singleton.sh --enable-licensing --license-accept

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

oc apply $OPOLM/cp4ba_operator_group.yaml

# subscribe to cloud pak operator in one-namespace mode
CHANNEL="v23.1"

cat <<EOF > cp4ba_subscription.yaml
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
