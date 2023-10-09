### Introduction

The goal of this module is to learn about Cloud Pak for Business Automation in the context of Open Shift.

This module is delivered as a follow up to Open Shift training.

Cloud Pak for Business Automation was selected because of the interests of the audience.

Workflow Service Authoring pattern has small footprint and on-cluster dependencies.<br/>
Postgres Database is part of the Cloud Pak, and Open LDAP is an additional deployment.

We do not discuss Business Automation functionality.

Focus is on the Cloud Pak in the context of Open Shift.

Lab steps are simple and support explanation of topics in Cloud Pak architecture.<br/>
Prerequisites and documented steps are placed in *steps* files.

### Cloud Pak on Open Shift Lab overview.

We start with high-level Cloud Pak architecture and how it integrates with Open Shift.<br/>

We study *ICP4ACluster*, custom resource for CP4BA multi-pattern operator. We create *Workflow Process Service Authoring* CR. We focus on ways to manage complexity, query CR, and manage differences between environments with kustomize.<br/>

We install CP4BA operator and discuss operator dependencies.<br/>

We apply production kustomizations to ICP4A CR and start cloud pak install. This may take some time to complete.<br/>

We study *Foundational Services* Operators and runtime on-demand operator dependency resolution.<br/>

We review *Foundational Sevices* impact on multi-tenancy cloud pak deployments.<br/>

After CP4BA install is complete, we log into the Cloud Pak console for a brief review of *Workflow Process Service Authoring* environment. We review running pods and storage claims.

We review workload isolation patterns and best practice for cloud pak deployment.<br/>

### Lab Map.

There are 4 modules in this lab: *CP4BA multi-pattern CR*, *CP4BA mutl-pattern operator*, *Foundational Services Operators and Services*, and *Workflow Process Authoring Capability*.<br/>

Lab requires access to OpenShift cluster.<br/>

To simplify the lab, pre-configured *bastion* container is deployed to the cluster.<br/>
*bastion* container has all tools and environment already setup.<br/>
You can review *bastion* docker file in the `bastion` git directory.<br/>
CP4BA case package is pre-installed on the *bastion* container.<br/>
*Basition* container is deployed to *cp4ba* project.<br/>

You can follow the lab from your laptop.<br/>
Lab requires `oc`, `python`, `yq`, `jq`, `diff`, `git`, `ldapsearch`.<br/>
These are usually available on macos, and linux, but require installation on windows.<br/>
If you are working from your laptop, you will need to download and install CP4BA case package.<br/>
Case package download and install is described in `install-cp4ba-case-package-steps.md` file.<br/>
After you install cp4ba case package, run `setup-case-package-env.sh` script to setup environment variables.<br/>

All these steps are already completed on the `bastion` container.<br/>
`bastion` container is deployed to the `cp4ba` namespace.<br/>

It is possible to deploy `bastion` container in more than one project.<br/>
Follow `deploy-bastion.md` in `bastion` lab directory.<br/>

Lab github url: [cloud pak lab github](`https://github.com/sgod1/cplab`) <br/>
OpenShift cluster url and credentials will be provided for the lab<br/s>

### Log into the bastion container.
Repeat this step when you want to log into the `bastion` container.<br/>

Log into the OpenShift console, and switch to the `cp4ba` project.<br/>
Find `bastion` deployment, follow deployment pods to find `bastion` pod and click on the `Terminal` tab.<br/>
Click `exapand` button on the upper right, to expand terminal window.<br/>

In the `bastion` pod terminal window run `oc login` command.
```
oc login api:6443 --insecure-skip-tls-verify=true  -u <user> -p <password>
```
```
oc get nodes
```
You should see a list of cluster nodes.<br/>

#### Module 1.
Module 1 is about managing CP4BA multi-pattern cloud pak CR.<br/> 
Techniques disussed in this module are applicable to other cloud paks.<br/>

Follow `module1-cp4ba-cr.md` to complete module 1.<br/>

#### Module 2.
Module 2 is about CP4BA multi-pattern operator.<br/>
This module discusses CP4BA cloud pak install and static dependencies.<br/>
This module concludes with cloud pak CR production overlay deployment.<br/>

Follow `deploy-cp4ba-cr.md` to complete module 2.<br/>

#### Module 3.
Module 3 is about `Foundational Services`.<br/>
This module discusses Foundational Operators and Services, ODLM, and on-demand dependecy resolution.<br/>
This module concludes with multi-tenancy and workload isolation.<br/>

Follow `module3-foundational-services.md` to complete module 3.<br/>

#### Module 4.
Module 4 is a brief review of deployed CP4BA capability `Workflow Process Service Authoring`.<br/>

Follow `workflow-process-service-authoring.md` to complete module 4.<br/>

#### Module 5.
Module 5 is about cloud pak upgrade.

