### Lab Map.

There are 4 modules in this lab: CP4BA multi-pattern CR, CP4BA mutl-pattern operator, Foundational Services Operators and Services, and Workflow Process Authoring Capability.<br/>

Lab requires access to OpenShift cluster.<br/>

To make it simplier to follow the lab, pre-configured *bastion* container is deployed to the cluster.<br/>
*bastion* container has all tools and environment already setup.<br/>
You can review *bastion* docker file in the `bastion` git directory.<br/>
CP4BA case package is pre-installed on the *bastion* container.<br/>

You can follow the lab from your laptop.<br/>
Lab requires `oc`, `python`, `yq`, `jq`, `diff`, `git`, `ldapsearch`. These are usually available on macos, and linux, but require installation on windows.<br/>
If you are working from your laptop, you will need to download and install CP4BA case package.<br/>
Case package download and install is described in `install-cp4ba-case-package-steps.md` file.<br/>
After you install cp4ba case package, run `case-package-env.sh` script to setup environment variables.<br/>

All these steps are already completed on the `bastion` container.<br/>
`bastion` container is deployed to the `bastion` namespace.<br/>

If you want to deploy `bastion` container in more than one project, follow `deploy-bastion.md` in `bastion` lab directory.<br/>

Lab github url: [cplab github] (`https://github.com/sgod1/cplab`) <br/>
OpenShift cluster url and credentials will be provided for the lab<br/s>

### Log into the bastion container.
Repeat this step when you want to log into the `bastion` container.<br/>

Log into the OpenShift console, and switch to the `bastion` project.<br/>
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

### Create cp4ba project for the cloud pak.
Create `cp4ba` project for the cloud pak.<br/>
From the *bastion* terminal window, run:<br/>
```
oc new project cp4ba
```

#### Module 1.
Module 1 is about managing CP4BA multi-pattern cloud pak CR.<br/> 
Techniques disussed in this module are applicable to other cloud paks.<br/>

Follow `cp4ba-cr.md` to complete module 1.<br/>

#### Module 2.
Module 2 is about CP4BA multi-pattern operator.<br/>
This module discusses CP4BA cloud pak install and static dependencies.<br/>
This module concludes with cloud pak CR production overlay deployment.<br/>

Follow `deploy-cp4ba-cr.md` to complete module 2.<br/>

#### Module 3.
Module 3 is about `Foundational Services`.<br/>
This module discusses Foundational Operators and Services, ODLM, and on-demand dependecy resolution.<br/>
This module concludes with multi-tenancy and workload isolation.<br/>

Follow `foundational-services.md` to complete module 3.<br/>

#### Module 4.
Module 4 is a brief review of deployed CP4BA capability `Workflow Process Service Authoring`.<br/>

Follow 'workflow-process-service-authoring.md' to complete module 4.<br/>
