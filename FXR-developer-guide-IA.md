# FXR60 / FXR90 IoT Connector developer guide information architecture

## Executive recommendation

Build two connected documentation products:

1. **Developer Guide** — concepts, tasks, tutorials, operational guidance, and symptom-based troubleshooting organized around developer outcomes.
2. **API Reference** — exact MQTT commands, REST operations, request and response fields, response codes, schemas, enums, constraints, and examples generated or maintained from the contracts.

The Developer Guide should recommend a primary path: use local REST to inspect or bootstrap a reader when direct network access is available, configure MQTT destinations, subscribe before starting operations, configure the complete RFID mode or BLE settings, start the required scan types, consume the corresponding event streams, and monitor the reader through status and management events.

Do not repeat full schemas in the Developer Guide. Each task page should explain purpose, ordering, dependencies, confirmation, and recovery, then link to the applicable API-reference operations.

---

## 1. API analysis

### Supported readers and important boundaries

| Area | Contract-supported behavior |
|---|---|
| Readers | FXR60 and FXR90 fixed RFID readers. |
| Shared surface | Control, system, region, networking, certificates, logging, date/time, firmware, GPIO, application LED, user applications, BLE, RFID modes, Gen2X, tag events, and management events. |
| FXR60 | Some FXR60 configurations expose integrated antenna IDs `5` and `6`; confirm them as internal with `get_readerCapabilities`. Display operations apply to FXR60. |
| FXR60 Premium | Stack-light operations apply only when the capability is present; the contract describes the stack light as FXR60 Premium functionality. |
| FXR90 | Cellular interface `wan0`, eSIM management, and GPS coordinates are FXR90 functionality. Ethernet, Wi-Fi, Bluetooth networking, and access-point configuration are not FXR90-only. |
| BLE firmware dependency | Starting BLE through `scanType` and receiving BLE Data Events require reader build 4.0.11 or later. |
| Local REST | Local REST is always enabled and is not configured through `set_importCloudConfig`. Login uses Basic authentication; later operations use a bearer token. |
| Event transport | Tag Data Events, BLE Data Events, heartbeats, GPIO events, warnings, errors, firmware progress, notifications, and user-application events are defined by the MQTT contract, not as REST response streams. |

### Capability map

| Capability | What the contracts support | Key dependencies and relationships |
|---|---|---|
| Identity and capabilities | Model, serial number, component versions, upgrades, revert information, antenna inventory, GPIO capacity, endpoint types, API versions, Gen2X features, stack-light capability. | Read identity and capabilities before applying model-specific configuration. |
| Current status | Uptime, time, radio state, temperature, resource use, storage, antennas, NTP, interface state, power, Gen2X activity, and BLE activity. | Status is an on-demand snapshot; heartbeats are configured asynchronous telemetry. |
| Local REST access | Basic-authenticated login returns a bearer token; subsequent endpoints require bearer authentication. | Token lifetime and refresh behavior are not defined. |
| MQTT command flow | Commands contain `command`, `command_id`, and `payload`; responses echo `command_id`. | Subscribe to the response topic before publishing. Response timing, ordering, timeout, and retry rules are not defined. |
| Endpoint configuration | Separate data-event, control command-response, management-event, and management command-response planes. Multiple connection types and named connections are supported. | `set_importCloudConfig` updates included endpoint sections and leaves omitted sections unchanged. Local REST is outside this configuration. |
| Data-plane configuration | Data connections, batching, retention, GPIO/LED behavior, and management-event configuration are represented under reader configuration. | `set_config` configures data-plane and management-event behavior; it does not replace `set_importCloudConfig` for control and management endpoint planes. |
| RFID operating mode | `SIMPLE`, `INVENTORY`, `PORTAL`, `CONVEYOR`, and `CUSTOM`. The mode contains antennas, power, environment, filters, query/select, access operations, metadata, and start/stop behavior. | `set_mode` replaces the complete mode. Stop active inventory before changing it. |
| RFID runtime control | Start or stop RFID globally or for named data connections. RFID is the default when `scanType` is omitted. | The configured mode must already exist. RFID can be configured to resume after reboot. |
| Tag Data Events | Mode-specific tag reports on configured data-event connections. | Requires a data destination, a configured mode, an active RFID inventory, and an application subscription. |
| Tag selection and reporting | Prefix filtering, Gen2 query/select, report filtering, RSSI filtering, metadata selection, and antenna names. | Several options are mutually exclusive; fields published depend on mode and configuration. |
| Tag memory operations | Read, write, access, lock, and kill operations with results under `accessResults`. | Not supported in every mode; conflicts exist with report filters and memory-bank metadata. |
| Impinj Gen2X | FastID, TagFocus, TagProtect, and basic or advanced TagQuieting. | One feature is saved at a time. Saving does not activate it; `start` must set `applyImpinjGen2X: true` for each inventory session. |
| BLE | iBeacon, AltBeacon, Eddystone, and generic BLE configuration, protocol filters, RSSI filters, service UUID filters, runtime start/stop, and BLE Data Events. | Configure and enable BLE first. Explicitly include `ble` in `scanType`. BLE does not autostart or resume after reboot. |
| RFID and BLE routing | Global `scanType` and a named-connection form that maps data connections to `rfid`, `ble`, or both. | Connection names must match `endpointConfig.data.event.connections`. |
| Management Events | Heartbeat, GPI, GPO, user-app, error, warning, firmware progress, and notification events. | Configure the management-event destination first. Configure selectable events and heartbeat fields with `set_config`; firmware progress and display notifications are automatic. |
| Monitoring | On-demand status plus heartbeat sections for Radio Control, Reader Gateway, system, and user applications. | Monitoring design should combine reachability, status, heartbeat, event, and delivery counters. |
| Network | Ethernet, Wi-Fi, Bluetooth network interface, access point, available Wi-Fi networks, interface discovery, read points, FXR90 cellular/eSIM, and FXR90 GPS. | `set_network` updates one interface per request. `uap0` and `mlan0` cannot both be enabled. A successful change can break the current management path. |
| Region and time | Supported regions and standards, active region, timezone, and NTP servers. | Configure regulatory settings before production RFID use. Correct time supports logs, certificates, and event timestamps. |
| Certificates and TLS | Install, list, refresh, and delete device certificates; install, list, and delete CA certificates; reference trust material from endpoints and downloads. | Install trust material before enabling verification on an endpoint or protected download. Server certificates cannot be deleted through the documented certificate delete operation. |
| GPIO and indicators | Read GPI/GPO state, set a GPO, configure GPIO/LED defaults and actions, control the application LED, and publish GPIO events. | PORTAL mode depends on a GPI trigger. Physical electrical characteristics are not in the contracts. |
| Display and stack light | FXR60 display configuration, attached-device inspection, automatic display notifications, and FXR60 Premium stack-light control. | Check model and capabilities first. |
| Logging | Configure component levels and radio packet capture; download system, Radio Control, Reader Gateway warning/error, and radio-packet archives; clear supported archives. | Preserve evidence before deleting logs. |
| Firmware | Update OS from a supported URL, receive automatic progress events, inspect installed/available versions, reboot, and revert to the previous OS. | Configure and subscribe to management events before starting the update if progress is required. |
| User applications | Install, list, start, stop, autostart, exchange requests/data, monitor through heartbeat and events, and uninstall. | Application packaging, signing, permissions, and resource limits are not defined by the contracts. |
| Pass-through | Send limited pass-through commands to a reader component and exchange requests/data with user applications. | This is an advanced integration surface and should not be introduced in the primary getting-started path. |

