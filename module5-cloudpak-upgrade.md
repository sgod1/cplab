### Cloud Pak upgrade.

Cloud Pak upgrade procedure depends on a `FROM` verion and `TO` version.<br/>

Specific steps may vary, and are published by IBM Support.<br/>

Upgrade procedure is driven by Cloud Pak operator switching to new subscription channel and upgrading operator pods.<br/>

Operator upgrade is followed by the operand upgrade.<br/>

Use of operators simplifies user experience during upgrade.<br/>

At upgrade time, Foundational Services operator resolves versions for singleton Foundational Services deployed at cluster scope,<br/>
and for any Foundational Service deployed at cluster level in `all namspaces` mode.<br/>

Adopt workload isolation for best upgrade experience.<br/>
