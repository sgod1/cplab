#### Workload isolation topologies.

## This is a DRAFT...

By default, cloud pak operator is installed in 'one namespace' mode with foundational services in the same namespace.<br/>

This topology enables maximum isolation between cloud pak deployments. Each cloud pak deployment can be upgraded independently.<br/>

Another topology is to install foundational services in one namespace and cloud pak operators in another namespace.<br/>
In this case foundational services can be shared by a tenant. Foundational service operators must be given access to tenant namespaces.

Another topology is to place operators in one namespace and create operands in another namespace.<br/>
This approach is taken by Cloud Pak for Data.<br/>

If cloud pak operator is installed in 'all-namespaces' mode, then foundational services operators must be installed in `all namespaces` mode.<br/>
If one cloud pak operator is installed in 'all-namespaces' mode, then all other cloud pak operators must be installed in `all-namespaces` mode.<br/>

It is recommended that cloud paks are installed in isolated namespaces and not share foundational services.<br/>

#### Simple Isolation.
![Simple Isolation](./images/2-namespace-request.drawio.png)

#### Cloud Paks and Namespaces for the Same Tenant with Shared Services
![Multi Namespace](./images/multi-namespacesx.drawio.png)

#### All Namespace Mode Installation with Single-Tenancy
![All Namespace](./images/allnamespacesst.drawio.png)


### Cloud Pak Cluster Topology Considerations

> IBM recommends, that Cloud Pak namespaces be labeled and assigned to machine sets. Machine set must have 3 or more nodes<br/>
> Private topology is prefred to isolate all services by tenant (namespace). IBM recommends that each cloud pak instance is installed with it's own dedicated foundational services.<br/>
> Cloud Paks can be deployed to Machine Sets (grouping of worker nodes that scale up and down) to provide workload isolation for worker nodes. For clusters with in Cloud Availability Zones, worker nodes should be placed accross all zones.<br/>
