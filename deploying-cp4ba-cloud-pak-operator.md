### Cloud Pak Operators

> Complete `deploy cloud pak operator steps`. (Required)

> Query installed operators.

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

Why do we see so many operators when we subscribed to just one cloud-pak opearator, ibm-cp4a-operator.v23.1.2?

The answer is that `ibm-cp4a-operator.v23.1.2` operator depends on other operators.

Dependencies are declared in operator's csv.

#### This is key
CSV declared operator dependencies are *static*.

Static dependency means that when we subscribe to an operator version, we also subscribe to all dependent operators versions.

Static operator dependencies is a powerful feature, but it assumes that we know all dependencies at subsciption time.

Some capabilities required by the operator for Cloud Pak CR are dynamic, not known ahead of time, and other capabilities may have to be shared between services.

For example, Cloud Pak may require different versions of databases based on CR, on prem or in-cluster, or may require a shared service like identity management.

#### This is key
To satisfy cloud pak operator requirements for Cloud Pak CR we need shared and dynamic operator dependency management for operators and their operands.

Most cloud pak operator dependencies are operators for automation capabilities, such as FileNet, Document Processing, etc. 

There are 2 operators that do not fall into this category: `ibm-common-service-operator`, and `operand-deployment-lifecycle-manager` operator.<br/>
Operand Deployment Lifecycle Manager `(ODLM)` resolves dynamic and shared dependencies, requested by the cloud pak for CR.<br/>
Common Services operator is a bridge between cloud pak operator and dynamic capabilities of ODLM.<br/>

#### Apply Kustomized CR.

> Change to `$CERTKUBE/kustomize` directory and apply `production` overlay.

We can pass kustomize output to `oc appy` directly, but here we save kustomized CR and apply it in a separate step.

```
cd $CERTKUBE/kustomize

oc kustomize overlay/prod > kustomized-cr-prod.yaml

oc project cp4ba

oc apply -f kustomized-cr-prod.yaml 
icp4acluster.icp4a.ibm.com/icp4adeploy created
```

Watch for events

```
oc get events --watch
```

It will take some time to complete.

If you look at the event output you will see that new operator subscriptions are dynamically created, together with new CR's, and operand services become online.<br/>
When all is complete, ICP4ACluster CR is in the `ready` state and we can log into Cloud Pak console.

We discuss how this works next.