### Required ordering and dependency rules

1. **Local REST:** `GET /cloud/localRestLogin` with Basic authentication → save the returned bearer token → call other REST operations with bearer authentication.
2. **Secure endpoint:** install device/CA certificate → configure endpoint security and certificate references → enable peer/host verification → confirm the connection.
3. **First RFID stream:** configure data destination → subscribe to data and response topics → set the complete mode → start RFID → consume Tag Data Events → stop RFID.
4. **BLE stream:** configure a data destination → `set_bleConfig` with BLE enabled → subscribe → `start` with `ble` in `scanType` → consume BLE Data Events → stop BLE.
5. **Management events:** configure `endpointConfig.management.event` → configure heartbeat and selectable events with `set_config` → subscribe → confirm heartbeat/events.
6. **Gen2X:** stop RFID if active → `set_impinjGen2X` → `get_impinjGen2X` → `start` with `applyImpinjGen2X: true` → confirm `get_status` reports the feature active.
7. **Mode change:** read current/effective mode → stop active inventory → build the complete replacement → `set_mode` → `get_mode` to verify → restart inventory.
8. **Firmware:** configure and subscribe to management events → read current version → `set_os` → follow `firmwareUpdateProgress` → reconnect → `get_version` → revert only if required and supported.
9. **Network change:** read the current interfaces/configuration → change one interface → reconnect over the new path → confirm identity and status.
10. **PORTAL workflow:** verify GPI capacity and state → configure PORTAL trigger and stop interval in the complete mode → start RFID → generate the GPI transition → receive portal tag events.

### Cross-field and lifecycle rules that require explanation

- `set_mode` is wholesale replacement; omitted mode fields are not merged.
- `get_mode` without `verbose: true` returns configured values only; verbose mode returns effective values including defaults.
- `SIMPLE` does not accept `tagMetaData` and has a fixed basic report shape.
- `INVENTORY` does not allow `accesses`.
- `PORTAL` does not allow `radioStartConditions` or `radioStopConditions`; it uses its portal trigger settings.
- A prefix `filter` cannot be combined with `query` or `selects`.
- `reportFilter` and `accesses` cannot be configured together.
- `accesses` conflicts with memory-bank metadata selections for `RESERVED`, `EPC`, `TID`, and `USER`.
- Some per-antenna arrays must have the same length as `antennas`.
- `GPIO-LED` is replaced as a complete object.
- `set_importCloudConfig` updates only the endpoint sections included in the request.
- BLE must be enabled before it can be started, and BLE never resumes automatically after reboot.
- A saved Gen2X configuration is inactive until explicitly applied by `start` and must be applied again after `stop`.
- Stopping a scan type that is not active returns a refusal rather than acting as a no-op.
- `uap0` and `mlan0` cannot both be enabled.

---

## 2. User journey and documentation types

### Recommended user journey

1. Understand the product and supported readers.
2. Understand Reader Gateway, Radio Control, the application, the broker, and local REST.
3. Choose MQTT, local REST, or a combination.
4. Reach and identify the reader.
5. Configure network, time, region, and trust.
6. Understand MQTT connections, topics, commands, responses, and event streams.
7. Configure command and event destinations.
8. Configure the RFID operating mode, antennas, filtering, and reporting.
9. Start RFID and receive Tag Data Events.
10. Configure and start BLE when required.
11. Configure heartbeats and management events.
12. Build resilient event consumers.
13. Operate and monitor one reader.
14. Provision and monitor a fleet.
15. Diagnose from a visible symptom.
16. Use the API Reference for exact payload and response details.

