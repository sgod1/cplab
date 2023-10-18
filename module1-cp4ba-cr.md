### Building and Managing CP4ACluster CR.

*CP4BA multipattern CR* represents Business Automation capabilities or patterns.<br/>

These capabilities are: *Automation Decision Services*, *Automation Document Processing*, *Automation Workstream Services*, *Business Automation Application*, *Business Automation Workflow*, *FileNet Content Manager*, *Operational Decision Manager*, and *Workflow Process Service Authoring*.<br/>

A pattern (capability) is a collection of components.<br/>

Component in a pattern maps to a pod.<br/>

A pattern may require components from other patterns.<br/>

Some required components in a pattern are mandatory and some are optional.<br/>

Cloupak foundational pattern is *always* required by other patterns.<br/>

Installation configuration script is smart about *required and optional components and their dependencies*.<br/>

#### Patterns Knowlege Base
We can define knowledge base for patterns and their dependencies.<br/>
We can query knowledge base to derive relationships between patterns and components.<br/>

```
always(Pattern1, Component1) 
  means that when Pattern1 is installed, Component1 is always installed.

always(Pattern1, Pattern2, Component2) 
  means that when Pattern1 is installed, then Component2 from Pattern2 is alawys installed.

optional(Pattern1, Component1) 
  means that Component1 can be optionally installed when Pattern1 is installed.

optional(Pattern1, Pattern2, Component2) 
  means that Component2 from Pattern2 can be optionally installed when Pattern1 is installed.

depends_on(Pattern1, Pattern2, Component2, Pattern3, Component3) 
  means that when Pattern1 is installed, and Component2 from Pattern2 is installed (required or optional), 
  then Component2 from Pattern2 depends on Component3 from Pattern3.
```

> Example: *workflow_runtime* pattern:<br/>

```
//
// workflow runtime
//
always(workflow_runtime, workflow_server).
always(workflow_runtime, pfs).

always(workflow_runtime, content, cpe).
always(workflow_runtime, content, graphql).
always(workflow_runtime, content, cmis).

always(workflow_runtime, ba_foundation, ae). // app engine
always(workflow_runtime, ba_foundation, ban).
always(workflow_runtime, ba_foundation, rr).

always(workflow_runtime, ba_foundation, elastic).

optional(workflow_runtime, ba_foundation, bai).
depends_on(workflow_runtime, ba_foundation, bai, cp_foundation, flink).
depends_on(workflow_runtime, ba_foundation, bai, cp_foundation, kafka).
depends_on(workflow_runtime, ba_foundation, bai, cp_foundation, elastic).

always(workflow_runtime, cp_foundation, zen_ui).
always(workflow_runtime, cp_foundation, im).
always(workflow_runtime, cp_foundation, web_ui).
always(workflow_runtime, cp_foundation, bts).
always(workflow_runtime, cp_foundation, license).
always(workflow_runtime, cp_foundation, certmgr).
```

> Example: FileNet *Content* pattern<br/>

```
//
// content
//
always(content, graphql).
always(content, cpe).

optional(content, enterprise_records).
optional(content, task_mgr).
optional(content, css).
optional(content, ccsap).
optional(content, cmis).

always(content, ba_foundation, ban).
always(content, ba_foundation, rr).

optional(content, ba_foundation, bai).
depends_on(content, ba_foundation, bai, cp_foundation, flink).
depends_on(content, ba_foundation, bai, cp_foundation, kafka).
depends_on(content, ba_foundation, bai, cp_foundation, elastic).

always(content, cp_foundation, zen_ui).
always(content, cp_foundation, im).
always(content, cp_foundation, web_ui).
always(content, cp_foundation, license).
always(content, cp_foundation, certmgr).
```

> Example: *Workflow Process Service Authoring* pattern.<br/>

```
//
// Workflow Process Service Authoring
//
always(workflow_process_service, wfps_authoring).

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

### Creating Workflow Process Service Authoring CR.

> Lab step.<br/>
> View CR templates for CP4BA patterns. <br/>

```
cd $PATTERNS
ls

