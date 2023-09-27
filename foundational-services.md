## Foundational Services.

## This is a DRAFT!

*Cloud Pak for Business Automation* is a cloud pak with multiple capabilities: workflow, content, document automation, process mining, etc.<br/>
Each capability requires *`iam`* and *`zen ui`* components. These are *core* services that provide consistent authentication and UI experience.

In addition, cloud pak capabilities require databases, event processors, search service, and business teams service.<br/>
If you review `patterns knowledge base`, you will find that all patterns depend on *`cloud pak foundational components`*.

We can also think of other cloud pak operators: *Cloud Pak for Integration*, *Cloud Pak for Data*, etc. All of them require *`foundational components`*.

`Core` foundational services must be deployed for every cloud pak operator deployment.<br/>
`Optional` foundational services are deployed only if they are selected for deployment either directly, or as a dependency by cloud pak capabilities.

`Core` foundational services:
```
- iam - Identity and Access Management
- zen UI - Integrated UI, includes identity and role management to control access to installed capabilities.
- licensing - Cloud Pak usage, *singleton*, only one instance of this operator in the cluster.
- certificate management - manage and store tls certificates, *singleton*, only one instance of this operator in the cluster.
- namespace scope - grant operator permissions in advanced topologies.
```

`Optional` foundational services:
```
- db2
- postgres
- kafka
- flink
- elastic search
- user data services
- business teams service

```

## Foundational Services Operators.

> If we list installed operators before and after we applied cloud pak CR, we find that operator list contains additional operators.

```
oc project cp4ba

oc get csv
NAME                                          DISPLAY                                                       VERSION   REPLACES                          PHASE
cloud-native-postgresql.v1.18.5               EDB Postgres for Kubernetes                                   1.18.5    cloud-native-postgresql.v1.18.4   Succeeded
ibm-ads-operator.v23.1.1                      IBM CP4BA Automation Decision Service                         23.1.1                                      Succeeded
ibm-cert-manager-operator.v4.0.0              IBM Cert Manager                                              4.0.0                                       Succeeded
ibm-common-service-operator.v4.0.1            IBM Cloud Pak foundational services                           4.0.1                                       Succeeded
ibm-commonui-operator.v4.0.0                  Ibm Common UI                                                 4.0.0                                       Succeeded
ibm-content-operator.v23.1.1                  IBM CP4BA FileNet Content Manager                             23.1.1                                      Succeeded
ibm-cp4a-operator.v23.1.1                     IBM Cloud Pak for Business Automation (CP4BA) multi-pattern   23.1.1                                      Succeeded
ibm-cp4a-wfps-operator.v23.1.1                IBM CP4BA Workflow Process Service                            23.1.1                                      Succeeded
ibm-dpe-operator.v23.1.1                      IBM Document Processing Engine                                23.1.1                                      Succeeded
ibm-iam-operator.v4.0.1                       IBM IM Operator                                               4.0.1                                       Succeeded
ibm-insights-engine-operator.v23.1.1          IBM CP4BA Insights Engine                                     23.1.1                                      Succeeded
ibm-mongodb-operator.v4.0.0                   IBM MongoDB Operator                                          4.0.0                                       Succeeded
ibm-odm-operator.v23.1.1                      IBM Operational Decision Manager                              23.1.1                                      Succeeded
ibm-pfs-operator.v23.1.1                      IBM CP4BA Process Federation Server                           23.1.1                                      Succeeded
ibm-zen-operator.v5.0.0                       IBM Zen Service                                               5.0.0                                       Succeeded
icp4a-foundation-operator.v23.1.1             IBM CP4BA Foundation                                          23.1.1                                      Succeeded
operand-deployment-lifecycle-manager.v4.0.0   Operand Deployment Lifecycle Manager                          4.0.0                                       Succeeded
```
The reason is that some operator dependencies are resolved dynamically, at run time.

`Foundational services operators` enable *runtime dependency resolution*, *versioning*, and *sharing* of `foundational services`.<br/>

#### Foundational sevices bootstrap.

Cloud pak operator declares dependency on `ibm-common-services-operator`.<br/>
In turn, `ibm-common-services` operator brings in another operator, `operand-deployment-lifecycle-manager`, ODLM.

ODLM enables runtime depedency resolution, and sharing of foundational services.

>*This is Key*:<br/>
`ODLM` installs new operators *on demand* and *automatically applies preconfigured CR* to force new operator to deploy their operand.<br/>
For *shared* services, only one service instance is created.

In accepted terminology, an *operator* is acting on it's *operand*. An operator watches for CR's, but CR is a trigger, not an operand.<br/>
When operator's CR is applied, operator creates it's operand deployment to match CR requirements.</br>
ODLM can manage *groups of operands* on demand. This explains it's name: `Operand Deployment Lifecyle Manager`.

#### ODLM internals.

`OperandRequest` CR is a request from the cloud pak operator to ODLM for one or more foundational services.