### Content-type boundaries

| Type | Purpose | Rule for this guide |
|---|---|---|
| Concept | Explain the system model and rules that later tasks depend on. | No complete request/response schema dumps. Include only the fields needed to explain behavior. |
| Task | Complete one customer goal. | Use prerequisites → inspect current state → change → verify → recover. Link to exact API operations. |
| Tutorial / workflow | Complete a realistic end-to-end scenario. | Recommend one path and reuse task pages through links rather than duplicating all explanation. |
| Reference | Provide authoritative syntax and field-level detail. | Organize by actual API groups and keep exact schemas, enums, response codes, and examples here. |

---

## 3. Section-level information architecture

### A. Introduction

- **Purpose:** Establish product scope, reader differences, and the fastest route to the correct guide.
- **Target question:** “What is the IoT Connector, which reader do I have, and where do I start?”
- **Child topics:** About the IoT Connector; FXR60 and FXR90 differences; choose MQTT or REST; prerequisites; documentation map.
- **Content types:** Concept.
- **Related API:** `get_version`, `get_readerCapabilities`.
- **Prerequisites:** None.
- **Cross-links:** Architecture; Getting Started; API Reference overview.

### B. System architecture

- **Purpose:** Explain how the reader, Radio Control, Reader Gateway, broker, REST client, and event consumers relate.
- **Target question:** “Which component owns configuration, controls the radio, and publishes each message?”
- **Child topics:** System architecture; Reader Gateway and Radio Control; configuration ownership; runtime lifecycle; command and event flows.
- **Content types:** Concept.
- **Related API:** `get_status`, `set_passthru`, heartbeat sections, `set_config`, `set_importCloudConfig`.
- **Prerequisites:** Introduction.
- **Cross-links:** MQTT Communication; Configure Destinations; Monitor Reader Health.
- **Information required:** The contracts expose component names and telemetry but do not fully define internal component boundaries or startup sequencing.

### C. Getting started

- **Purpose:** Deliver an early success with the minimum supported configuration.
- **Target question:** “How do I prove that the reader and my application work together?”
- **Child topics:** First RFID tag over MQTT; check and control a reader over REST; verify identity and status.
- **Content types:** Tutorial.
- **Related API:** `get_version`, `get_status`, `set_mode`, `start`, `stop`, Tag Data Events, `/cloud/localRestLogin`.
- **Prerequisites:** Reachable reader; existing MQTT command/data connections for the MQTT tutorial.
- **Cross-links:** Configure Destinations when MQTT is not already configured; RFID Operations; Receive Tag Data.
- **Information required:** Default reader address, first-login credentials, and factory MQTT/bootstrap state.

### D. MQTT communication

- **Purpose:** Teach the communication model independently of any single command.
- **Target question:** “How do I connect, publish a command, match its response, and receive events?”
- **Child topics:** Broker connection model; configurable topics; command envelope; `command_id`; response handling; event families; QoS, sessions, keep-alive, reconnect, retention, and replay.
- **Content types:** Concept and task.
- **Related API:** All MQTT commands; `set_importCloudConfig`; `get_config`; Reader Gateway heartbeat fields.
- **Prerequisites:** Architecture.
- **Cross-links:** Configure Destinations; Build an Application; Troubleshoot MQTT.
- **Information required:** Command timeout guidance, response ordering, duplicate delivery behavior, idempotency, retry rules, and any default topic convention.

### E. Connect and secure the reader

- **Purpose:** Establish network reachability, regulatory settings, time, identity, credentials, and trust.
- **Target question:** “How do I prepare a reader for a secure deployment?”
- **Child topics:** Identify reader; region and standards; time and NTP; hostname/password; Ethernet/Wi-Fi/access point; FXR90 cellular/eSIM/GPS; certificates and TLS.
- **Content types:** Task.
- **Related API:** version, capability, region, date/time, hostname/password, network, certificate, and CA-certificate operations.
- **Prerequisites:** Physical installation and local access.
- **Cross-links:** Configure Destinations; Fleet Provisioning; Network Troubleshooting.
- **Information required:** Physical onboarding, default network identity, GPIO/network hardware installation, and corporate PKI policy.

### F. Configure command and event destinations

- **Purpose:** Explain and configure the four endpoint planes without exposing readers to the raw schema first.
- **Target question:** “Where will commands arrive, responses return, and RFID, BLE, and management events be published?”
- **Child topics:** Endpoint planes; connection types; MQTT broker destination; secure endpoints; RFID/BLE routing; batching; offline retention; validation and rollback.
- **Content types:** Concept, task, and tutorial.
- **Related API:** `get_config`, `set_config`, `set_importCloudConfig`, `start`, Reader Gateway heartbeat.
- **Prerequisites:** Network and certificates.
- **Cross-links:** MQTT Communication; Receive Tag Data; BLE; Management Events.
- **Information required:** Recommended endpoint topology, maximum practical connection counts, broker ACL examples, and cloud-provider onboarding outside the schema.

### G. Configure and run RFID