ibm_cp4a_cr_production_FC_application.yaml				ibm_cp4a_cr_production_FC_workstreams.yaml				ibm_cp4a_cr_starter_application.yaml
ibm_cp4a_cr_production_FC_content.yaml					ibm_cp4a_cr_production_application.yaml					ibm_cp4a_cr_starter_content.yaml
ibm_cp4a_cr_production_FC_decisions.yaml				ibm_cp4a_cr_production_content.yaml					ibm_cp4a_cr_starter_decisions.yaml
ibm_cp4a_cr_production_FC_decisions_ads.yaml				ibm_cp4a_cr_production_decisions.yaml					ibm_cp4a_cr_starter_decisions_ads.yaml
ibm_cp4a_cr_production_FC_document_processing.yaml			ibm_cp4a_cr_production_decisions_ads.yaml				ibm_cp4a_cr_starter_document_processing.yaml
ibm_cp4a_cr_production_FC_foundation.yaml				ibm_cp4a_cr_production_document_processing.yaml				ibm_cp4a_cr_starter_foundation.yaml
ibm_cp4a_cr_production_FC_workflow-standalone.yaml			ibm_cp4a_cr_production_foundation.yaml					ibm_cp4a_cr_starter_workflow.yaml
ibm_cp4a_cr_production_FC_workflow-workstreams.yaml			ibm_cp4a_cr_production_workflow.yaml					ibm_cp4a_cr_starter_workflow_authoring-workstreams.yaml
ibm_cp4a_cr_production_FC_workflow.yaml					ibm_cp4a_cr_production_workflow_authoring.yaml				ibm_pf_cr_production_FC_process_flow_authoring.yaml
ibm_cp4a_cr_production_FC_workflow_authoring.yaml			ibm_cp4a_cr_production_workflow_process_service_authoring.yaml		ibm_pf_cr_production_process_flow_authoring.yaml
```

CR's with `_FC_` in their name are fully customizable CR's will all required and optional parameters.<br/>
Other CR's define only required parameters and omit optional parameters because they will be set to default values by the cloud-pak operator.<br/>

Ether way, these CR's are complicated and editing them directly is error prone.<br/>

> Lab step.<br/>
View `ibm_cp4a_cr_production_workflow_process_service_authoring.yaml` CR<br/>
We will work with Workflow Process Service Authoring capability in this module<br/>
This capability is designed to be small and CR is less complex than other patterns.<br/>
Optional parameters are not included, and set to default values by cloud pak operator.<br/>

```
cd $PATTERNS
cat ibm_cp4a_cr_production_workflow_process_service_authoring.yaml
```

> Lab step.<br/>
View `ibm_cp4a_cr_production_workflow.yaml`
This is Business Automation Worklow CR. You can see that this yaml file is more complex.<br/>
Optional parameters are not included, and set to default values by cloud pak operator.<br/>

```
cd $PATTERNS
cat ibm_cp4a_cr_production_workflow.yaml
```

> Lab step.<br/>
View `ibm_cp4a_cr_production_content.yaml` CR.<br/>
This is Content management pattern.<br/>
Optional parameters are not included, and set to default values by cloud pak operator.<br/>

```
cd $PATTERNS
cat ibm_cp4a_cr_production_content.yaml
```
It is clear that we need a way to understand and manage pattern CR's.<br/>

#### Preparing CR input - Prerequisites Script.

To help with cloud pak CR authoring, prerequisites script prepares input for cloud-pak CR.<br/>

Prerequsites script knows about patterns, their dependencies and compatibility.<br/>

> Refer to *pattern knowledge base* to review required, optional, and dependent components that can be installed for different patterns.<br/>

Prerequisites script works in steps designed to simplify and validate parameters required for the cloud-pak CR.<br/>

In the first step, script creates property files templates required by the capabilities we want to deploy.<br/>

In the second step, after property files are updated with required values, script creates database setup files, and yaml secrets.<br/>

In the third step, script validates property values, checking database logins, directory logins, storage classes, etc.<br/>

Prerequisites script is preparing property files as input for generating cloud pak CR.<br/>

The actual job of generating cloud pak CR is done by the `cp4a-deployment.sh` script.<br/>
It takes input created by the prerequisites script and generates cloud pak CR yaml file.<br/>

Scripts are located in the `$SCRIPTS` directory within cloud pak case package.<br/>
Prerequsites scirpt is `$SCRIPTS/cp4a-prerequisites.sh`.<br/>
CR generator script is `$SCRIPTS/cp4a-deployment.sh`.<br/>

We will work with the *Workflow Process Service Authoring* capability.<br/>

*Workflow Process Service Authoring* is a capability with a small footprint and resource usage for authoring and running workflows.<br/>

The authoring environment includes IBM Business Automation Studio and allows you to create, maintain, and edit Business Automation Workflows.<br/>

Setting property values created by the prerequisites script is an important step in preparing cloud pak CR.</br>
Input must be correct and pass validation.<br/>

For the purposes of this module, setting property values and validating input is time consuming and error prone.<br/>

We will take a shorcut for the `-m property` step, by copying property files from the pattern git repo.<br/>
```
$WPS_GIT/prereq/copy-properties.sh
```
Examine property files.<br/>
```
cd $SCRIPTS/cp4ba-prerequisites/propertyfile