When `ODLM` responds to `OperandRequest` CR, it searches `OperandRegistry` CR for the operand name requested by `OperandRequest` CR.<br/>
If found, `ODLM` searches `OperandConfig` CR to find default CR for the requested operand.

**This is a key**<br/>
If `ODLM` finds requested operand in `OperandRegistry`, and finds default CR configuration in `OperandConfig`,<br/>
and if operator subscription does not exist, then `ODLM` will create new operator subscription and and new CR.<br/>
Newly subscribed operator will respond to CR and deploy it's operand. New operator will be managed by OpenShift `OLM`.

If requested subscription already exist, `ODLM` will not create new one, but respond with existing service.<br/>
This behaviour enables dependency sharing.

In another case, if `ODLM` finds operand in `OperandRegistry`, but does not find default CR in `OperandConfig`,<br/>
then `ODLM` will create new operator subscription only. <br/>
It will be responsibility of the cloud pak operator to create CR for requested foundational service.

To enable access to `foundational service`, `ODLM` copies service access information to secrets specified in the `bindings` portion of `OperandRequest` .

> Review `OperandRequest` CR's created by cloud pak operator for *Workflow Process Service* capability.

```
oc project cp4ba
oc get OperandRequest

NAME                             AGE   PHASE     CREATED AT
cloud-native-postgresql-opreq    8h    Running   2023-09-25T18:29:47Z
iaf-system-common-service        9h    Running   2023-09-25T18:25:18Z
ibm-iam-request                  9h    Running   2023-09-25T18:26:28Z
ibm-iam-service                  8h    Running   2023-09-25T18:29:49Z
ibm-wps-postgre-operandrequest   8h    Running   2023-09-25T19:09:23Z
zen-ca-operand-request           8h    Running   2023-09-25T18:30:36Z
```

> Review OperandRequest.

There are 2 requests for foundational services: `ibm-platform-ui-operator`, and `ibm-im-operator` in `OperandRegistry` `common-service`.

Note that `ibm-platformui-operator`, and `ibm-im-operator` are symbolic keys into `OperandRegistry` CR and `OperandConfig` CR.

```
oc project cp4ba

oc get OperandRequest iaf-system-common-service -o yaml
apiVersion: operator.ibm.com/v1alpha1
kind: OperandRequest
metadata:
  labels:
    release: 23.0.1
  name: iaf-system-common-service
  namespace: cp4ba
  ownerReferences:
  - apiVersion: icp4a.ibm.com/v1
    kind: ICP4ACluster
    name: icp4adeploy
spec:
  requests:
  - operands:
    - name: ibm-platformui-operator
    - name: ibm-im-operator
    registry: common-service
    registryNamespace: cp4ba
```

> Optional: Review `OperandRegistry` CR and find `ibm-im-operator`, and `ibm-platform-ui-operator` keys.

  This is meta data needed to create operator subscriptions.

  ```
  oc get operandregistry -o yaml
  ```

> Optional: Review `OperandConfig` CR and find `ibm-platformui-operator`, and `ibm-im-operator` keys.

  ```
  oc get OperandConfig common-service -o yaml
  ```

#### IBM Common Services Operator

`ibm-common-services-operator` creates `CommonService` CR and bootstraps `ODLM` operator.

`CommonService` parameters control placement of `OperandRegistry` and `OperandConfig` CR's and play important role in workload isolation.

Use `CommonService` CR to control multiple configuration options for foundational services.

All configuration parameters for CommonService CR are documented in online documentation.

> Review `CommonService` CR:

```
oc project cp4ba

oc get CommonService common-service -o yaml
```

#### Workload isolation topologies.

By default, cloud pak operator is installed in 'one namespace' mode with foundational services in the same namespace.<br/>

This topology enables maximum isolation between cloud pak deployments. Each cloud pak deployment can be upgraded independently.<br/>

Another topology is to install foundational services in one namespace and cloud pak operators in another namespace.<br/>
In this case foundational services can be shared by a tenant. Foundational service operators must be given access to tenant namespaces.

Another topology is to place operators in one namespace and create operands in another namespace.<br/>
This approach is taken by Cloud Pak for Data.

If cloud pak operator is installed in 'all-namespaces' mode, then foundational services operators must be installed in 'all namespaces` mode.<br/>
If one cloud pak operator is installed in 'all-namespaces' mode, then all other cloud pak operators must be installed in `all-namespaces` mode.

It is recommended that cloud paks are installed in isolated namespaces and not share foundational services.

### Cloud Pak Cluster Topology Considerations

> IBM recommends, that Cloud Pak namespaces be labeled and assigned to machine sets. Machine set must have 3 or more nodes
> Private topology is prefred to isolate all services by tenant (namespace). IBM recommends that each cloud pak instance is installed with it's own dedicated foundational services.
> Cloud Paks can be deployed to Machine Sets (grouping of worker nodes that scale up and down) to provide workload isolation for worker nodes. For clusters with in Cloud Availability Zones, worker nodes should be placed accross all zones.

