- **Purpose:** Take the reader from an idle radio to a verified RFID workflow.
- **Target question:** “Which mode should I use, how do I configure it, and how do I start reading?”
- **Child topics:** Choose a mode; antennas and power; environment and cable loss; mode configuration; trigger/stop behavior; start/stop; selection and filtering; metadata; tag memory; Gen2X; portal/conveyor/custom workflows.
- **Content types:** Concept, task, and tutorial.
- **Related API:** Control, preselection, cable-loss, capability, status, GPIO, and Gen2X commands.
- **Prerequisites:** Region configured; data destination ready; antennas connected.
- **Cross-links:** Receive Tag Data; RFID Performance Troubleshooting; API Reference — Control and Gen2X.

### H. Receive and process RFID tag data

- **Purpose:** Help developers build a consumer that understands every supported mode shape.
- **Target question:** “What will be published, why do fields vary, and how should my application process it?”
- **Child topics:** Tag-event envelope; per-mode default fields; optional metadata; `accessResults`; antenna association; event numbering; batching; validating the configured mode against the received type.
- **Content types:** Concept and task.
- **Related API:** Tag Data Events; `get_mode`; `set_mode`; `start`; data endpoint configuration.
- **Prerequisites:** Active RFID inventory and subscription to the configured data connection.
- **Cross-links:** Operating Modes; Filter and Shape Reports; Build an Application.

### I. Configure and run BLE

- **Purpose:** Cover BLE as a separate scan lifecycle and data shape rather than an RFID variation.
- **Target question:** “How do I configure BLE, route its data, start it, and parse beacon events?”
- **Child topics:** Firmware requirement; BLE configuration; protocol and additional filters; BLE-only and combined operation; named destination routing; BLE Data Event envelope and beacon formats.
- **Content types:** Concept, task, and tutorial.
- **Related API:** `get_bleConfig`, `set_bleConfig`, `start`, `stop`, BLE Data Events, `get_status`.
- **Prerequisites:** Build 4.0.11 or later; data destination; BLE enabled.
- **Cross-links:** Configure Destinations; RFID + BLE workflow; BLE Troubleshooting.

### J. Reader I/O and on-reader applications

- **Purpose:** Explain external triggers, outputs, reader indicators, FXR60 peripherals, and custom applications.
- **Target question:** “How do I connect the reader to physical automation or run software on the reader?”
- **Child topics:** GPI/GPO; GPIO/LED actions; application LED; FXR60 display; FXR60 Premium stack light; user-application lifecycle; application events and heartbeat.
- **Content types:** Task and concept.
- **Related API:** GPIO, LED, Display, Stack LED, user-application commands, GPIO and user-app events.
- **Prerequisites:** Capability discovery; physical wiring or app package.
- **Cross-links:** PORTAL Workflow; Management Events; Troubleshooting I/O and Applications.
- **Information required:** GPIO electrical/wiring specifications and user-application packaging, signing, permissions, and resource constraints.

### K. Manage, monitor, and maintain readers

- **Purpose:** Support production operations after configuration is complete.
- **Target question:** “How do I know that a reader is healthy and keep it operating?”
- **Child topics:** Status and heartbeat; configure management events; connectivity and delivery metrics; error/warning response; logs; firmware update/revert; staged fleet operations.
- **Content types:** Concept, task, and tutorial.
- **Related API:** status, configuration, events, logs, firmware, version, reboot, and user-app operations.
- **Prerequisites:** Management-event destination and subscription.
- **Cross-links:** Troubleshooting; Fleet Workflows; API Reference — Events and Logs.

### L. Build a production application

- **Purpose:** Translate the protocol into robust client behavior without prescribing an unsupported SDK.
- **Target question:** “How should my application authenticate, correlate requests, consume streams, recover, and control throughput?”
- **Child topics:** Plan transport; REST client; MQTT client; pending-command correlation; RFID consumer; BLE/management consumer; reconnect recovery; throughput; validation and testing.
- **Content types:** Task and tutorial.
- **Related API:** All command envelopes, event envelopes, endpoint configuration, status, and Reader Gateway counters.
- **Prerequisites:** MQTT Communication; event data concepts.
- **Cross-links:** API Reference; Troubleshooting; Common Workflows.
- **Information required:** Supported client libraries, official sample language, recommended timeouts/retries, and delivery guarantees beyond configured QoS/retention.

### M. Common workflows

- **Purpose:** Provide opinionated end-to-end scenarios that cross configuration domains.
- **Target question:** “How do I deploy a complete use case without assembling the sequence myself?”
- **Child topics:** Initial setup; first tag; secure MQTT; inventory, portal, conveyor, and custom deployments; RFID+BLE routing; heartbeat monitoring; user applications; firmware rollout.
- **Content types:** Tutorial.
- **Related API:** Varies by workflow; identified in section 4.
- **Prerequisites:** Each workflow states its required reader state and infrastructure.
- **Cross-links:** Reuse concept and task pages; do not duplicate reference schemas.

### N. Troubleshoot and recover

- **Purpose:** Route developers from a visible symptom to the correct layer, evidence, and recovery action.
- **Target question:** “What failed, what should I inspect first, and how can I recover safely?”
- **Child topics:** Reader/REST unreachable; MQTT failure; missing/poor RFID reads; BLE failure; GPIO/display failure; user-app failure; firmware failure; evidence collection; fleet incident.
- **Content types:** Troubleshooting task and recovery tutorial.
- **Related API:** identity, status, configuration, mode, network, logs, heartbeat/events, version, reboot, and revert.
- **Prerequisites:** Access through at least one management path, when possible.
- **Cross-links:** Monitoring; applicable configuration task; Escalate to Support.

### O. API Reference