cat cp4ba_LDAP.property
cat cp4ba_user_profile.property
```
Generate artifacts (secrets, database scripts, etc), that depend on property files.<br/>
```
cd $SCRIPTS
./cp4a-prerequisites.sh -m generate
```

Apply generated ldap secret.<br/>
This step is important. Without this step validation step fails, and CR deployment fails.<br/>
```
cd $SCRIPTS/cp4ba-prerequisites/secret_template
oc apply -f ./ldap-bind-secret.yaml
```

Validate CR prerequisites.<br/>
```
cd $SCRIPTS
./cp4a-prerequisites.sh -m validate
```
Observe validation output for *storage classes* and *ldap* directory.<br/>

Find directory service in `openldap` project to explain how ldap validation works.<br/>

Generate CR.<br/>
`cp4a-deployment.sh` script is used for CR generation.<br/>
This script takes output from the `cp4a-prerequisites.sh` and generates CR in `$SCRIPTS/generated-cr` directory.<br/>
There are a number of options available for CR generation: the size of the deployment, etc.<br/>

We will take a shortcut and copy CR from the pattern git repo.<br/>
```
$WPS_GIT/generated-cr/copy-cr.sh
```

> Review final CP4BA CR `$SCRIPTS/generated-cr/ibm_cp4a_cr_final.yaml`.<br/>
```
cd $SCRIPTS/generated-cr

cat ibm_cp4a_cr_final.yaml
```
We showed how to create CR yaml file from input property files with simple name - value syntax.<br/>

> *Do not deploy cloud-pak CR at this time.*


### Using `yq` to work with the CP4BACluster CR

CP4BACluster CR is complex and contains multiple components from patterns selected for installation.><br/>

There are sections for different components. Some sections are shared between all patterns and some sections are component specific.<br/>

For example, shared configuration for ldap and datasource configuration applies to all capabilities.<br/>

You can view CP4BA CR in text editor and search for specific parameters.<br/>

Another way to examine CR is to use tools like `yq` to query CR yaml with json path.<br/>

`yq` is yaml processor. Please note that *json is valid yaml syntax*.<br/>

Json syntax is more compact and easier to interpret. You can choose yaml or json output format from yq.<br/>
By default `yq` outputs json. Pass `-y` flag to `yq` to get yaml output.<br/> 
Quote `yq` query expressions, to prevent shell from pre-processing special characters.</br>

>*Lab Steps*<br/>
> Query `metadata` portion of CP4BA CR as json:<br/>
```
cd $SCRIPTS/generated-cr
```
```
cat ibm_cp4a_cr_final.yaml | yq '.metadata'
{
  "name": "icp4adeploy",
  "labels": {
    "app.kubernetes.io/instance": "ibm-dba",
    "app.kubernetes.io/managed-by": "ibm-dba",
    "app.kubernetes.io/name": "ibm-dba",
    "release": "23.0.1"
  }
}
```

> Query CR `metadata` as yaml:<br/>
```
cd $SCRIPTS/generated-cr
```
```
cat ibm_cp4a_cr_final.yaml | yq -y '.metadata'
name: icp4adeploy
labels:
  app.kubernetes.io/instance: ibm-dba
  app.kubernetes.io/managed-by: ibm-dba
  app.kubernetes.io/name: ibm-dba
  release: 23.0.1
