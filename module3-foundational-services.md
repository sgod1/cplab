### Foundational Services.

*Cloud Pak for Business Automation* is multi-pattern cloud pak: workflow, content, document automation, process mining, etc.<br/>
Each capability requires *`iam`* and *`zen ui`* components. These are *core* services that provide consistent authentication and UI experience.<br/>

In addition, cloud pak capabilities require databases, event processors, search service, and business teams service.<br/>
If you review `patterns knowledge base`, you will find that all patterns depend on *`cloud pak foundational components`*.<br/>

Other cloud paks (*Cloud Pak for Integration*, *Cloud Pak for Data*, *Cloud Pak for AIOPS*), require *`foundational components`*.<br/>

`Core` foundational services must be deployed with every cloud pak operator deployment.<br/>
`Optional` foundational services are deployed only if they are selected for deployment either directly, or as a dependency by cloud pak capabilities.<br/>

`Core` foundational services:<br/>
```
- iam - Identity and Access Management
- zen UI - Integrated UI, includes identity and role management to control access to installed capabilities.
- licensing - Cloud Pak usage, *singleton*, only one instance of this operator in the cluster.
- certificate management - manage and store tls certificates, *singleton*, only one instance of this operator in the cluster.
- namespace scope - grant operator permissions in advanced topologies.
```

`Optional` foundational services:<br/>
```
- db2
- postgres
- kafka
- flink
- elastic search
- user data services
- business teams service
```

### Foundational Services Operators.

> If we query installed operators before and after we applied cloud pak CR, we find that operator list has more operators.<br/>
```
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
The reason is that some operator dependencies are resolved dynamically, at run time.<br/>

To support Cloud Pak requirements,`Foundational services operators` enable *runtime dependency resolution*, *versioning*, and *sharing* of `foundational services`.<br/>

#### Foundational sevices bootstrap.

Foundational services link to a cloud pak, `ibm-common-services` operator is a dependency of a cloud pak operator.<br/>
As we discussed earlier, when an operator is installed, dependent operators are always installed.<br/>

In turn, `ibm-common-services` operator depends on another operator, `operand-deployment-lifecycle-manager` operator, *ODLM*.<br/>

> Following dependency chain: `cloud-pak operator` -> `ibm-common-services-operator` -> `ODLM`.<br/>

An *operator* is acting on it's *operands*. CR is a trigger. When operator detects a change in CR, it will act on it's *operands* to reconsile state with CR requirements. To say it differently, CR reconciliation results in *operand* deployment.<br/>

For ODLM, an operand is another operator. To act, ODLM installs it's operand and then creates a CR for it, triggering reconciliation and operand deployment.<br/>

ODLM CR is called OperandRequest.<br/>
OperandRequest CR can trigger a group of ODLM operands. ODLM will manage them at the same time.<br/>

> Following event chain: OperandRequest CR -> ODLM -> install new operator(s) and create CR(s) -> trigger operand deployment for new operator(s).<br/>

ODLM manages *groups of operands*.<br/>

*ODLM* enables on-demand depedency resolution, and sharing of foundational services.<br/>

> *This is Key*:<br/>
`ODLM` installs new operators *on demand* and *automatically applies preconfigured CR*, triggering CR reconciliation and new operand deployment.<br/>
For shared foundational services, `ODLM` creates just one instance of a service operator, and one instance of a service.<br/>
In some cases, ODLM will just install it's operand without creating triggering CR.<br/>

#### *ODLM* architecture.<br/>

![ODLM architecture](./images/odlm-arch.png)

#### *ODLM* on-demand dependecy resolution.

We review ODLM configuration CRs, and explain runtime dependency resolution.<br/>

To start, when cloud pak operator needs foundational services it creates OperandRequest CR with required services.<br/>

> Lab step<br/>
View OperandRequests created by CP4BA operator.<br/>

```
oc project cp4ba
oc get OperandRequests
oc get OperandRequests

NAME                             AGE    PHASE     CREATED AT
cloud-native-postgresql-opreq    4d8h   Running   2023-09-25T18:29:47Z
iaf-system-common-service        4d8h   Running   2023-09-25T18:25:18Z
ibm-iam-request                  4d8h   Running   2023-09-25T18:26:28Z
ibm-iam-service                  4d8h   Running   2023-09-25T18:29:49Z
ibm-wps-postgre-operandrequest   4d7h   Running   2023-09-25T19:09:23Z
zen-ca-operand-request           4d8h   Running   2023-09-25T18:30:36Z
```

> Lab step
View iaf-system-common-service OperandRequest<br/>
```
oc get operandrequests iaf-system-common-service -o yaml | yq -y '.spec'
requests:
  - operands:
      - name: ibm-platformui-operator
      - name: ibm-im-operator
    registry: common-service
    registryNamespace: cp4ba