- **Purpose:** Preserve exact contract detail separately from learning and workflow content.
- **Target question:** “What exact command, endpoint, field, response, enum, or schema do I use?”
- **Child topics:** Reference groups listed in section 6.
- **Content types:** Reference.
- **Related API:** Entire MQTT and REST contracts.
- **Prerequisites:** None, although guide pages should deep-link to individual operations.
- **Cross-links:** Every task page links to the commands it uses; every reference operation links back to relevant concepts and tasks.

---

## 4. Critical workflows

| Workflow | Goal and prerequisites | Supported sequence |
|---|---|---|
| Initial reader setup | Prepare a reachable reader. Requires physical/network access. | REST login → `get_version` → `get_readerCapabilities` → `get_supportedRegionList` → `get_supportedStandardList` → `set_region` → `set_timeZone` / `set_ntpServer` → `set_hostname` → `get_status`. **Information required:** default address and first-login procedure. |
| Configure an MQTT broker | Establish command and event connections. Requires network and any needed certificates. | Install certificates/CA if required → `set_importCloudConfig` for control/management planes and destinations → `set_config` for data-plane/event behavior where applicable → `get_config` → inspect connection state through status/heartbeat. |
| First RFID tag read | Prove the end-to-end RFID path. Requires data and response topics. | Subscribe to response and data topics → `get_version` → `set_mode` with complete SIMPLE mode → `start` → receive `SIMPLE` Tag Data Event → `stop`. |
| SIMPLE mode | Read unique tags with the basic fixed event shape. | `get_mode` → `stop` if active → `set_mode` type SIMPLE → `get_mode` → `start` → receive SIMPLE events → `stop`. |
| INVENTORY mode | Receive periodic per-antenna reports with RSSI/read count. | `get_mode` → `stop` → `set_mode` type INVENTORY with interval and antennas → `get_mode` → `start` → receive INVENTORY events → `stop`. Do not configure `accesses`. |
| PORTAL mode | Run a GPI-triggered portal cycle. Requires a wired/working GPI. | `get_readerCapabilities` → `get_gpi_status` → `set_mode` type PORTAL with GPI trigger/stop interval → `start` → cause GPI transition → receive PORTAL events → `stop`. |
| CONVEYOR mode | Run a conveyor read workflow. | `get_readerCapabilities` → `set_mode` type CONVEYOR with antennas/power/conditions → `start` → receive CONVEYOR events → validate antenna assignment → `stop`. |
| CUSTOM mode | Use advanced RF, metadata, access, and timing controls. | `get_mode` verbose → `stop` → construct a valid complete CUSTOM mode → `set_mode` → `get_mode` verbose → `start` → validate CUSTOM event shape → `stop`. |
| RFID selection and filtering | Limit which tags enter inventory and which reads are reported. | `get_mode` → choose prefix filter or query/select → configure report/RSSI filter within compatibility rules → `set_mode` complete replacement → `get_mode` → `start` → validate events. |
| Select tag metadata | Add supported optional fields to Tag Data Events. | Choose a compatible mode → choose metadata fields → ensure no conflict with accesses/report filter → `set_mode` → `start` → verify the corresponding event fields. |
| Enable RF preselection | Improve selectivity in a noisy environment. | `get_preSelection` → decide based on deployment RF conditions → `set_preSelection` → `get_preSelection` → compare read performance. |
| Use Impinj Gen2X | Apply one supported proprietary tag feature. | `get_readerCapabilities` → `stop` → `set_impinjGen2X` → `get_impinjGen2X` → `start` with `applyImpinjGen2X: true` → `get_status` → consume affected tag events. |
| BLE scanning | Receive supported BLE advertisements. Requires build 4.0.11+. | `get_version` → configure data destination → `set_bleConfig` → `get_bleConfig` → subscribe → `start` with `scanType: ["ble"]` → receive BLE Data Events → `stop` BLE. |
| Combined RFID and BLE | Run both scan types. Requires RFID mode and BLE configuration. | Configure mode → configure BLE → configure/subscribe to data connections → `start` with `scanType: ["rfid", "ble"]` → consume both event types → stop the intended scan type(s). |
| Route RFID and BLE separately | Deliver scan types to named destinations. Requires multiple named data connections. | `set_importCloudConfig` or `set_config` to define data connections → subscribe consumers → `start` with object-form `scanType` mapping connection names to `rfid`/`ble` → verify each destination. |
| Configure Management Events | Publish operational events. | `set_importCloudConfig` for `endpointConfig.management.event` → `set_config` for `managementEventConfig` → subscribe → trigger or wait for events → confirm event envelope. |
| Configure heartbeat monitoring | Receive selected health data periodically. | Configure management-event destination → `set_config` heartbeat interval and field groups → subscribe → receive `heartbeat` → correlate Radio Control, Reader Gateway, system, and user-app sections. |
| Monitor errors and warnings | Receive and respond to configured conditions. | Configure management-event destination → `set_config` error/warning selectors and thresholds → subscribe → receive event → compare with heartbeat/status → collect relevant logs. |
| Operate GPIO | Integrate inputs, outputs, and automated indicators. | `get_readerCapabilities` → `get_gpi_status` / `get_gpostatus` → `set_gpo` or `set_config` GPIO-LED actions → configure GPI/GPO events → verify physical result and event. |
| Manage a user application | Install and operate software on the reader. | `install_user_app` → `get_user_apps` → `start_user_app` → optional `autostart_user_app` → exchange data/requests → monitor heartbeat/events → `stop_user_app` → `uninstall-user-app`. |
| Update firmware | Update and verify reader software. Requires reachable update source and management-event destination for progress. | `get_version` → subscribe to management events → `set_os` → follow `firmwareUpdateProgress` → reconnect → `get_version` → `revertback` only when required and available. |

