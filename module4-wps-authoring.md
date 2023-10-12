## Workflow Process Service Authoring pattern.

IBM CP4BA Workflow Process Service is a small-footprint business automation environment<br/>
to develop, test, and run workflow processes that orchestrate human tasks and services.<br/>
It provides single runtime container.<br/>

Workflow Process Service is offered only as part of Cloud Pak for Business Automation.<br/>

Workflow Process Service Authoring pattern is authoring environment for WPS.<br/>
Workflow Process Service Authoring pattern is deployed by CP4BA multi-pattern operator.<br/>

## todo: should we deploy WFPS as well as part of this lab?

Visit endpoints and explore pattern capabilities.<br/>

```
oc get icp4acluster icp4adeploy -o yaml | yq -y '.status.endpoints'

-
 name: BAStudio
  scope: External
  type: UI
  uri: https://cpd-cp4ba1.apps.65119814b3923f0017b004a9.cloud.techzone.ibm.com
- name: Business Automation Workflow External base URL
  scope: External
  type: UI
  uri: https://cpd-cp4ba1.apps.65119814b3923f0017b004a9.cloud.techzone.ibm.com/bas/
- name: Business Automation Workflow REST API Tester
  scope: External
  type: UI
  uri: https://cpd-cp4ba1.apps.65119814b3923f0017b004a9.cloud.techzone.ibm.com/bas/bpmrest-ui
- name: Business Automation Workflow Process Admin Console
  scope: External
  type: UI
  uri: https://cpd-cp4ba1.apps.65119814b3923f0017b004a9.cloud.techzone.ibm.com/bas/ProcessAdmin
- name: Workplace
  scope: External
  type: UI
  uri: https://cpd-cp4ba1.apps.65119814b3923f0017b004a9.cloud.techzone.ibm.com/bas/Workplace

```

Components that can be installed with Workflow Process Service Authoring pattern.<br/>

```
//
// Workflow Process Service Authoring
//
always(workflow_process_service, wfps_authoring). // part of ba studio component

always(workflow_process_service, ba_foundation, bas).
depends_on(workflow_process_service, ba_foundation, bas, cp_foundation, bts).

optional(workflow_process_service, ba_foundation, bai).
depends_on(workflow_process_service, ba_foundation, bai, cp_foundation, flink).
depends_on(workflow_process_service, ba_foundation, bai, cp_foundation, kafka).
depends_on(workflow_process_service, ba_foundation, bai, cp_foundation, elastic).

optional(workflow_process_service, data_collector_and_data_indexer).

always(workflow_process_service, cp_foundation, zen_ui).
always(workflow_process_service, cp_foundation, im).
always(workflow_process_service, cp_foundation, web_ui).
always(workflow_process_service, cp_foundation, license).
always(workflow_process_service, cp_foundation, certmgr).
```

Buisness Automation Studio component from business automation foundation pattern is always deployed.<br/>
Cloud Pak foundational services are always deployed.<br/>
Business Automation Insights and Data Collector and Data Indexer are optional.<br/>
Kafka, Elastic Search, and Flink are installed as dependencies of Business Automation Insights.<br/>

Query operator deployments.<br/>
(Compare to the output of `oc get csv` later in the module)<br/>

```
oc get deployments | grep -i oper 
NAME                                            READY   UP-TO-DATE   AVAILABLE   AGE

ibm-ads-operator                                1/1     1            1           7h11m
ibm-common-service-operator                     1/1     1            1           7h10m
ibm-commonui-operator                           1/1     1            1           6h51m
ibm-content-operator                            1/1     1            1           7h10m
ibm-cp4a-operator                               1/1     1            1           7h10m
ibm-cp4a-wfps-operator                          1/1     1            1           7h11m
ibm-dpe-operator                                1/1     1            1           7h10m
ibm-iam-operator                                1/1     1            1           6h52m
ibm-insights-engine-operator                    1/1     1            1           7h10m
ibm-mongodb-operator                            1/1     1            1           6h51m
ibm-odm-operator                                1/1     1            1           7h10m
ibm-pfs-operator                                1/1     1            1           7h10m
ibm-zen-operator                                1/1     1            1           6h53m
icp4a-foundation-operator                       1/1     1            1           7h10m
operand-deployment-lifecycle-manager            1/1     1            1           7h8m
postgresql-operator-controller-manager-1-18-5   1/1     1            1           6h47m
```