```
We see that 2 operands are requested: `ibm-platformui-operator`, and `ibm-im-operator`.<br/>
There is also a reference to *registry* and *registry namespace*.<br/>

Registry is a name of OperandRegistry CR in `cp4ba` namespace.<br/>
OperandRegistry is a list operator subscription metadata for all foundational services.<br/>
ODLM will search OperandRegstry CR `common-service` for the names of 2 operands.<br/>

> Lab step.<br/>
Query OperandRegisty common-service CR for ibm-platformui-operator subscription.<br/>

```
oc get OperandRegistry common-service -o yaml | yq -y '.spec.operators[] | select(.name == "ibm-platformui-operator")'

channel: v4.0
installPlanApproval: Automatic
name: ibm-platformui-operator
namespace: cp4ba
packageName: ibm-zen-operator
scope: public
sourceName: opencloud-operators-v4-0
sourceNamespace: openshift-marketplace
```

> Lab step<br/>
Query OperandRegistry common-service CR for ibm-im-operator.<br/>

```
oc get OperandRegistry common-service -o yaml | yq -y '.spec.operators[] | select(.name == "ibm-im-operator")'

channel: v4.0
installPlanApproval: Automatic
name: ibm-im-operator
namespace: cp4ba
packageName: ibm-iam-operator
scope: public
sourceName: opencloud-operators-v4-0
sourceNamespace: openshift-marketplace
```

ODLM will use this information to create operator subscriptions for requested foundational services operators.<br/>

To find information about how to create CR's, ODLM will query OperandConfig CR.<br/>

> Lab step.<br/>
Query OperandConfig common-service CR for ibm-im-operator CR.<br/>

```
oc get OperandConfig common-service -o yaml | yq -y '.spec.services[] | select(.name == "ibm-im-operator")'

name: ibm-im-operator
spec:
  authentication:
    auditService:
      resources:
        limits:
          cpu: 20m
          memory: 40Mi
        requests:
          cpu: 10m
          memory: 20Mi
    authService:
      resources:
        limits:
          cpu: 1000m
          memory: 1090Mi
        requests:
          cpu: 600m
          memory: 650Mi
    clientRegistration:
      resources:
        limits:
          cpu: 1000m
          memory: 50Mi
        requests:
          cpu: 20m
          memory: 50Mi
    config:
      onPremMultipleDeploy: true
    identityManager:
      resources:
        limits:
          cpu: 1000m
          memory: 410Mi
        requests:
          cpu: 260m
          memory: 240Mi
    identityProvider:
      resources:
        limits:
          cpu: 1000m
          memory: 420Mi
        requests:
          cpu: 570m
          memory: 250Mi
    replicas: 1
  operandBindInfo:
    operand: ibm-im-operator
  operandRequest:
    requests:
      - operands:
          - name: ibm-im-mongodb-operator
          - name: ibm-idp-config-ui-operator
        registry: common-service
  policydecision: {}
```

> Lab Step.<br/>
Query OperandConfig common-service for ibm-platformui-operator.<br/>

```
oc get OperandConfig common-service -o yaml | yq -y '.spec.services[] | select(.name == "ibm-platformui-operator")'

name: ibm-platformui-operator
resources:
  - apiVersion: batch/v1
    data:
      spec:
        activeDeadlineSeconds: 600
        backoffLimit: 5
        template:
          metadata:
            annotations:
              productID: 068a62892a1e4db39641342e592daa25
              productMetric: FREE
              productName: IBM Cloud Platform Common Services
          spec:
            affinity:
              nodeAffinity:
                requiredDuringSchedulingIgnoredDuringExecution:
                  nodeSelectorTerms:
                    - matchExpressions:
                        - key: kubernetes.io/arch
                          operator: In
                          values:
                            - amd64
                            - ppc64le
                            - s390x
            containers:
              - command:
                  - bash
                  - -c
                  - bash /setup/pre-zen.sh
                env:
                  - name: common_services_namespace
                    valueFrom:
                      fieldRef:
                        fieldPath: metadata.namespace
                image: icr.io/cpopen/ibm-zen-operator@sha256:a2e257825cfd8581b1433fb8760115cf8dcc4e233cda95f0b141c5b832c1a390
                name: pre-zen-job
                resources:
                  limits:
                    cpu: 500m
                    memory: 512Mi
                  requests:
                    cpu: 100m
                    memory: 50Mi
                securityContext:
                  allowPrivilegeEscalation: false
                  capabilities:
                    drop:
                      - ALL
                  privileged: false
                  readOnlyRootFilesystem: false
            restartPolicy: OnFailure
            securityContext:
              runAsNonRoot: true
            serviceAccount: operand-deployment-lifecycle-manager
            serviceAccountName: operand-deployment-lifecycle-manager
            terminationGracePeriodSeconds: 30
    force: true
    kind: Job
    name: pre-zen-operand-config-job
    namespace: cp4ba