```

> Query CR storage configuration:<br/>
```
cd $SCRIPTS/generated-cr
```
```
cat ibm_cp4a_cr_final.yaml | yq '.spec.shared_configuration.storage_configuration'
{
  "sc_slow_file_storage_classname": "ocs-storagecluster-cephfs",
  "sc_medium_file_storage_classname": "ocs-storagecluster-cephfs",
  "sc_fast_file_storage_classname": "ocs-storagecluster-cephfs",
  "sc_block_storage_classname": "ocs-storagecluster-ceph-rbd"
}
```

> Query CR ldap configuration:<br/>
```
cd $SCRIPTS/generated-cr
```
```
cat ibm_cp4a_cr_final.yaml | yq '.spec.ldap_configuration'
{
  "lc_selected_ldap_type": "IBM Security Directory Server",
  "lc_ldap_server": "worker1.cloudpak.szesto.io",
  "lc_ldap_port": "31389",
  "lc_bind_secret": "ldap-bind-secret",
  "lc_ldap_base_dn": "dc=example,dc=org",
  "lc_ldap_ssl_enabled": false,
  "lc_ldap_ssl_secret_name": "ibm-cp4ba-ldap-ssl-secret",
  "lc_ldap_user_name_attribute": "*:uid",
  "lc_ldap_user_display_name_attr": "cn",
  "lc_ldap_group_base_dn": "ou=users,dc=example,dc=org",
  "lc_ldap_group_name_attribute": "*:cn",
  "lc_ldap_group_display_name_attr": "cn",
  "lc_ldap_group_membership_search_filter": "(|(&(objectclass=groupofnames)(member={0}))(&(objectclass=groupofuniquenames)(uniquemember={0})))",
  "lc_ldap_group_member_id_map": "groupofnames:member",
  "tds": {
    "lc_user_filter": "(&(cn=%v)(objectclass=inetOrgPerson))",
    "lc_group_filter": "(&(cn=%v)(|(objectclass=groupofnames)(objectclass=groupofuniquenames)(objectclass=groupofurls)))"
  }
}
```

> Review json path syntax: [json path](https://github.com/json-path/JsonPath)

> Write more queries to see different portions of CP4BA CR.


### Using Kustomize to work with CP4BA Cluster CR.**

By reviewing output of ldap CR query, we see that some parameters, like Ldap server Host and Port, will be different between environments.<br/>

We deployed ldap server on the cluster, and from the pod it is faster to reach ldap using cluster service url, rather than external node port url.<br/>

#### This is KEY
We do not want to make direct changes to CR or to keep multiple copies of CR for different environments.<br/>

`Kustomize` is standard kubernetes tool to apply patches to kubernetes resources.<br/>
`Kustomize` is integrated with `oc` command and invoked with `oc kustomize`.<br/>

We will show examples how to customize `namespace`, `labels`, `annotations`, and how to patch CP4BA CR with environment specific values.<br/>

`Kustomize` overlay idiom is to have *base* directory with original resources and *overlay* directories with kustomizations for each environment.<br/>

> *Lab Steps*<br/>
Copy `kustomize` directory from the git repo.<br/>
This will also copy generated cr into kustomize base.<br/>
```
$WPS_GIT/kustomize/copy-kustomize.sh
```

Review kustomization base.<br/>
CR file included in `resources` list will be processed by `kustomize`.<br/>

```
cd $SCRIPTS/kustomize/base
cat kustomization.yaml

apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
- ibm_cp4a_cr_final.yaml
```

Note that there are no kustomizations in this file yet.<br/>

#### Dev overlay kustomizations.

> *Lab Steps*<br/>
> Change to the `overlay/dev` directory and review development `kustomiztion.yaml` file.

```
cd $SCRIPTS/kustomize/overlay/dev
cat kustomization.yaml

apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

namespace: cp4ba

commonLabels:
  stack: dev1

commonAnnotations:
  ibmSupport: 1-800-IBM-SERV

bases:
- ../../base

patches:
- path: lc-ldap-server-patch.yaml
- path: lc-license-type-patch.yaml
```

`bases` key in `kustomization.yaml` list directories with resources to apply kustomizations.<br/>

Our `base/kustomizaion.yaml` file makes cloud-pak CR file kustomizable.<br/>

There are a number of standard `kustomize` transformers:<br/>

> `namespace` transformer will update namespace references.<br/>

> `commonLabels` transformer will add labels to `metadata/labels` field of the CR.<br/>

> `commonAnnotations` transformer will add annotations to `metadata/annotations`.<br/>

The `prefix/suffix` transformer adds a `prefix/suffix` to the `metadata/name` field for all resources.<br/>

Note that it is possible to create transformer configurations that are specific to the CR syntax.<br/>
We do not show this use case.<br/>

To kustomize other elements of the cloud-pak CR we will use patches.<br/>

We will kustomize *ldap server configuration*, *ldap server port*, and cloud-pak *license type*.<br/>

Patches are listed under `patches` key in `kustomization.yaml`.<br/>

> *Lab Steps*<br/>
> Review `lc-ldap-server-patch.yaml` in `overlay/dev` directory.<br/>

```
cd $SCRIPTS/kustomize/overlay/dev
cat lc-ldap-server-patch.yaml