---

## 5. Conceptual topics that need dedicated guide pages

| Topic | Why it deserves a page | Contract basis and information gaps |
|---|---|---|
| FXR system architecture | Developers must know which component controls RF, which component handles cloud communication, and where configuration lives before troubleshooting. | Heartbeats identify Radio Control, Reader Gateway, system, and user apps. **Information required:** authoritative internal component boundaries and startup dependencies. |
| Reader Gateway versus Radio Control | The two components expose different health signals and failure modes. | Separate heartbeat sections and logs exist. **Information required:** exact ownership of command parsing, queues, RF control, and event construction. |
| MQTT communication architecture | The application must understand configurable topics, bidirectional commands, and independent publications before using any command. | Command/response envelopes and endpoint schemas exist. **Information required:** defaults, timeout, ordering, duplicate, idempotency, and retry behavior. |
| Endpoint planes and configuration ownership | `set_config` and `set_importCloudConfig` affect different portions of the system; confusing them causes partial or missing connectivity. | The contracts explicitly describe data, control, management, and management-event paths and partial-update behavior. |
| RFID inventory lifecycle | Mode configuration, start state, event production, stop behavior, and reboot persistence are separate. | `set_mode`, `start`, `stop`, `get_status`, and Tag Data Events define the lifecycle. |
| Choosing an operating mode | Developers need scenario guidance rather than enum definitions. | The contracts define five modes and their output behavior. **Information required:** deployment recommendations and performance tradeoffs beyond the defined defaults. |
| Antenna and RF behavior | Antenna selection, per-antenna arrays, integrated ports, power, environment, cable loss, and stop conditions interact. | Schemas and cross-field rules exist. **Information required:** physical placement and tuning methodology. |
| Tag selection versus report filtering | Selection controls which tags participate; reporting controls what becomes an event. Mixing them incorrectly leads to unexpected results or rejected mode bodies. | Filter, query/select, reportFilter, rssiFilter, metadata, and access conflicts are defined. |
| Tag Data Event model | Event fields vary by mode and selected metadata; consumers cannot assume one universal record. | Common envelope, per-mode shapes, metadata mappings, and access results are defined. |
| RFID versus BLE routing | RFID and BLE share data-connection infrastructure but have independent configuration, start behavior, event shapes, and reboot behavior. | `scanType`, named data connections, BLE configuration, and both event families are defined. |
| Management Event model | Heartbeats, conditions, automatic progress, and notifications have different configuration rules but share an envelope. | Management event schemas and `managementEventConfig` are defined. |
| Reader monitoring architecture | Operators need to combine synchronous status, heartbeat telemetry, condition events, delivery counters, and logs. | All signals exist, but no single command provides the complete operational view. |
| Security and certificate lifecycle | REST authentication, broker TLS, download trust, device certificates, and CA certificates are related but distinct. | Security schemas and certificate commands exist. **Information required:** token lifetime and organization-specific certificate policy. |
| Model and firmware feature discovery | Applications should branch on observed capabilities rather than assumptions about the product name. | Version and capability commands expose relevant facts. **Information required:** full firmware-to-feature compatibility matrix. |

### Information required before these pages can be authoritative

1. Default IP/hostname, first-login credentials, and supported first-time onboarding procedure.
2. How an unconfigured reader receives its first MQTT command connection, including any factory topics or broker settings.
3. Default MQTT topics, if any, and recommended topic naming/ACL conventions.
4. REST bearer-token lifetime, expiry behavior, and whether refresh exists.
5. MQTT command response timing, ordering, duplicate delivery, idempotency, and safe retry guidance.
6. Maximum recommended endpoint connections and supported production topology by connection type.
7. Antenna installation, placement, polarization, physical port mapping, and RF tuning guidance.
8. GPIO electrical limits, wiring diagrams, debounce behavior, and safe external-device integration.
9. Exact FXR60 variants that include the display, integrated antennas, and stack light.
10. User-application package format, signing, permissions, sandboxing, resource limits, and upgrade compatibility.
11. Firmware prerequisites, downgrade compatibility, expected downtime, and recovery procedure when the reader does not return.
12. Official support bundle requirements, retention duration of logs/events, and escalation channel.

---

## 6. Separate API Reference structure

MQTT reference pages should use the exact command names below. Where REST provides the same action, show the corresponding method and `/cloud/...` path on the same reference page or in a clearly paired REST tab. Keep `/cloud/localRestLogin` as a REST-only authentication operation.

### Authentication

- REST only: `GET /cloud/localRestLogin`

### Control commands

- `get_mode`
- `set_mode`
- `start`
- `stop`
- `get_preSelection`
- `set_preSelection`

### Impinj Gen2X

- `get_impinjGen2X`
- `set_impinjGen2X`

### System

- `get_version`
- `get_status`
- `get_config`
- `set_config`
- `set_passthru`
- `set_importCloudConfig`
- `get_readerCapabilities`
- `get_cableLossCompensation`
- `set_cableLossCompensation`
- `reboot`
- `set_password`
- `get_hostname`
- `set_hostname`

### Application LED

- `get_appled`
- `set_appled`

### Stack light

