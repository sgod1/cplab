### Deploying CP4BA Cloud-Pak Operator steps

> Lab steps.<br/>
> Run `$CASEGEN/install-cp4ba-operator.sh` script to install CP4BA multipattern operator.<br/>

```
$CASEGEN/install-cp4ba-operators.sh
```

> Optional<br/>
Review steps to install cloud pak operator.<br/>
If you did not run deploy-cp4ba-operators.sh script, you can manually execute steps.<br/>

To deploy cloud pak operator we create *CatalogSources*, *OperatorGroup*, and cloud pak operator *Subscription*.<br/>

All yaml files are included in the $OPOLM directory within case package.<br/>

> Create cp4ba project.<br/>
```
oc new-project cp4ba
```

#### Create Catalog Sources.
> Create catalog sources.<br/>

Change to the `$OPOLM` directory and examine `catalog_source.yaml` file.<br/>

```
cd $OPOLM
cat catalog_source.yaml
```

Note that catalog sources are release specific.<br/>

Catalog sources are created in the `openshift-marketplace` namespace.<br/>

> Apply catalog_sources.yaml.<br/>

```
oc project cp4ba
oc apply -f $OPOLM/catalog_source.yaml
```

> View catalog sources.<br/>

```
oc get CatalogSource -n openshift-marketplace
```

#### Install Signletons.
> install `Singleton` services.

`Singleton` services are *IBM Certificate Manager* service, and *IBM License* service.<br/>
These services are required.<br/>

Change to `$CP3PT0` directory and run `setup_singleton.sh` script.<br/>
Wait for the script to complete.<br/>

```
cd $CP3PT0

./setup_singleton.sh --enable-licensing --license-accept
```

View output:<br/>

```
./setup_singleton.sh --enable-licensing --license-accept
[✔] oc command available
[✔] oc command logged in as kube:admin
[✔] Channel is valid
# Installing cert-manager

# Creating namespace ibm-cert-manager

namespace/ibm-cert-manager created
[INFO] Checking existing OperatorGroup in ibm-cert-manager:

[INFO] Creating following OperatorGroup:

apiVersion: operators.coreos.com/v1
kind: OperatorGroup
metadata:
  name: ibm-cert-manager-operator
  namespace: ibm-cert-manager
spec: {}
operatorgroup.operators.coreos.com/ibm-cert-manager-operator created

[INFO] Creating following Subscription:

apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: ibm-cert-manager-operator
  namespace: ibm-cert-manager
spec:
  channel: v4.0
  installPlanApproval: Automatic
  name: ibm-cert-manager-operator
  source: ibm-cert-manager-catalog
  sourceNamespace: openshift-marketplace
subscription.operators.coreos.com/ibm-cert-manager-operator created
[INFO] Waiting for operator ibm-cert-manager-operator in namespace ibm-cert-manager to be made available
[INFO] RETRYING: Waiting for operator ibm-cert-manager-operator in namespace ibm-cert-manager to be made available (50 left)
[INFO] RETRYING: Waiting for operator ibm-cert-manager-operator in namespace ibm-cert-manager to be made available (49 left)
[INFO] RETRYING: Waiting for operator ibm-cert-manager-operator in namespace ibm-cert-manager to be made available (48 left)
[✔] Operator ibm-cert-manager-operator in namespace ibm-cert-manager is available
certmanagerconfig.operator.ibm.com/default patched
[INFO] License accepted for certmanagerconfig.operator.ibm.com default.
# Installing licensing

# Creating namespace ibm-licensing

namespace/ibm-licensing created
[INFO] Checking existing OperatorGroup in ibm-licensing:


[INFO] Creating following OperatorGroup:

apiVersion: operators.coreos.com/v1
kind: OperatorGroup
metadata:
  name: ibm-licensing-operator-app
  namespace: ibm-licensing
spec:         
  targetNamespaces:
    - ibm-licensing
operatorgroup.operators.coreos.com/ibm-licensing-operator-app created

[INFO] Creating following Subscription:

apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: ibm-licensing-operator-app
  namespace: ibm-licensing
spec:
  channel: v4.0
  installPlanApproval: Automatic
  name: ibm-licensing-operator-app
  source: ibm-licensing-catalog
  sourceNamespace: openshift-marketplace
subscription.operators.coreos.com/ibm-licensing-operator-app created
[INFO] Waiting for operator ibm-licensing-operator in namespace ibm-licensing to be made available
[INFO] RETRYING: Waiting for operator ibm-licensing-operator in namespace ibm-licensing to be made available (50 left)
[✔] Operator ibm-licensing-operator in namespace ibm-licensing is available
[INFO] 
[INFO] RETRYING:  (20 left)
[✔] ibmlicensing instance present
ibmlicensing.operator.ibm.com/instance patched
[INFO] License accepted for ibmlicensing instance
```