Let's look at operator operands.<br/>

Operand can be any type of object created by an operator in response to CR: Deployment, Stateful Set, etc.

Operand deployments:<br/>
```
oc get deployments | grep -v oper
NAME                                            READY   UP-TO-DATE   AVAILABLE   AGE

bastion                                         1/1     1            1           20h
common-web-ui                                   1/1     1            1           6h54m
ibm-nginx                                       1/1     1            1           6h34m
ibm-nginx-tester                                1/1     1            1           6h34m
meta-api-deploy                                 1/1     1            1           6h56m
platform-auth-service                           1/1     1            1           6h54m
platform-identity-management                    1/1     1            1           6h54m
platform-identity-provider                      1/1     1            1           6h54m
usermgmt                                        1/1     1            1           6h40m
zen-audit                                       1/1     1            1           6h36m
zen-core                                        1/1     1            1           6h36m
zen-core-api                                    1/1     1            1           6h36m
zen-watcher                                     1/1     1            1           6h36m
```

Operand Stateful Sets:<br/>
```
oc get StatefulSets

NAME                              READY   AGE
icp-mongodb                       1/1     7h6m
icp4adeploy-bastudio-deployment   1/1     6h25m
zen-minio                         3/3     6h57m
```

How to find environment variable names in Stateful Set?<br/>
```
oc get statefulset icp4adeploy-bastudio-deployment -o yaml | yq '.spec.template.spec.containers[0].env[].name'
```

`icp4adeploy-bastudio-deployment` StatefulSet is Business Automation Studio and internal Business Automation and JMS Runtime.<br/>
```
oc get statefulset icp4adeploy-bastudio-deployment -o yaml | yq '.spec.template.spec.containers[0].env[] | select(.name=="is_internal_baw")'
{
  "name": "is_internal_baw",
  "value": "true"
}
```

```
oc get statefulset icp4adeploy-bastudio-deployment -o yaml | yq '.spec.template.spec.containers[0].env[] | select(.name=="JMS_SERVER_HOST")'
{
  "name": "JMS_SERVER_HOST",
  "value": "icp4adeploy-bastudio-deployment-0.icp4adeploy-bastudio-service-headless.cp4ba1.svc"
}
```

There is one pod in this stateful set.<br/>
```
oc get pods | grep -i run | grep -v oper | grep icp4adeploy-bastudio-deployment

icp4adeploy-bastudio-deployment-0                                1/1     Running     0               7h8m
```

Workflow Process Authoring database pod is owned by Edb Postgres Cluster Custom Resource.<br/>
```
oc get pods icp4adeploy-wps-db-1 -o yaml | yq '.metadata.ownerReferences'
[
  {
    "apiVersion": "postgresql.k8s.enterprisedb.io/v1",
    "blockOwnerDeletion": true,
    "controller": true,
    "kind": "Cluster",
    "name": "icp4adeploy-wps-db",
    "uid": "52e9db55-1c91-4c56-a8bc-0f4063ad1767"
  }
]
```

```
oc get cluster
NAME                 AGE     INSTANCES   READY   STATUS                     PRIMARY
icp4adeploy-wps-db   7h35m   1           1       Cluster in healthy state   icp4adeploy-wps-db-1
zen-metastore-edb    7h58m   1           1       Cluster in healthy state   zen-metastore-edb-1
```

You can see that operator manages database cluster.<br/>

Edb Postgres Operator Cluster CR is owned by ICP4ACluster CR.<br/>
```
oc get cluster icp4adeploy-wps-db  -o yaml | yq '.metadata.ownerReferences'
[
  {
    "apiVersion": "icp4a.ibm.com/v1",
    "kind": "ICP4ACluster",
    "name": "icp4adeploy",
    "uid": "618b1bee-8651-4c43-a884-a8c94c2f5d09"
  }
]
```