- `get_stackled`
- `set_stackled`

### Display and attached I/O

- `get_displayConfig`
- `set_displayConfig`
- `get_inputOutputDevices`

### GPIO

- `get_gpostatus`
- `set_gpo`
- `get_gpi_status`

### Region

- `get_region`
- `set_region`
- `get_supportedRegionList`
- `get_supportedStandardList`

### Logs

- `get_logs`
- `set_logs`
- `get_logs_syslog`
- `del_syslogs`
- `get_rc_log`
- `get_rg_warn_logs`
- `get_rg_error_logs`
- `get_radio_pkt_logs`
- `del_radio_pkt_logs`

### Date and time

- `get_timeZone`
- `set_timeZone`
- `get_ntpServer`
- `set_ntpServer`

### Certificates

- `get_certs`
- `del_certs`
- `set_update_cert`
- `refresh-cert`
- `get_CACertificates`
- `set_installCACertificate`
- `del_CACertificate`

### Network

- `get_network`
- `set_network`
- `get_availableWifiNetworks`
- `get_networkInterfaces`
- `get_readPoints`
- `get_gpsCoordinates`
- `get_eSimConfig`
- `set_eSimConfig`

### Firmware

- `set_os`
- `revertback`

### User applications

- `install_user_app`
- `start_user_app`
- `stop_user_app`
- `autostart_user_app`
- `get_user_apps`
- `set_dataToRG`
- `set_req_usr_app`
- `uninstall-user-app`

### BLE

- `get_bleConfig`
- `set_bleConfig`

### Management Events

- `heartbeat`
- Heartbeat detail: `heartbeat_radio_control`
- Heartbeat detail: `heartbeat_reader_gateway`
- Heartbeat detail: `heartbeat_system`
- Heartbeat detail: `heartbeat_userapps`
- Heartbeat configuration: `heartbeat_interval`
- `gpi`
- `gpo`
- `error`
- `warning`
- `userapp_event`
- `firmwareUpdateProgress`
- `notification_event`

### Tag Data Events

- `tagDataEvents`
- `simple_tag_data_events`
- `inventory_tag_data_events`
- `portal_tag_data_events`
- `conveyor_tag_data_events`
- `custom_tag_data_events`

### BLE Data Events

- `ble_data_events`

### Standard reference-page template

1. Purpose and applicability.
2. MQTT command and matching REST operation, when available.
3. Authentication and prerequisites.
4. Request schema and examples.
5. Response schema, response codes, and examples.
6. Cross-field constraints and lifecycle effects.
7. Model or firmware limitations.
8. Related concept, task, and troubleshooting pages.

---

## 7. Recommended navigation tree

```text
FXR60 / FXR90 IoT Connector Developer Guide
|
+-- 1. Introduction
|   +-- About the IoT Connector
|   +-- Supported readers and model differences
|   +-- Choose MQTT or local REST
|   +-- Prerequisites
|   `-- How to use the Developer Guide and API Reference
|
+-- 2. System architecture
|   +-- System architecture
|   +-- Reader Gateway and Radio Control
|   +-- Configuration ownership
|   +-- RFID and BLE runtime lifecycle
|   `-- Commands, responses, and event flows
|
+-- 3. Getting started
|   +-- Quick start: Read your first RFID tag over MQTT
|   +-- Quick start: Check and control a reader over REST
|   `-- Verify reader identity, capabilities, and status
|
+-- 4. MQTT communication
|   +-- Connect to an MQTT broker
|   +-- Topics, connections, and endpoint planes
|   +-- Send commands and match responses
|   +-- Receive published events
|   +-- QoS, sessions, keep-alive, and reconnects
|   `-- Batching, offline retention, and replay
|
+-- 5. Connect and secure the reader
|   +-- Configure region, time, and hostname
|   +-- Configure Ethernet and Wi-Fi
|   +-- Configure FXR90 cellular and GPS
|   +-- Manage local credentials
|   +-- Install and manage certificates
|   `-- Secure connections with TLS
|
+-- 6. Configure command and event destinations
|   +-- Understand the four endpoint planes
|   +-- Configure command-response connections
|   +-- Configure RFID and BLE data connections
|   +-- Configure the management-event connection
|   +-- Route RFID and BLE separately
|   +-- Configure batching and offline retention
|   `-- Verify endpoint health
|
+-- 7. Configure and run RFID
|   +-- Choose an operating mode
|   +-- Configure antennas, power, and RF behavior
|   +-- Configure SIMPLE mode
|   +-- Configure INVENTORY mode
|   +-- Configure PORTAL mode
|   +-- Configure CONVEYOR mode
|   +-- Configure CUSTOM mode
|   +-- Start and stop RFID inventory
|   +-- Select and filter tags
|   +-- Choose tag metadata
|   +-- Read and modify tag memory
|   +-- Configure RF preselection
|   `-- Use Impinj Gen2X
|
+-- 8. Receive RFID tag data
|   +-- Understand the Tag Data Event envelope
|   +-- Process SIMPLE and INVENTORY events
|   +-- Process PORTAL and CONVEYOR events
|   +-- Process CUSTOM events and access results
|   +-- Handle optional fields and antenna identity
|   `-- Tune batching and throughput
|
+-- 9. Configure and run BLE
|   +-- BLE requirements and lifecycle
|   +-- Configure beacon protocols and filters
|   +-- Start and stop BLE scanning
|   +-- Run RFID and BLE together
|   +-- Understand the BLE Data Event envelope
|   `-- Process supported beacon formats
|
+-- 10. Reader I/O and applications
|   +-- Read GPI and control GPO
|   +-- Configure GPIO and LED actions
|   +-- Control the application LED
|   +-- Configure the FXR60 display
|   +-- Control the FXR60 Premium stack light
|   +-- Install and run user applications
|   `-- Exchange data with a user application
|
+-- 11. Manage, monitor, and maintain readers
|   +-- Monitor status and health
|   +-- Configure heartbeat reporting
|   +-- Configure errors, warnings, and GPIO events
|   +-- Monitor connectivity and data delivery
|   +-- Configure and collect logs
|   +-- Update reader firmware
|   +-- Restart or revert a reader
|   `-- Operate a fleet safely
|
+-- 12. Build a production application
|   +-- Plan the integration
|   +-- Build a local REST client
|   +-- Build an MQTT command client
|   +-- Build an RFID event consumer
|   +-- Build BLE and management-event consumers
|   +-- Recover from disconnects
|   +-- Manage throughput
|   `-- Test the integration
|
+-- 13. Common workflows
|   +-- Provision a new reader
|   +-- Send RFID data securely to an MQTT broker
|   +-- Deploy a portal workflow
|   +-- Deploy a conveyor workflow
|   +-- Route RFID and BLE to separate consumers
|   +-- Build a heartbeat health dashboard
|   +-- Deploy a user application
|   `-- Roll out firmware to a fleet
|
+-- 14. Troubleshoot and recover
|   +-- Start troubleshooting here
|   +-- Reader or local REST is unreachable
|   +-- MQTT commands or events do not arrive
|   +-- RFID produces no or poor reads
|   +-- BLE scanning produces no data
|   +-- GPIO, indicators, or FXR60 peripherals fail
|   +-- A user application fails
|   +-- A firmware update fails
|   +-- Collect diagnostic evidence
|   `-- Scope and escalate a fleet incident
|
`-- 15. API Reference
    +-- Authentication
    +-- Control commands
    +-- Impinj Gen2X
    +-- System
    +-- Application LED
    +-- Stack light
    +-- Display and attached I/O
    +-- GPIO
    +-- Region
    +-- Logs
    +-- Date and time
    +-- Certificates
    +-- Network
    +-- Firmware
    +-- User applications
    +-- BLE
    +-- Management Events
    +-- Tag Data Events
    `-- BLE Data Events
```