> Create operator group for `cp4ba` namespace:
Note that namespace in original `operator_group.yaml` is templated.

```
cd $CERTKUBE/descriptors/op-olm
```

```
cat <<EOF > operator_group.yaml
apiVersion: operators.coreos.com/v1alpha2
kind: OperatorGroup
metadata:
  name: ibm-cp4a-operator-catalog-group
  namespace: cp4ba
spec:
  targetNamespaces:
  - cp4ba
EOF
```

```
oc project cp4ba
oc apply -f $CERTKUBE/descriptors/op-olm/operator_group.yaml
```

#### Subsribe to cloud pak operator in 'one namespace' mode.

> Subscribe to cloud-pak CP4BA multipattern operator

Cloud-pak operator can be installed in 'all namespaces' mode, or in 'one namespace' mode.

The mode of installation plays important role in cloud-pak multitenancy configuration.

'all namespaces' mode will install foundational services in 'all namespaces' mode, and all other cloudpaks will have to be installed in 'all-namespaces' mode.
All permissions for cloudpaks and foundational services are escalated to the cluster permissions in this mode.
Workload isolation is not possible in this mode. This is so called 'single tenant cluster'.

```
cd $OPOLM
```

Note that original `subscription.yaml` file is templated for namespace.

```
cat <<EOF > subscription.yaml
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: ibm-cp4a-operator-catalog-subscription
  namespace: cp4ba
spec:
  channel: v23.1
  name: ibm-cp4a-operator
  installPlanApproval: Automatic
  source: ibm-cp4a-operator-catalog
  sourceNamespace: openshift-marketplace
EOF
```

```
cd $CERTKUBE/descriptors/$OPOLM
oc project cp4ba

oc apply -f subscription.yaml
```

> Watch for events.

```
oc get events --watch
```

Query insalled operators.<br/>

```
oc get csv
```

```
NAME                                          DISPLAY                                                       VERSION   REPLACES                         PHASE

ibm-ads-operator.v23.1.2                      IBM CP4BA Automation Decision Service                         23.1.2                                     Succeeded
ibm-cert-manager-operator.v4.1.0              IBM Cert Manager                                              4.1.0                                      Succeeded
ibm-common-service-operator.v4.1.0            IBM Cloud Pak foundational services                           4.1.0                                      Succeeded
ibm-content-operator.v23.1.2                  IBM CP4BA FileNet Content Manager                             23.1.2                                     Succeeded
ibm-cp4a-operator.v23.1.2                     IBM Cloud Pak for Business Automation (CP4BA) multi-pattern   23.1.2                                     Succeeded
ibm-cp4a-wfps-operator.v23.1.2                IBM CP4BA Workflow Process Service                            23.1.2                                     Succeeded
ibm-dpe-operator.v23.1.2                      IBM Document Processing Engine                                23.1.2                                     Succeeded
ibm-insights-engine-operator.v23.1.2          IBM CP4BA Insights Engine                                     23.1.2                                     Succeeded
ibm-odm-operator.v23.1.2                      IBM Operational Decision Manager                              23.1.2                                     Succeeded
ibm-pfs-operator.v23.1.2                      IBM CP4BA Process Federation Server                           23.1.2                                     Succeeded
icp4a-foundation-operator.v23.1.2             IBM CP4BA Foundation                                          23.1.2                                     Succeeded
operand-deployment-lifecycle-manager.v4.1.0   Operand Deployment Lifecycle Manager                          4.1.0                                      Succeeded
```