spec:
  operandBindInfo: {}
```

By using information about foundational service operator subscription and about foundational service operator CR, ODLM will create operator subscriptions, and CR to trigger operand deployment reconciliation for ibm-im-operator, and ibm-platformui-operator.<br/>

> Lab step.<br/>
Validate ibm-im-operator, and ibm-platformui-operator subscriptions.<br/>

```
oc get subscriptions | grep -E "ibm-im-operator|ibm-platformui-operator" 
NAME                                                                                 PACKAGE                        SOURCE                            CHANNEL
ibm-im-operator                                                                      ibm-iam-operator               opencloud-operators-v4-0          v4.0
ibm-platformui-operator                                                              ibm-zen-operator               opencloud-operators-v4-0          v4.0 
```

> Lab step.<br/>
Query OperandRegistry common-service for all OperandRequests for foundational services.<br/>
```
oc get OperandRegistry common-service -o yaml | yq -y '.status.operatorsStatus'

cloud-native-postgresql:
  reconcileRequests:
    - name: ibm-wps-postgre-operandrequest
      namespace: cp4ba
    - name: cloud-native-postgresql-opreq
      namespace: cp4ba
ibm-idp-config-ui-operator:
  reconcileRequests:
    - name: ibm-iam-request
      namespace: cp4ba
ibm-im-mongodb-operator:
  reconcileRequests:
    - name: ibm-iam-request
      namespace: cp4ba
ibm-im-operator:
  reconcileRequests:
    - name: iaf-system-common-service
      namespace: cp4ba
    - name: ibm-iam-service
      namespace: cp4ba
ibm-platformui-operator:
  reconcileRequests:
    - name: iaf-system-common-service
      namespace: cp4ba
    - name: zen-ca-operand-request
      namespace: cp4ba
```

We validated the basic workings of ODLM, and how it creates on-demand operator subscriptions, and CR's to trigger operand deployment.<br/>

> Follow: OperandRequest CR -> ODLM, (OperandRegistry, OperandConfig) -> operator subscription, CR -> operand deployment<br/>

#### IBM Common Services Operator

There is one more important component supporting foundational services. It is `ibm-common-services` operator.<br/>
As mentioned before it is a link between foundational services and cloud pak operator.<br/>

`ibm-operational-services` creates CommonService CR common-service that plays important role in foundational services configuration and multi-tenancy.<br/>

> Lab step.<br/>
Query CommonService common-service CR for installed foundational operators.<br/>

```
oc get commonservice common-service -o yaml | yq -y .status      

bedrockOperators:
  - installPlanName: install-xjxdg
    name: ibm-iam-operator
    operatorStatus: Succeeded
    subscriptionStatus: Succeeded
    version: v4.0.1
  - installPlanName: install-lz9fm
    name: ibm-mongodb-operator
    operatorStatus: Succeeded
    subscriptionStatus: Succeeded
    version: v4.0.0
  - installPlanName: install-xjxdg
    name: ibm-zen-operator
    operatorStatus: Succeeded
    subscriptionStatus: Succeeded
    version: v5.0.0
  - installPlanName: install-lz9fm
    name: ibm-commonui-operator
    operatorStatus: Succeeded
    subscriptionStatus: Succeeded
    version: v4.0.0
  - installPlanName: install-m2578
    name: cloud-native-postgresql
    operatorStatus: Succeeded
    subscriptionStatus: Succeeded
    version: v1.18.5
```

To conclude, we review parameters in CommonService CR that support foundation services multi-tenancy and workload isolation.<br/>

It is possible to place 'OperandRegistry' and 'OperandConfig' CR's in different namespaces and affect placement of foundational services operators and foundational services in different namespaces to achieve workload isolation objectives. We will review examples of workload isolation topologies.<br/>

> Lab step.
Query CommonService common-service CR.<br/>

```
oc get CommonService common-service -o yaml | yq -y '.spec'

license:
  accept: true
operatorNamespace: cp4ba
servicesNamespace: cp4ba
size: starterset
storageClass: ocs-storagecluster-ceph-rbd
```