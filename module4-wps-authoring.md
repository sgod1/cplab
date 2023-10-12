## Workflow Process Service Authoring pattern.

# This is DRAFT!

IBM CP4BA Workflow Process Service is a small-footprint business automation environment<br/>
to develop, test, and run workflow processes that orchestrate human tasks and services.<br/>
It provides single runtime conntainer.<br/>

Workflow Process Service is offered only as part of CP4BA cloud pak.<br/>

Workflow Process Service Authoring pattern is composed of a number of components.<br/>

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

Buisness automation studio component from business automation foundation is always deployed.<br/>