apiVersion: icp4a.ibm.com/v1
kind: ICP4ACluster
metadata:
  name: icp4adeploy
spec:
  ldap_configuration:
    lc_ldap_server: openldap.openldap.svc
    lc_ldap_port: 1389
```

> Review `lc-license-type-patch.yaml` in `overlay/dev` directory.<br/>

```
cd $SCRIPTS/kustomize/overlay/dev
cat lc-license-type-patch.yaml

apiVersion: icp4a.ibm.com/v1
kind: ICP4ACluster
metadata:
  name: icp4adeploy
spec:
  shared_configuration:
    sc_deployment_license: non-production
```

This type of patch is called `patch strategic merge`.<br/>

> Apply `dev` overlay kustomizations:<br/>

```
cd $SCRIPTS/kustomize/overlay/dev

oc kustomize .
```

> Observe applied changes:

```
oc kustomize . | yq '.metadata.namespace'
oc kustomize . | yq '.metadata.labels'
oc kustomize . | yq '.metadata.annotations'
oc kustomize . | yq '.spec.ldap_configuration.lc_ldap_server'
oc kustomize . | yq '.spec.ldap_configuration.lc_ldap_port'
oc kustomize . | yq '.spec.shared_configuration.sc_deployment_license'
```

#### prod overlay kustomizations

> Change to the `overlay/prod` directory and review `kustomiztion.yaml` file.

> *Lab Steps*<br/>

```
cd $SCRIPTS/kustomize/overlay/prod
cat kustomization.yaml

apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

namespace: cp4ba

commonLabels:
  stack: prod1

commonAnnotations:
  ibmSupport: 1-800-IBM-SERV

bases:
- ../../base

patchesJson6902:
- path: multi-json-patch.json
  target:
    group: icp4a.ibm.com
    version: v1
    kind: ICP4ACluster
    name: icp4adeploy
```

Note that we are using different key for the patch: `patchesJson6902`.<br/>

This type of patch allows multiple `add/delete/replace` customizations.<br/>

> Review `multi-json-patch.json` file.<br/>

```
cat multi-json-patch.json

[
  {
    "op": "replace",
    "path": "/spec/ldap_configuration/lc_ldap_server",
    "value": "openldap.openldap.svc"
  },
  {
    "op": "replace",
    "path": "/spec/ldap_configuration/lc_ldap_port",
    "value": "1389"
  },
  {
    "op": "replace",
    "path": "/spec/shared_configuration/sc_deployment_license",
    "value": "production"
  }
]
```

> Apply `prod` overlay kustomizations:<br/>

```
cd $SCRIPTS/kustomize/overlay/prod

oc kustomize .
```

> observe applied changes:<br/>

```
oc kustomize . | yq '.metadata.namespace'
oc kustomize . | yq '.metadata.labels'
oc kustomize . | yq '.metadata.annotations'
oc kustomize . | yq '.spec.ldap_configuration.lc_ldap_server'
oc kustomize . | yq '.spec.ldap_configuration.lc_ldap_port'
oc kustomize . | yq '.spec.shared_configuration.sc_deployment_license'
```

#### Differences between kustomizations.

> *Lab Steps*<br/>
> Save `oc kustomize` output in each overlay directory and then run `diff` command to see differences.<br/>

```
cd $SCRIPTS/kustomize

oc kustomize overlay/dev/ > kustomized-cr-dev.yaml
oc kustomize overlay/prod/ > kustomized-cr-prod.yaml
```

```
diff --color kustomized-cr-dev.yaml kustomized-cr-prod.yaml
11c11
<     stack: dev1
---
>     stack: prod1
43c43
<     sc_deployment_license: non-production
---
>     sc_deployment_license: production
47a48
>     sc_drivers_url: null
```

You can see that strategic patch merge removed null `sc_drivers_url` key and 6902 json patch preserved the null value.<br/>
