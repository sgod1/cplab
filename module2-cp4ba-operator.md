### IBM Cloud Pak for Business Automation (CP4BA) multi-pattern operator.

> Lab steps.<br/>
Run a script out of git repo to install CP4BA operator.(*Required*)<br/>

Pass your cloud pak project name as an argument to the script.<br/>

```
$GIT_ROOT/cloudpak-operators/install-cp4ba-operator.sh $CLOUDPAK_PROJECT
```

Script executes standard steps to install CP4BA operator to create catalog sources and operator subscription.<br/>
Catalog sources are release specific.<br/>

CP4BA Operator subscription is created in `one-namespace` mode.<br/>

In `one-namespace` mode operator watches for CRs in the namespace where it is installed, and does not have access to other namespaces.<br/>
For an operator to act and create opearnd deployment, operator CR must be created in the operator namespace.<br/>

In `all namespaces` mode, operator watches all namespaces and CR will trigger operand deployment in any namespace where it is created.<br/>

Choice of operator subscription mode plays important role in multi tenancy and workload isolation.<br/>

> Query installed operators.<br/>
```
oc project cp4ba

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

We installed one `ibm-cp4a-operator.v23.1.2` operator. Why do we see other operators?<br/>

The answer is that `ibm-cp4a-operator.v23.1.2` operator depends on other operators.<br/>

Dependencies are declared in operator's csv.<br/>

#### This is key
CSV declared operator dependencies are *static*.<br/>

Static dependency means that when we subscribe to an operator version, we also subscribe to all dependent operators versions.<br/>

Static operator dependencies is a powerful feature, but it assumes that we know all dependencies at subsciption time.<br/>

Capabilities required by CP4BA CR are not known ahead of time, and may vary depending on the pattern installed.<br/> 
In addition, pattern capabilites must share a set of core foundational services.<br/>

For example, Cloud Pak may require different versions of databases based on CR, on prem or in-cluster, or may require a shared service like identity management.<br/>

#### This is key
To satisfy cloud pak operator requirements we need on-demand subscription management and dependency resolution.<br/>

Most cloud pak operator dependencies are automation capabilities: FileNet, Document Processing, etc.<br/>

There are 2 special operators that support foundational services: `ibm-common-service-operator`, and `operand-deployment-lifecycle-manager` operator.<br/>
Operand Deployment Lifecycle Manager `(ODLM)` resolves dynamic and shared dependencies, requested by the cloud pak for CR.<br/>
Common Services operator is a link between cloud pak operator and dynamic capabilities of ODLM.<br/>

#### Prerequisite: Apply ldap bind secret.
Prerequisites script created ldap bind secret for the directory server.<br/>
This secret is usually applied before property files validation.<br/>

This step was done in module 1.<br/>
```
oc apply -f $SCRIPTS/cp4ba-prerequisites/secret_template/ldap-bind-secret.yaml
```

#### Apply Kustomized CR.

> Note: In module 1, we created kustomizations in `$SCRIPTS/kustomize` directory.<br/>

> Change to `$SCRIPTS/kustomize` directory and apply `production` overlay.<br/>

```
cd $SCRIPTS/kustomize

oc kustomize overlay/prod > kustomized-cr-prod.yaml

oc project cp4ba

oc apply -f kustomized-cr-prod.yaml 
icp4acluster.icp4a.ibm.com/icp4adeploy created
```

Watch for events<br/>

```
oc get events --watch
```

Deployment will take some time to complete.<br/>

If you follow event output you will see that new operator subscriptions are dynamically created, together with new types of CR's, and operand deployments.<br/>
When all is complete, ICP4ACluster CR is in the `ready` state and we can log into the Cloud Pak console.<br/>

We discuss how this works next.<br/>
