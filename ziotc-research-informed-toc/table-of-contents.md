# Zebra IoT Connector

Table of contents. The order is the journey from a first tag through deployment and support.

Product facts for FXR60 and FXR90 stay in `FXR_60-90_mqtt_api.json` and
`FXR_60-90_rest_api.yaml`. The
[official Zebra IoT Connector documentation](https://zebradevs.github.io/rfid-ziotc-docs/)
is a second source for product architecture, terminology, web-console workflows,
deployment modes, migration, and embedded data-analytics applications. That site
currently identifies FX7500, FX9600, and ATR7000 as its supported readers, so a
legacy-reader behavior must not be applied to FXR60 or FXR90 until the current
contract, release notes, or engineering confirms it.

A page marked **Confirm** is a heading the FXR contracts do not yet define. Do
not write it as current-reader behavior until engineering confirms it.

One page owns each task. The quickstart and the tutorials link to that page. They do not copy it.

The contracts call a connection endpoint configuration. This guide says endpoint after the first explanation. Management, Control, Data, and Management Events are the four interface roles in section 1.

## Who starts where

| Role | Start at |
|---|---|
| Solution architect | 1. Overview, then 5 and 9 |
| IT administrator or network engineer | 3. Prepare the Reader and Network, then 5 |
| System integrator | 2. Quickstart, then 4 and 6 |
| Application developer | 2. Quickstart, then 7, 8, and 12 |
| Cloud or DevOps engineer | 5. Connect a Destination, then 8 and 9 |
| Operations or support engineer | 10. Monitor and Maintain, then 11 |

## Page types

- **Concept** explains the model.
- **Task** does one job.
- **Tutorial** is an ordered list of links.
- **Reference** points at the contract. Schemas stay in the contract files.
- **Troubleshooting** starts from a symptom and links to the task that owns the fix.

## Published documentation

Source: [Zebra IoT Connector documentation](https://zebradevs.github.io/rfid-ziotc-docs/). The [about page](https://zebradevs.github.io/rfid-ziotc-docs/about/index.html) says this set covers FX7500, FX9600, and ATR7000. Use it for the product model and the web-console workflow. Do not copy an FX or ATR procedure onto FXR60 or FXR90 until the FXR contract or engineering confirms it.

The same about page describes the chapters as overview, deployment modes, operation modes, setup for a hybrid MQTT and HTTP POST deployment, how-to guides for AWS and Azure, the local REST API, and schemas.

| Published chapter | Use it in |
|---|---|
| [What is IoT Connector?](https://zebradevs.github.io/rfid-ziotc-docs/introduction/intro/index.html) | 1. Overview |
| [Deployment modes](https://zebradevs.github.io/rfid-ziotc-docs/introduction/deployment_modes/index.html) | 1. Deployment Models |
| [Operating modes](https://zebradevs.github.io/rfid-ziotc-docs/introduction/operating_modes/index.html) | 6. Operating Modes |
| [Quick setup](https://zebradevs.github.io/rfid-ziotc-docs/setupziotc/index.html) | 2. Quickstart and 4. Configure Zebra IoT Connector |
| [How-to guides](https://zebradevs.github.io/rfid-ziotc-docs/other_cloud_support/MQTT/index.html) | 5. Connect a Destination and 6. GPIO |
| [Portal directionality](https://zebradevs.github.io/rfid-ziotc-docs/directionality/index.html) | 6, only if engineering adds it for FXR |
| [User applications](https://zebradevs.github.io/rfid-ziotc-docs/user_apps/index.html) | 8. Develop an Application |
| [Certificate management](https://zebradevs.github.io/rfid-ziotc-docs/certificate_management/index.html) | 5. Certificates |
| [Migration guides](https://zebradevs.github.io/rfid-ziotc-docs/migration/FxConnect/index.html) | 12. Migration Guides |
| [Batching and retention](https://zebradevs.github.io/rfid-ziotc-docs/batching_and_retention/tag_data/index.html) | 5. Batching and retention |
| [Local REST APIs](https://zebradevs.github.io/rfid-ziotc-docs/api_ref/local_rest/index.html) | 12. REST API |
| [Schemas](https://zebradevs.github.io/rfid-ziotc-docs/schemas/operating_modes/index.html) | 12. Reference |

### About this documentation

- [Introduction](https://zebradevs.github.io/rfid-ziotc-docs/about/index.html)
- [Supported Readers](https://zebradevs.github.io/rfid-ziotc-docs/about/index.html#supported-readers): FX7500, FX9600, ATR7000
- [Chapter Descriptions](https://zebradevs.github.io/rfid-ziotc-docs/about/index.html#chapter-descriptions)
- [Related Documents and software](https://zebradevs.github.io/rfid-ziotc-docs/about/index.html#related-documents-and-software)
- [Service Information](https://zebradevs.github.io/rfid-ziotc-docs/about/index.html#service-information)

### Overview

- [What is IoT Connector?](https://zebradevs.github.io/rfid-ziotc-docs/introduction/intro/index.html). This page lists four interfaces: Management, Health, Control, and Data. The same page also describes a Management Events interface. It says two data endpoints can be configured.
- [System Overview](https://zebradevs.github.io/rfid-ziotc-docs/introduction/intro/index.html#system-overview)

### Deployment modes

From [Deployment modes](https://zebradevs.github.io/rfid-ziotc-docs/introduction/deployment_modes/index.html):

- [Pure Cloud Deployment](https://zebradevs.github.io/rfid-ziotc-docs/introduction/deployment_modes/index.html#pure-cloud-deployment). Management, Control, and Data all connect to a cloud provider. The page names AWS IoT Core and Azure IoT Hub.
- [Local Deployment](https://zebradevs.github.io/rfid-ziotc-docs/introduction/deployment_modes/index.html#local-deployment). All interfaces stay local. Data goes to an HTTP/HTTPS server or an MQTT broker. Management and Control can be local REST or MQTT.
- [Hybrid Deployment](https://zebradevs.github.io/rfid-ziotc-docs/introduction/deployment_modes/index.html#hybrid-deployment). Control, Management, and Data can use different endpoints.
- [REST APIs](https://zebradevs.github.io/rfid-ziotc-docs/introduction/deployment_modes/index.html#rest-apis)

### Operating modes

From [Operating modes](https://zebradevs.github.io/rfid-ziotc-docs/introduction/operating_modes/index.html). The page body also names Conveyer. The sidebar headings are the five below.

- [Simple](https://zebradevs.github.io/rfid-ziotc-docs/introduction/operating_modes/index.html#simple)
- [Inventory](https://zebradevs.github.io/rfid-ziotc-docs/introduction/operating_modes/index.html#inventory)
- [Portal](https://zebradevs.github.io/rfid-ziotc-docs/introduction/operating_modes/index.html#portal)
- [Directionality](https://zebradevs.github.io/rfid-ziotc-docs/introduction/operating_modes/index.html#directionality)
- [Custom](https://zebradevs.github.io/rfid-ziotc-docs/introduction/operating_modes/index.html#custom)

Directionality is not an FXR60/FXR90 mode in the current contracts.

### Quick setup

[Quick Zebra IoT Connector Setup](https://zebradevs.github.io/rfid-ziotc-docs/setupziotc/index.html) says setup is three steps: add an endpoint, assign interfaces to endpoints, then start the IoT Connector service. The web path on that page is Communication > Zebra IoT Connector > Configuration. Endpoint types listed there: MQTT, HTTP server, AWS IoT Core, Azure IoT Hub, TCP, WebSockets, and keyboard emulation / HID.

- [ZIoT Connector Web Interface](https://zebradevs.github.io/rfid-ziotc-docs/setupziotc/index.html#ziot-connector-web-interface)
- [Reader Configuration](https://zebradevs.github.io/rfid-ziotc-docs/setupziotc/index.html#reader-configuration)
- [Start Reading Tags](https://zebradevs.github.io/rfid-ziotc-docs/setupziotc/index.html#start-reading-tags)
- [Testing](https://zebradevs.github.io/rfid-ziotc-docs/setupziotc/index.html#testing)

### How-to guides

- [Connect To AWS](https://zebradevs.github.io/rfid-ziotc-docs/other_cloud_support/AWS/index.html)
- [Connect To Azure](https://zebradevs.github.io/rfid-ziotc-docs/other_cloud_support/AZURE/index.html)
- [Connect To MQTT](https://zebradevs.github.io/rfid-ziotc-docs/other_cloud_support/MQTT/index.html)
- [Connect To HTTP POST](https://zebradevs.github.io/rfid-ziotc-docs/other_cloud_support/HTTP_POST/index.html)
- [Connect To TCPIP](https://zebradevs.github.io/rfid-ziotc-docs/other_cloud_support/TCPIP/index.html)
- [Connect To Web Socket](https://zebradevs.github.io/rfid-ziotc-docs/other_cloud_support/Web%20Sockets/index.html)
- [Connect To USB HID](https://zebradevs.github.io/rfid-ziotc-docs/other_cloud_support/HID/index.html)
- [Control GPOs and LED](https://zebradevs.github.io/rfid-ziotc-docs/controlling_gpio_n_led/index.html)
- [Control Operating Mode](https://zebradevs.github.io/rfid-ziotc-docs/controlling_operating_modes/index.html)
- [Perform Access Operations](https://zebradevs.github.io/rfid-ziotc-docs/performing_access_operations/index.html)
- [Configure HTTP file server](https://zebradevs.github.io/rfid-ziotc-docs/batching_and_retention/http_fileServer/index.html)
- [Configure Management Events](https://zebradevs.github.io/rfid-ziotc-docs/batching_and_retention/configure_mgmtEvents.html)

### Portal directionality, applications, and certificates

- [Portal Directionality User Guide](https://zebradevs.github.io/rfid-ziotc-docs/directionality/index.html)
- [Portal Directionality Web Interface](https://zebradevs.github.io/rfid-ziotc-docs/directionality/index.html#portal-directionality-web-interface)
- [User Applications](https://zebradevs.github.io/rfid-ziotc-docs/user_apps/index.html). Python or Node.js data-analytics apps. Local REST on `127.0.0.1` from those apps does not require a login, according to that page.
- [Python DA apps](https://zebradevs.github.io/rfid-ziotc-docs/user_apps/python/index.html)
- [NodeJS DA apps](https://zebradevs.github.io/rfid-ziotc-docs/user_apps/nodejs/index.html)
- [Packaging and Deployment](https://zebradevs.github.io/rfid-ziotc-docs/user_apps/packaging_and_deployment.html)
- [Certificate Management](https://zebradevs.github.io/rfid-ziotc-docs/certificate_management/index.html). That page says certificates are PFX only, with one server certificate, multiple client certificates, and app certificates. Client certificates are the type it recommends for IoT Connector.

### Migration, retention, API, and back matter

- [Migrating from FxConnect](https://zebradevs.github.io/rfid-ziotc-docs/migration/FxConnect/index.html). That page says IoT Connector supports the FxConnect HTTP POST and USB HID modes, and does not support USB flash or TCP/IP from FxConnect.
- [Migrating from 123RFID Desktop](https://zebradevs.github.io/rfid-ziotc-docs/migration/123RFID_Desktop/index.html)
- [Migrating from RFID API-3](https://zebradevs.github.io/rfid-ziotc-docs/migration/RFIDAPI3/index.html)
- [Manage Tag Data Events](https://zebradevs.github.io/rfid-ziotc-docs/batching_and_retention/tag_data/index.html)
- [Local REST APIs](https://zebradevs.github.io/rfid-ziotc-docs/api_ref/local_rest/index.html)
- [Operating Modes schema](https://zebradevs.github.io/rfid-ziotc-docs/schemas/operating_modes/index.html)
- [RAW MQTT Payloads](https://zebradevs.github.io/rfid-ziotc-docs/schemas/raw_mqtt_payloads/index.html)
- [Management Events schema](https://zebradevs.github.io/rfid-ziotc-docs/schemas/async_event_schema/index.html)
- [Tag Data Events schema](https://zebradevs.github.io/rfid-ziotc-docs/schemas/tag_data_events/index.html)
- [Resources](https://zebradevs.github.io/rfid-ziotc-docs/resources/index.html)
- [Appendix](https://zebradevs.github.io/rfid-ziotc-docs/appendix/index.html)
- [FAQs](https://zebradevs.github.io/rfid-ziotc-docs/faqs/index.html)

## 1. Overview

| Page | Type | What this page owns |
|---|---|---|
| What is Zebra IoT Connector? | Concept | What the connector on the reader can do, and what is outside these contracts |
| How ZIoTC Works | Concept | Reader, connector, broker or HTTP destination, and the customer application |
| ZIoTC Architecture | Concept | Where commands, responses, and events go, and where configuration is stored |
| Interfaces | Concept | The four roles below. `set_config` writes data connections. `set_importCloudConfig` writes control, management, and management-event connections, and can write data. Included sections change. Omitted sections stay. The [published overview](https://zebradevs.github.io/rfid-ziotc-docs/introduction/intro/index.html) lists Management, Health, Control, and Data, and the same page also describes Management Events. Health on that page is not a fifth FXR contract interface until engineering says so |
| Management | Concept | Management command and response path |
| Control | Concept | Control command and response path. Local REST can run the same control calls and does not return tag, BLE, or management events |
| Data | Concept | Tag data events and BLE data events |
| Management Events | Concept | Heartbeat, GPI, GPO, userapp, error, and warning. Firmware progress and notifications publish on their own. They are not switches |
| Reader software components | Concept | Reader Gateway connects to external systems, Radio Control operates the RFID radio, Reader Manager performs management, and Reader Webserver handles web-console and local REST traffic. Confirm current-reader implementation details before exposing internals beyond names present in status and logs |
| Deployment Models | Concept | Pure cloud, local, and hybrid deployment. Include one reader and a broker, separate connections for control and data, RFID and BLE on different connections, and local REST for commands with MQTT for events. A fleet product is not in the contracts |
| Supported Readers and Versions | Reference | One compatibility matrix. The current contracts cover FXR60, FXR60 Premium, and FXR90. The linked official legacy guide covers FX7500, FX9600, and ATR7000. Record supported modes, endpoints, UI paths, firmware minimums, and limits per family instead of merging them |

Reader Gateway and Radio Control are named on How ZIoTC Works, because those names appear in the heartbeat, the logs, and event `component`. They are not their own section.

## 2. Quickstart: First Tag to MQTT in 15 Minutes

Tutorial only. Each step links to the task that owns the procedure.

Depends on a reader that already answers and an MQTT broker you control. Power wiring and a default address are not in the contracts.

| Step | Links to |
|---|---|
| Prerequisites | What you need before the first command: a path to the reader, broker host and port, and a tag in the field |
| Connect the Reader | Confirm the reader (`get_version`) and Sign in with local REST |
| Open ZIoTC Configuration | Use the reader web console where supported. The legacy path is Communication > Zebra IoT Connector > Configuration; confirm the FXR60/FXR90 path |
| Configure an MQTT Endpoint | Generic MQTT Broker. Connection type `mqtt` |
| Assign the Data Interface | Map the Data interface to that endpoint. The official product workflow is add endpoint, assign interfaces, then connect or start the service |
| Verify the Connection | Read interface connection status and connection-error information before configuring the radio |
| Configure SIMPLE Mode | SIMPLE under Operating Modes. `set_mode` replaces the whole mode |
| Start Reading | Start and stop. An empty body is RFID only |
| Receive the First Tag Event | Tag Data Events. SIMPLE reports `eventNum`, `format`, and `idHex`. Event `type` is the operating mode |
| Verify the Setup | Checklist: identity confirmed, start accepted, one tag data event received, stop accepted |

Identifying the reader can use MQTT `get_version` or local REST login and `GET /cloud/version`. That choice is a step here. It is not a second quickstart.

## 3. Prepare the Reader and Network

`set_network` changes one interface per call: `eth0`, `mlan0`, `bnep0`, `uap0`, and `wan0` on FXR90. A change can drop the path you are using. IP fields travel inside that interface object. They are not a separate command.

| Page | Type | What this page owns |
|---|---|---|
| Install and Connect the Reader | Task | **Confirm.** Mounting, power, and cables belong to the hardware guide. These contracts start after the reader answers |
| Discover the Reader | Task | **Confirm** how a reader is found on the network. After it answers, identity is `get_version` |
| Configure Ethernet | Task | `eth0`, except the 802.1X fields, which the next page owns |
| Configure Wi-Fi | Task | Join `mlan0`, including enterprise authentication. Discover networks first with `get_availableWifiNetworks`. `uap0` and `mlan0` cannot both be enabled |
| Configure IP Settings | Task | DHCP or static IPv4 or IPv6 inside the interface object. Ethernet, Wi-Fi, and cellular link here |
| Configure Time | Task | Clock and time settings. Regulatory region and reader name are set with this site setup: read `get_supportedRegionList` before `set_region` |
| Configure 802.1X | Task | 802.1X fields on `eth0` only. The rest of Ethernet stays on Configure Ethernet |
| Verify Network Connectivity | Task | The only copy of the checks after a network change. "Reader Cannot Be Reached" links here |

Also in this section, because the contracts include them:

| Page | Type | What this page owns |
|---|---|---|
| Configure cellular | Task | FXR90 `wan0` only. Physical SIM or eSIM (`set_eSimConfig`, `wan0.activeSim`), and the last GPS position |
| Use the reader as an access point | Task | `uap0`. Cannot be enabled with `mlan0` |
| Connect over a Bluetooth network | Task | `bnep0`. This is not a BLE scan |

Read points (`get_readPoints`) stay on Antennas. They name where the radio reads. They are not an IP address.

## 4. Configure Zebra IoT Connector

| Page | Type | What this page owns |
|---|---|---|
| Understand Endpoints | Concept | A named destination. The first time, say the contracts call this endpoint configuration |
| Understand Interfaces | Concept | Which of Management, Control, Data, and Management Events a call writes. Link to section 1. Do not explain the four roles again |
| Use the ZIoTC Web Interface | Task | Add, view, update, and delete endpoints; assign interfaces; view connection status and connection errors. Confirm the current FXR menu path against current firmware |
| Add an Endpoint | Task | Create one connection of a chosen type. The type-specific fields live in section 5 |
| Assign Interfaces to Endpoints | Task | Put control, data, and management events on the connections from Add an Endpoint. `set_config` and `set_importCloudConfig` rules stay on Understand Interfaces |
| Start ZIoTC | Task | The [published quick setup](https://zebradevs.github.io/rfid-ziotc-docs/setupziotc/index.html) ends by starting the IoT Connector service from the web console. **Confirm** the FXR60/FXR90 equivalent. The FXR contracts do not show a command that starts or stops the connector as a service. RFID start is in section 6 |
| Verify ZIoTC Status | Task | `get_status`, connection state, and `get_mode` with verbose true for the effective mode |
| Modify or Remove Configuration | Task | What a later `set_config` or `set_importCloudConfig` replaces, and what an omitted section leaves in place. Link to How configuration is saved on ZIoTC Architecture |

## 5. Connect a Destination

One page per destination type. Certificates are installed once, on Certificates, and referred to by name.

| Page | Type | What this page owns |
|---|---|---|
| Generic MQTT Broker | Task | Connection type `mqtt`: host, port, protocol, client ID, basic authentication, publish and subscribe topics, `qos`, `cleanSession`, `keepAlive`, and reconnect fields that exist in the schema. The legacy guide states MQTT 3.1.1; confirm the supported version for each FXR release |
| HTTP / HTTPS | Task | Connection type `httpPost` |
| AWS IoT | Task | Connection type `mqtt-AWS`. Only the fields that differ from Generic MQTT Broker |
| Azure IoT | Task | Connection type `mqtt-Azure`. Only the fields that differ from Generic MQTT Broker |
| Authentication | Task | Username and password on the connection, and local REST basic authentication. The local password change lives here |
| Certificates | Task | Install, name, select, and remove server, client, CA, or application certificates as supported. The legacy guide documents PFX-only reader certificates and recommends client certificates for ZIoTC; validate formats and certificate types on FXR60/FXR90 |
| Configure mutual TLS for MQTT | Task | Install trust and client identity, assign the certificate to the MQTT endpoint, connect, and verify both sides of the TLS session |
| Verify Connectivity | Task | How to tell the connection is up and that a command response or a tag data event arrived |

Also in this section, because the contracts include them:

| Page | Type | What this page owns |
|---|---|---|
| Google Cloud IoT | Task | Connection type `mqtt-GCP` |
| WebSocket, TCP server, or keyboard | Task | `WEBSOCKET`, `tcpip-server`, or `keyboard-emulation`. Only one of each of these three types at a time. Published how-tos: [TCP](https://zebradevs.github.io/rfid-ziotc-docs/other_cloud_support/TCPIP/index.html), [WebSocket](https://zebradevs.github.io/rfid-ziotc-docs/other_cloud_support/Web%20Sockets/index.html), [USB HID](https://zebradevs.github.io/rfid-ziotc-docs/other_cloud_support/HID/index.html) |
| Configure an HTTP file server | Task | Published page for retaining tag data on an HTTP file server: [Configure HTTP file server](https://zebradevs.github.io/rfid-ziotc-docs/batching_and_retention/http_fileServer/index.html). **Confirm** this on FXR60/FXR90 before writing it as a current-reader task |
| Configure tag-data batching | Task | `maxPayloadSizePerReport` and `reportingInterval`; explain endpoint-specific defaults and the network/CPU tradeoff |
| Configure tag-data retention and replay | Task | `maxEventRetentionTimeInMin`, `maxNumEvents`, and `throttle`; explain discard rules, reconnect replay, and capacity planning. The legacy guide says retained events are lost on reboot and may duplicate after reconnect; confirm that behavior on each FXR release |

**Confirm** before writing them as behavior: last will, retained messages, a required topic layout, command timeouts, TLS versions, and cipher suites. The schema fields named above can be documented now.

## 6. Configure RFID Operations

`stop` before changing the mode or BLE. `set_mode` replaces the whole mode.

| Page | Type | What this page owns |
|---|---|---|
| Operating Modes | Concept | What SIMPLE, INVENTORY, PORTAL, CONVEYOR, and CUSTOM change in the tag data event. CONVEYOR is in the contract, so it sits with the other four |
| SIMPLE | Task | Store SIMPLE. It does not accept tag metadata. It reports `eventNum`, `format`, and `idHex` |
| INVENTORY | Task | Store INVENTORY. `accesses` is not allowed |
| PORTAL | Task | Store PORTAL, including the GPI trigger. Radio start and stop conditions are not allowed in PORTAL |
| CONVEYOR | Task | Store CONVEYOR |
| CUSTOM | Task | Store CUSTOM, including memory access. `accesses` conflicts with some report and metadata settings |
| Antennas | Task | Ports, transmit power, environment, cable-loss compensation, and read points. FXR60 integrated antenna IDs are 5 and 6 |
| RF Settings | Task | RF preselection only: `rxSawFilter` through `set_preSelection`. This is not Gen2 select |
| Tag Filters | Task | Query, select, and prefix filter inside the mode. A prefix filter and selects cannot both be set. Which fields are reported stays on this page |
| Start and Stop Conditions | Task | Radio start and stop conditions, and antenna stop conditions. Not allowed in PORTAL. `start` and `stop` themselves: empty body is RFID only. `doNotPersistState` controls whether RFID resumes after reboot. BLE never resumes on its own |
| Gen2X | Task | Save exactly one of FastID, TagFocus, TagProtect, or TagQuieting. `start` applies the saved configuration. `start` does not create it. An empty object is rejected. `applyImpinjGen2X` cannot combine with a BLE `scanType` |
| GPIO | Task | GPI, GPO, and the application LED. `GPIO-LED` inside `set_config` replaces that whole object |
| BLE | Task | `set_bleConfig`, then start or stop. Reader build 4.0.11 or later for `scanType`. Empty `start` does not scan BLE. This is not `bnep0` |

There is not a separate concept page for each mode beyond the task that stores it. The shape of the event is Operating Modes. The task only stores that mode.

The legacy Zebra guide also documents a Directionality mode and a separate
Portal Directionality guide. Directionality is not in the current FXR60/FXR90
mode contracts, so it belongs in the compatibility matrix unless current
firmware and engineering add it to the FXR documentation set.

Display is FXR60. Stack light is FXR60 Premium. Those tasks live under Monitor and Maintain, because they are panel hardware rather than an RFID mode.

## 7. Receive Data and Events

Field tables stay in section 12. These pages say which message to expect.

| Page | Type | What this page owns |
|---|---|---|
| Understand ZIoTC Messages | Concept | Event versus command response. `command_id` matches a response to a command. Events are not command replies |
| Tag Data Events | Task | Read the event for the active mode. Inventory must be active. Event `type` equals the mode |
| BLE Events | Task | Read a BLE data event. It is not a tag data event |
| Management Events | Task | Read GPI, GPO, userapp, error, warning, firmware progress, and notification |
| Heartbeats | Task | Turn heartbeats on and read them: `radio_control`, `reader_gateway`, `system`, `userapps`. Compare with `get_status` |
| Commands and Responses | Concept | What the application sends and what comes back. The task of sending one is in section 8 |
| MQTT Topics | Reference | Publish and subscribe topic fields on the connection. **Confirm** any required topic layout. Do not invent one |
| Payload Examples | Reference | One example per event type, taken from the schema. Do not add fields the schema does not have |
| Identify and remove replay duplicates | Task | Use `eventNum` where the active schema supplies it. The legacy retention guide warns that reconnect can produce duplicates; define current-reader guarantees before generalizing the procedure |

**Confirm** duplicate delivery, reply ordering, and offline replay before any of those become their own pages.

## 8. Develop an Application

| Page | Type | What this page owns |
|---|---|---|
| Choose REST or MQTT | Concept | MQTT carries commands and tag, BLE, and management events. Local REST carries control calls and does not return those events |
| Subscribe to Tag Data | Tutorial | Links: Generic MQTT Broker, Data, SIMPLE or the chosen mode, Start and Stop Conditions, Tag Data Events |
| Send Reader Commands | Task | Send one command on the control connection |
| Match Commands and Responses | Task | Pair a response with `command_id` |
| Handle Errors | Task | Read an error response and a management error or warning. The code list stays in section 12 |
| Reconnect | Task | Use the reconnect fields the schema already has. **Confirm** session resume, duplicate commands, and missed events before writing them as guarantees |
| Sample Applications | Tutorial | Link-only sequences: portal, conveyor, RFID and BLE on different connections, REST for commands and MQTT for events. Do not paste a second copy of the tasks |
| Choose an external or embedded application | Concept | External applications use MQTT or REST. Embedded Data Analytics applications run on the reader and can filter, analyze, act on data, and call management/control REST APIs locally |
| Build a Python Data Analytics application | Tutorial | Current supported module, event handling, local API calls, testing, and version compatibility. The legacy guide moves from `ziotc.py` to built-in `pyziotc` at firmware 3.24.X; do not transfer that version rule to FXR without validation |
| Build a Node.js Data Analytics application | Tutorial | Supported runtime, event handling, local API calls, and testing |
| Package and deploy an embedded application | Task | Package as `.deb`, install through the administrative console or ZIoTC management API, start, stop, enable autostart, and uninstall |
| Embedded application API reference | Reference | Python and Node.js APIs, local-loopback permissions, event contracts, lifecycle commands, resource constraints, and compatibility |

## 9. Deploy Multiple Readers

The contracts describe one reader at a time. These pages repeat one reader's setup. They do not describe a fleet controller, tenant, or shared credential service.

| Page | Type | What this page owns |
|---|---|---|
| Multiple-Reader Architecture | Concept | Many readers, one broker, one application. Each reader still has its own connections |
| Reader Identity | Task | Hostname, serial number, and client ID on that reader. **Confirm** any identity the broker requires beyond the connection fields |
| MQTT Topic Design | Concept | How an application can tell readers apart using the topic fields on each connection. **Confirm** a required pattern before publishing one |
| Configuration Reuse | Tutorial | Repeat on the next reader: identity, region and time, the interface you used, the destination you used, the operating mode |
| Application Routing | Concept | How the application chooses a reader when events and responses arrive. Uses MQTT Topics. Does not add a routing API |
| Monitoring Multiple Readers | Concept | Heartbeats and status, once per reader. The heartbeat task stays in section 7 |
| Scaling Considerations | Concept | **Confirm** broker capacity, tag rate, and connection limits. Until then this page lists the questions, not numbers |
| Plan reconnect replay load | Concept | Size server capacity against reader count, live read rate, retained-event volume, and per-reader replay throttle |

## 10. Monitor and Maintain

| Page | Type | What this page owns |
|---|---|---|
| Reader Status | Task | `get_status` and `get_version` for model, serial number, and capabilities |
| ZIoTC Status | Task | Connection and mode state. Links to Verify ZIoTC Status and does not repeat it |
| Heartbeats | Task | Links to Heartbeats in section 7. This entry is only the operations path |
| Logs | Task | Which log matches Radio Control, Reader Gateway, or the system. Copy a log before deleting it. Only syslog and the radio packet log have delete commands |
| Firmware Updates | Task | Update from a URL, watch `firmwareUpdateProgress`, revert, and reboot. RFID resume after reboot is chosen on `start` |
| Backup and Restore | Task | **Confirm.** The contracts do not define export, backup, or factory reset. `set_importCloudConfig` updates included endpoint sections only. It is not a full backup |
| Certificates | Task | Links to Certificates in section 5. Renewal steps stay there |

Also in this section:

| Page | Type | What this page owns |
|---|---|---|
| Use the display and stack light | Task | Display is FXR60. Stack light is FXR60 Premium |
| Monitor an embedded user application | Task | Status, logs, start, stop, autostart, and failure recovery. Packaging and installation remain in Develop an Application |
| Send data to a user application | Task | MQTT `set_reqToUserapp` requires `userapp` in the body |

## 11. Troubleshooting

Each page names the symptom, the first command, and the task that owns the fix.

| Page | First check | Then |
|---|---|---|
| Reader Cannot Be Reached | `get_version` fails or the address does not answer | Verify Network Connectivity. Then Authentication or Certificates if the session is the failure |
| MQTT Connection Fails | Connection status | Generic MQTT Broker, then Verify Connectivity |
| Authentication Fails | Local login or broker username | Authentication |
| Certificate / TLS Failure | The connection names a certificate | Certificates |
| Reader Connected but No Tag Data | `get_status`, then the data connection | Data interface, the operating mode, Start and Stop Conditions, Tag Data Events |
| Commands Do Not Work | A command with no matching `command_id` | Control, Send Reader Commands, Match Commands and Responses |
| RFID Read Problems | Mode, antennas, and whether inventory is active | Operating Modes, Antennas, RF Settings, Tag Filters |
| Collect Diagnostic Information | `get_version`, `get_status`, then Logs | What to keep before asking for help. This is the only copy of that list |

BLE silence while RFID still works links to BLE and BLE Events from Reader Connected but No Tag Data. It does not need a second procedure page unless support asks for one.

## 12. Reference

One page per contract group. Each operation states the payload `command` value, the REST path when one exists, and a link to the guide page that uses it.

| Page | Covers |
|---|---|
| MQTT API | Commands accepted over MQTT |
| REST API | Local REST paths. Tag, BLE, and management events are not REST responses |
| Commands | Payload `command` strings, including where they differ from the operation id |
| MQTT Topics | The topic fields from section 7, in table form |
| Tag Event Schema | Tag data event shapes. SIMPLE, INVENTORY, PORTAL, CONVEYOR, CUSTOM |
| Management Event Schema | Heartbeat, GPI, GPO, userapp, error, warning, firmware progress, notification |
| BLE Event Schema | BLE data events |
| Error Codes | Response codes from the contracts |
| Limits | Only limits stated in the schemas. **Confirm** rates, sizes, and timeouts before adding numbers |
| Release Notes | **Confirm.** Not in the API contracts. Publish from the firmware release, not from this guide |
| Migration Guides | [FxConnect](https://zebradevs.github.io/rfid-ziotc-docs/migration/FxConnect/index.html), [123RFID Desktop](https://zebradevs.github.io/rfid-ziotc-docs/migration/123RFID_Desktop/index.html), and [RFID API-3](https://zebradevs.github.io/rfid-ziotc-docs/migration/RFIDAPI3/index.html). Keep these off the first-use path |
| FAQ | [Published FAQ](https://zebradevs.github.io/rfid-ziotc-docs/faqs/index.html). Add an FXR answer only when the contract or engineering confirms it |
| Appendix and resources | [Appendix](https://zebradevs.github.io/rfid-ziotc-docs/appendix/index.html) and [Resources](https://zebradevs.github.io/rfid-ziotc-docs/resources/index.html) |

`reboot` stays under Commands, in the System group, and is used by Firmware Updates.

## Navigation tree

```text
Zebra IoT Connector
├── 1. Overview
│   ├── What is Zebra IoT Connector?
│   ├── How ZIoTC Works
│   ├── ZIoTC Architecture
│   ├── Interfaces
│   │   ├── Management
│   │   ├── Control
│   │   ├── Data
│   │   └── Management Events
│   ├── Reader software components
│   ├── Deployment Models
│   └── Supported Readers and Versions
├── 2. Quickstart: First Tag to MQTT in 15 Minutes
│   ├── Prerequisites
│   ├── Connect the Reader
│   ├── Open ZIoTC Configuration
│   ├── Configure an MQTT Endpoint
│   ├── Assign the Data Interface
│   ├── Verify the Connection
│   ├── Configure SIMPLE Mode
│   ├── Start Reading
│   ├── Receive the First Tag Event
│   └── Verify the Setup
├── 3. Prepare the Reader and Network
│   ├── Install and Connect the Reader
│   ├── Discover the Reader
│   ├── Configure Ethernet
│   ├── Configure Wi-Fi
│   ├── Configure IP Settings
│   ├── Configure Time
│   ├── Configure 802.1X
│   ├── Verify Network Connectivity
│   ├── Configure cellular
│   ├── Use the reader as an access point
│   └── Connect over a Bluetooth network
├── 4. Configure Zebra IoT Connector
│   ├── Understand Endpoints
│   ├── Understand Interfaces
│   ├── Use the ZIoTC Web Interface
│   ├── Add an Endpoint
│   ├── Assign Interfaces to Endpoints
│   ├── Start ZIoTC
│   ├── Verify ZIoTC Status
│   └── Modify or Remove Configuration
├── 5. Connect a Destination
│   ├── Generic MQTT Broker
│   ├── HTTP / HTTPS
│   ├── AWS IoT
│   ├── Azure IoT
│   ├── Google Cloud IoT
│   ├── WebSocket, TCP server, or keyboard
│   ├── Configure an HTTP file server
│   ├── Configure tag-data batching
│   ├── Configure tag-data retention and replay
│   ├── Authentication
│   ├── Certificates
│   ├── Configure mutual TLS for MQTT
│   └── Verify Connectivity
├── 6. Configure RFID Operations
│   ├── Operating Modes
│   │   ├── SIMPLE
│   │   ├── INVENTORY
│   │   ├── PORTAL
│   │   ├── CONVEYOR
│   │   └── CUSTOM
│   ├── Antennas
│   ├── RF Settings
│   ├── Tag Filters
│   ├── Start and Stop Conditions
│   ├── Gen2X
│   ├── GPIO
│   └── BLE
├── 7. Receive Data and Events
│   ├── Understand ZIoTC Messages
│   ├── Tag Data Events
│   ├── BLE Events
│   ├── Management Events
│   ├── Heartbeats
│   ├── Commands and Responses
│   ├── MQTT Topics
│   ├── Payload Examples
│   └── Identify and remove replay duplicates
├── 8. Develop an Application
│   ├── Choose REST or MQTT
│   ├── Subscribe to Tag Data
│   ├── Send Reader Commands
│   ├── Match Commands and Responses
│   ├── Handle Errors
│   ├── Reconnect
│   ├── Sample Applications
│   ├── Choose an external or embedded application
│   ├── Build a Python Data Analytics application
│   ├── Build a Node.js Data Analytics application
│   ├── Package and deploy an embedded application
│   └── Embedded application API reference
├── 9. Deploy Multiple Readers
│   ├── Multiple-Reader Architecture
│   ├── Reader Identity
│   ├── MQTT Topic Design
│   ├── Configuration Reuse
│   ├── Application Routing
│   ├── Monitoring Multiple Readers
│   ├── Scaling Considerations
│   └── Plan reconnect replay load
├── 10. Monitor and Maintain
│   ├── Reader Status
│   ├── ZIoTC Status
│   ├── Heartbeats
│   ├── Logs
│   ├── Firmware Updates
│   ├── Backup and Restore
│   ├── Certificates
│   ├── Use the display and stack light
│   ├── Monitor an embedded user application
│   └── Send data to a user application
├── 11. Troubleshooting
│   ├── Reader Cannot Be Reached
│   ├── MQTT Connection Fails
│   ├── Authentication Fails
│   ├── Certificate / TLS Failure
│   ├── Reader Connected but No Tag Data
│   ├── Commands Do Not Work
│   ├── RFID Read Problems
│   └── Collect Diagnostic Information
└── 12. Reference
    ├── MQTT API
    ├── REST API
    ├── Commands
    ├── MQTT Topics
    ├── Tag Event Schema
    ├── Management Event Schema
    ├── BLE Event Schema
    ├── Error Codes
    ├── Limits
    ├── Release Notes
    ├── Migration Guides
    ├── FAQ
    └── Appendix and resources
```

## Confirm before writing as fact

- Power wiring, panel LEDs, a default IP address, and how discovery works.
- A command that starts or stops ZIoTC as a service.
- Required MQTT topic layout, last will, retained messages, duplicate delivery, and command timeouts.
- Whether `set_region` must succeed before `set_mode` accepts transmit power.
- Backup, restore, and factory reset.
- Fleet controller, tenants, and shared credentials.
- Broker capacity, tag rates, and connection limits.
- Lifetime of the local REST bearer token.
- Firewall rules and required outbound ports.
- Whether the legacy guide's MQTT 3.1.1 requirement, PFX-only certificate rule,
  certificate types, web-console paths, and service-start workflow apply to each
  FXR60 and FXR90 firmware release.
- Whether FXR retention is lost on reboot and exactly when reconnect replay can
  duplicate or discard events.
- Whether Directionality or Portal Directionality is supported on an FXR model;
  it is absent from the current FXR mode contracts.
