#### Workload isolation topologies.
We present a number of isolation topologies, and discuss the role foundational services play to support workload isolation.<br/>

Each topology will make a choice on the placement of foundational operators, and foundational services (operands), and this choice will enable a variety of workload isolation patterns.<br/>

Examples of foundational services: `im`, `zen`, `Flink`, `Elastic Search`, etc.<br/>

Ask about Foundational Services:<br/>
- What is the namespace for Foundational Services operators? Make a note of *operatorNamespace* value.<br/>
- What is the namespace for Foundational Sevices operands? Make a note of *servicesNamespace* value.<br/>

Ask about Cloud Pak operator:
- What is the namespace for Cloud Pak operator?
- What is the namespace for Cloud Pak operand?

We will discuss mechanics of Foundational Sevices in our next module, but it is important to know that Cloud Pak operator<br/>
requests Foundational Services as needed.<br/>

For example, to request `im` and `zen` foundational sevices, Cloud Pak operator creates *OperandRequest* CR for *ODLM* operator.<br/>

Request created by the Cloud Pak operator must be visible to *ODLM* operator, otherwise nothing will happen.<br/>

*This is key:*<br/>
When acting on Cloud Pak request, *ODLM* operator will place `im` and `zen` operators in *operatorNamespace*<br/>
and their operands (`im` deployment, and `zen` deployment) in *servicesNamespace*<br/>
These namespaces can be the same or different.<br/>

Cloud Pak operators requesting *shared* Foundational Services like `im` or `zen` get the same Foundational Sevice instance.<br/>

Cloud Pak operators requesting Foundational Services like `Flink` that are not shared between Cloud Pak capabilities,<br/>
will trigger `Flink` operator install by *ODLM* and must create `Flink` CR themselves, triggering `Flink` operand deployment.<br/>
`Flink` operator will be installed by *ODLM* in *operatorNamespace* and `Flink` operand will be installed by `Flink` operator<br/>
in Cloud Pak namespace.<br/>

*One Namespace Request Example*.
![One Namespace Request](./images/1-namespace-request.drawio.png)

<br/>

#### Simple Isolation. (A)
By default, Cloud Pak operator is installed in `one namespace` mode with foundational services in the same namespace.<br/>

This topology enables maximum isolation between cloud pak deployments. Each cloud pak deployment can be upgraded independently.<br/>

![Simple Isolation](./images/2-namespace-request.drawio.png)

<br/>

#### Cloud Paks and Namespaces for the Same Tenant with Shared Services. (B)
A `Tenant` is a line of business.<br/> 

Install Foundational Services operators and operands in one namespace.<br/>
Foundational Services (`im`, `zen`) will be shared within a `Tenant`.<br/>

Install Cloud Pak operators and operands in other namespaces.<br/>

Because this is single tenant topology, versions and upgrades must be coordinated within the business unit.<br/>

Foundational Services Operators namespace: *operatorNamespace*=`tenant1-services-namespace`.<br/>
Foundational Services Operand namespace: *servicesNamespace*=`tenant1-services-namespace`.<br/>

Cloud Pak for Business Automation namespace: `tenant1-cp4ba`<br/>
Cloud Pak for Integration namespace: `tenant1-cp4i`<br/>

Operators in `tenant1-services` must be able to watch `tenant1-cp4ba` and `tenant1-cp4i` namespaces.<br/>
This authorization is setup by `NamespaceScope operator`.<br/>

The reverse is not true: operators in `tenant1-cp4ba` and `tenant1-cp4i` namespaces are not watching `tenant1-services` namespace.<br/>

Shared services `im` and `zen` are created only once in `tenant1-services` namespace.<br/>

Services for `Flink`, etc are created in Cloud Pak operator namespaces.<br/>

![Multi Namespace](./images/multi-namespacesx.drawio.png)

<br/>

#### Install One Cloudpak into 2 namespaces. (C)
Install Foundational Services operators and Cloud Pak operator in one namespace.<br/>
Install Foundational Sevices operands, and Cloud Pak operands in another namespace.<br/>

In this topology, service accounts used by operators are different from service accounts used by operands.<br/>

Operator namespace is called `Control Namespace`, operand namespace is called `Data Namespace`.<br/>

Foundational Services Operators namespace: *operatorNamespace*=`tenant1-control`.<br/>
Foundational Services Operand namespace: *servicesNamespace*=`tenant1-data`.<br/>

Operators in `tenant1-control` namespace are watching `tenant1-data` namespace.<br/>
This authorization is setup by `NamespaceScope` operator.<br/>

Cloud Pak CR is created in `tenant1-data` namespace.<br/>

![Control and Data Separation](./images/control-data-separation.drawio.png)

<br/>

#### All Namespace Mode Installation with Single-Tenancy (D)
In `All Namespace` mode the whole cluster is allocated for one tenant.<br/>

All Cloud Pak operators and all Foundational Services operators will be installed in `all-namespaces` mode.<br/>

Foundational Services Operators namespace: *operatorNamespace*=`openshift-operators`.<br/>
Foundational Services Operand namespace: *servicesNamespace*=`ibm-common-services`.<br/>

Cloud Pak operators are installed in `openshift-operators` namespace.<br/>
Cloud Pak operands are deployed to `cp4i-a` and `cp4i-b` namespace.<br/>

Operators in `openshift-operators` namespace are watching `ibm-common-services` namespace and Cloud Pak operand namespaces.<br/>

![All Namespace](./images/allnamespacesst.drawio.png)

<br/>

### Cloud Pak for Data Topologies. (E)
Cloud Pak for data adopts `Operators - Operands - Data` topology.<br/>

This topology is a combination of `Topology B` and `Topology C`.<br/>

Foundational Services Operators and Foundational Services Operands are placed in different namespaces. (Topology *C*).<br/>

Foundational Sevices Operands are shared by Cloud Pak Operands. (Topology *B*).<br/>

Foundational Services Operators namespace: *operatorNamespace*=`cpd-operators`.<br/>
Foundational Services Operand namespace: *servicesNamespace*=`cpd-instance`.<br/>

Operators in `cpd-operators` are watching `cpd-instance` namespace and `cpd-instance-tethered1` and `cpd-instance-tethered2` namespaces.<br/>
Secrets from `cpd-instance` namespace are copied to tehtered namespaces, for access to Common Services.<br/>

![Control - Shared Services - Data](./images/cp4dataTopology.drawio.png)

<br/>

![Control - Shared Services - Data](./images/cp4d-private-topology-detailed.svg)

<br/>

### Cloud Pak Cluster Topology Considerations
IBM recommends, that Cloud Pak namespaces be labeled and assigned to machine sets. Machine set must have 3 or more nodes<br/>

Private topology is prefred to isolate all services by tenant (namespace).<br/>
IBM recommends that each cloud pak instance is installed with it's own dedicated foundational services.<br/>

Cloud Paks can be deployed to Machine Sets (grouping of worker nodes that scale up and down) to provide workload isolation for worker nodes.<br/> 
For clusters with in Cloud Availability Zones, worker nodes should be placed accross all zones.<br/>
