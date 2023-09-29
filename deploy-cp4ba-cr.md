### Deploy CP4BA CR.

> Complete `Install CP4BA operator steps`. (Required)<br/>

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

Some capabilities required by the operator for Cloud Pak CR are dynamic, not known ahead of time, and other capabilities may have to be shared between services.<br/>

For example, Cloud Pak may require different versions of databases based on CR, on prem or in-cluster, or may require a shared service like identity management.<br/>

#### This is key
To satisfy cloud pak operator requirements for Cloud Pak CR we need shared and dynamic operator dependency management for operators and their operands.<br/>

Most cloud pak operator dependencies are operators for automation capabilities, such as FileNet, Document Processing, etc.<br/>

There are 2 operators that do not fall into this category: `ibm-common-service-operator`, and `operand-deployment-lifecycle-manager` operator.<br/>
Operand Deployment Lifecycle Manager `(ODLM)` resolves dynamic and shared dependencies, requested by the cloud pak for CR.<br/>
Common Services operator is a bridge between cloud pak operator and dynamic capabilities of ODLM.<br/>

#### Apply Kustomized CR.

> Note: In the lab steps, we created kustomizations in `$CERTKUBE/scripts/kustomize` directory.<br/>
> To minimize potential deployment errors we use lab kustomizations in `$KUST` directory, which are the same.<br/>

> Change to `$KUST` directory and apply `production` overlay.<br/>

```
cd $KUST

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

If you follow event output you will see that new operator subscriptions are dynamically created, together with new CR's, and operand services.<br/>
When all is complete, ICP4ACluster CR is in the `ready` state and we can log into the Cloud Pak console.<br/>

We discuss how this works next.<br/>