Cloud Pak CR is at the top of ownership hierarchy.<br/>
```
oc get icp4acluster icp4adeploy  -o yaml | yq '.metadata.ownerReferences'
null
```

Query operator pods.<br/>

```
oc get pods | grep -i run | grep oper 
ibm-ads-operator-5659cc6c6d-qvj7j                                1/1     Running     0               8h
ibm-common-service-operator-85f66db89b-qskx8                     1/1     Running     0               8h
ibm-commonui-operator-5cfb967969-hzjb9                           1/1     Running     0               8h
ibm-content-operator-7bfb756c6d-cx5s7                            1/1     Running     0               8h
ibm-cp4a-operator-f765c7b7f-cz2bh                                1/1     Running     0               8h
ibm-cp4a-wfps-operator-79c8b945bd-krsjz                          1/1     Running     0               8h
ibm-dpe-operator-56c649c94d-p2qbt                                1/1     Running     0               8h
ibm-iam-operator-7678d8cb65-46gj5                                1/1     Running     0               8h
ibm-insights-engine-operator-66dd5fdc66-p6zsl                    1/1     Running     0               8h
ibm-mongodb-operator-5776b59799-86qbz                            1/1     Running     0               8h
ibm-odm-operator-86c8f85d88-8gsnc                                1/1     Running     0               8h
ibm-pfs-operator-86df7c7d7b-d88h8                                1/1     Running     0               8h
ibm-zen-operator-664bc9977b-nrsz4                                1/1     Running     0               8h
icp4a-foundation-operator-7d555876bc-j4c4l                       1/1     Running     0               8h
operand-deployment-lifecycle-manager-694495b494-fsqhn            1/1     Running     0               8h
postgresql-operator-controller-manager-1-18-5-65f757bfb8-tsc7t   1/1     Running     0               7h43m
```

Compare operator pods to installed operators.<br/>

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
operand-deployment-lifecycle-manager.v4.0.0   Operand Deployment Lifecycle Manager                          4.0.0 
```

It is easy to correlate operator pods with operator subscriptions.<br/>

Query operand pods.<br/>
Note that not every operator deployed an operand.<br/>
As we discussed in module 2 static operator dependencies are always deployed.<br/>
Deployed CR's depend on the use case.<br/>

```
oc get pods | grep -i run | grep -v oper
bastion-75ffd56c45-2sjnx                                         1/1     Running     0            3h13m
common-web-ui-b6d689f8-sgnmh                                     1/1     Running     0            8h
ibm-nginx-d846df78-469tx                                         2/2     Running     0            8h
ibm-nginx-tester-964d8686d-sz2ml                                 2/2     Running     0            8h
icp-mongodb-0                                                    1/1     Running     0            8h
icp4adeploy-bastudio-deployment-0                                1/1     Running     0            7h43m
icp4adeploy-wps-db-1                                             1/1     Running     0            7h50m
meta-api-deploy-75d5b8ddd9-dm8lg                                 1/1     Running     0            8h
platform-auth-service-c8c5c699b-47btp                            1/1     Running     0            8h
platform-identity-management-558798d584-w2xmw                    1/1     Running     0            8h
platform-identity-provider-5fff4b7997-kdb2p                      1/1     Running     0            8h
usermgmt-6676dc6c54-cxjm9                                        1/1     Running     0            8h
zen-audit-657c48b867-q4rw7                                       1/1     Running     0            8h
zen-core-777c8c64c-8v5ck                                         2/2     Running     1 (8h ago)   8h
zen-core-api-87599df96-crhcf                                     2/2     Running     0            8h
zen-metastore-edb-1                                              1/1     Running     0            8h
zen-minio-0                                                      1/1     Running     0            8h
zen-minio-1                                                      1/1     Running     0            8h
zen-minio-2                                                      1/1     Running     0            8h
zen-watcher-ffcbfc8d5-g5wqk                                      2/2     Running     0            8h
```

We recoginize foundational services pods that we discussed in module 3, and Cloud Pak pods.<br/>
