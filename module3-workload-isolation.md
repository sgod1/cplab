#### Workload isolation topologies.
We present a number of isolation topologies, and discuss the role foundational services play to support workload isolation.<br/>

Each topology will make a choice on the placement of foundational operators, and foundational services (operands), and this choice will enable a variety of workload isolation patterns.<br/>

Examples of foundational services: `im`, `zen`, 'Flink`, `Elastic Search`, etc.<br/>

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

#### Simple Isolation.
By default, Cloud Pak operator is installed in 'one namespace' mode with foundational services in the same namespace.<br/>

This topology enables maximum isolation between cloud pak deployments. Each cloud pak deployment can be upgraded independently.<br/>

![Simple Isolation](./images/2-namespace-request.drawio.png)

#### Cloud Paks and Namespaces for the Same Tenant with Shared Services
`Tenant` is a line of business. Foundational services and operators are installed in shared namespace.<br/>
There is only one instance of `im` and `zen` deployments shared by `tenant` cloud paks.<br/>
Services that are not shared, are created in the requestor namespace.<br/>
This topology requires compatible cloud pak versions with respect to foundational services.<br/>
To enable this topology, foundational services namespace must be created and configured first.<br/>
Because this is single tenant topology, versions and upgrades must be coordinated withing the business unit.<br/>

![Multi Namespace](./images/multi-namespacesx.drawio.png)

#### All Namespace Mode Installation with Single-Tenancy
In `All Namespace` mode the whole cluster is allocated for one tenant.<br/>

If cloud pak operator is installed in 'all-namespaces' mode, then foundational services operators must be installed in `all namespaces` mode.<br/>
If one cloud pak operator is installed in 'all-namespaces' mode, then all other cloud pak operators must be installed in `all-namespaces` mode.<br/>

![All Namespace](./images/allnamespacesst.drawio.png)


### Cloud Pak Cluster Topology Considerations

It is recommended that cloud paks are installed in isolated namespaces and not share foundational services.<br/>


> IBM recommends, that Cloud Pak namespaces be labeled and assigned to machine sets. Machine set must have 3 or more nodes<br/>
> Private topology is prefred to isolate all services by tenant (namespace). IBM recommends that each cloud pak instance is installed with it's own dedicated foundational services.<br/>
> Cloud Paks can be deployed to Machine Sets (grouping of worker nodes that scale up and down) to provide workload isolation for worker nodes. For clusters with in Cloud Availability Zones, worker nodes should be placed accross all zones.<br/>