---

## 8. Recommended writing order

### Phase 1 — Foundation

Write first:

- About the IoT Connector
- Supported readers and model differences
- System architecture
- Reader Gateway and Radio Control
- Choose MQTT or local REST
- Configuration ownership
- Commands, responses, and event flows

**Dependency:** Every later page relies on a consistent component model, transport model, and configuration vocabulary. Resolve the architecture information gaps before publishing the component pages as authoritative.

### Phase 2 — Getting started and connectivity

Write next:

- Prerequisites
- Verify identity, capabilities, and status
- Configure region, time, hostname, and network
- Quick start: REST
- MQTT broker connection and topics
- Configure command and event destinations
- Quick start: First RFID tag over MQTT

**Dependency:** The quick starts require confirmed access, destination configuration, and the command/event model from Phase 1.

### Phase 3 — Core RFID

Write next:

- Choose an operating mode
- Configure antennas and RF behavior
- SIMPLE and INVENTORY tasks
- Start and stop inventory
- Tag Data Event envelope and basic consumers
- Selection, reporting filters, and metadata

**Dependency:** RFID tasks depend on configured destinations and the whole-mode replacement rule. Complete SIMPLE before documenting the more complex modes.

### Phase 4 — Scenario and advanced RFID

Write next:

- PORTAL, CONVEYOR, and CUSTOM
- Tag memory operations
- RF preselection
- Impinj Gen2X
- Advanced tag-event shapes and access results

**Dependency:** These pages reuse the core mode, event, antenna, and lifecycle explanations from Phase 3.

### Phase 5 — BLE and management events

Write next:

- BLE lifecycle and configuration
- BLE Data Events
- Combined RFID and BLE routing
- Management Event model
- Heartbeats
- Errors, warnings, GPIO events, and notifications

**Dependency:** These pages reuse endpoint planes, event envelopes, subscriptions, and reconnect behavior already established for RFID.

### Phase 6 — Operations and advanced reader features

Write next:

- Certificates and TLS
- GPIO and indicators
- FXR60 display and stack light
- User applications
- Monitoring and health views
- Logging
- Firmware update, reboot, and revert
- Fleet provisioning and staged rollout

**Dependency:** Operational and model-specific pages require capability detection, management-event configuration, and the security model.

### Phase 7 — Production integration and troubleshooting

Write last:

- REST and MQTT client patterns
- RFID, BLE, and management-event consumers
- Disconnect recovery and throughput
- Integration testing
- All symptom-based troubleshooting pages
- Diagnostic evidence and support escalation

**Dependency:** Troubleshooting must link to stable concept and task pages. Write it after the expected configuration and success paths are documented.

### API Reference production

Build the reference in parallel from the contracts, using the standard template in section 6. Complete high-use reference pages first: authentication, `get_version`, `get_status`, `get_config`, `set_importCloudConfig`, `set_config`, `get_mode`, `set_mode`, `start`, `stop`, Tag Data Events, heartbeat, and BLE configuration/events. Reference pages must not block foundational guide writing, but task and tutorial pages should not publish until their reference links exist.
