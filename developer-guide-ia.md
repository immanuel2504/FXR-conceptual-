# FXR60 / FXR90 Developer Guide — Information Architecture

Source of truth: `FXR_60-90_mqtt_api.json` (MQTT, 1.0.0) and `FXR_60-90_rest_api.yaml` (local REST, 3.0.0).

This guide is organized by what a developer is trying to do. The API Reference at the end follows the contract groups. Command fields, response codes, and schemas stay in the contracts. A page may name a field when the behavior depends on it. It does not restate the schema.

Anything the contracts do not state is marked **Information required**. Those items are not written as product behavior.

## 1. What the API contains

The contracts describe one reader at a time. FXR60 and FXR90 are in the same files. `get_version` also lists model strings `FX7500`, `FX9600`, and `ATR7000`. The contracts do not describe those models' hardware. **Information required:** what those model strings mean on an FXR reader.

### Capabilities that have commands

| Area | What the developer can do | Commands |
|---|---|---|
| Identity and health | Model, serial, versions, capabilities, status, hostname, password | `get_version`, `get_status`, `get_readerCapabilities`, `get_hostname`, `set_hostname`, `set_password` |
| Reach the reader | Local REST login, or MQTT command and response | REST `GET /cloud/localRestLogin`. MQTT uses the configured control or management command-response connection |
| Network | One interface per `set_network` call: `eth0`, `mlan0`, `bnep0`, `uap0`, and `wan0` on FXR90. `uap0` and `mlan0` cannot both be enabled | `get_network`, `set_network`, `get_availableWifiNetworks`, `get_networkInterfaces`, `get_readPoints` |
| Cellular and GPS | `wan0` and last GPS position are FXR90 only | `get_eSimConfig`, `set_eSimConfig`, `get_gpsCoordinates` |
| Region and time | Regulatory region, supported regions and standards, time zone, NTP | `get_region`, `set_region`, `get_supportedRegionList`, `get_supportedStandardList`, `get_timeZone`, `set_timeZone`, `get_ntpServer`, `set_ntpServer` |
| Certificates | Device certificate from a URL, CA certificates, refresh, delete. Certificate auth type NONE is not supported for the certificate download. Names are how a connection refers to a certificate | `set_updateCertificate`, `get_certs`, `del_certs`, `refresh-cert`, `set_InstallCACertificate`, `get_CACertificates`, `del_CACertificate` |
| Connections | Data connections through `set_config`. Control, data, management, and management-event connections through `set_importCloudConfig`. Included sections update. Omitted sections stay | `get_config`, `set_config`, `set_importCloudConfig` |
| Operating mode | `SIMPLE`, `INVENTORY`, `PORTAL`, `CONVEYOR`, `CUSTOM`. `set_mode` replaces the whole mode. `get_mode` with `verbose: false` returns configured values. `verbose: true` returns the effective configuration | `get_mode`, `set_mode` |
| Inventory runtime | Empty `start` or `stop` is RFID only. BLE requires `scanType` and a prior `set_bleConfig`. BLE requires reader build 4.0.11 or later. `applyImpinjGen2X` cannot be combined with `scanType` `["ble"]`. `doNotPersistState` controls RFID resume after reboot | `start`, `stop` |
| RF | Antennas, transmit power, environment, query, select, access, report filter, RSSI filter, metadata, radio start and stop conditions, antenna stop conditions, cable-loss compensation. On FXR60, integrated antenna ID 5 is near-field and ID 6 is far-field | Inside `set_mode`. Cable loss: `get_cableLossCompensation`, `set_cableLossCompensation` |
| Preselection | `rxSawFilter` on or off. This is not Gen2 select | `get_preSelection`, `set_preSelection` |
| Gen2X | Save exactly one of FastID, TagFocus, TagProtect, or TagQuieting. A later set replaces that object. `{}` is rejected. `start` with `applyImpinjGen2X` applies the saved feature. `get_status` `impinjGen2X.isActive` shows whether it is running | `get_impinjGen2X`, `set_impinjGen2X` |
| Tag data | Published on the data connection while inventory is active. Event `type` is the mode | `tagDataEvents` |
| BLE | Configure, then start with `scanType`. Results are `BLE_DATA`, not tag events | `get_bleConfig`, `set_bleConfig`, `ble_data_events` |
| GPIO and LEDs | GPI status, GPO set, application LED. `GPIO-LED` in `set_config` replaces the whole GPIO-LED object | `get_gpi_status`, `get_gpostatus`, `set_gpo`, `get_appled`, `set_appled`, `set_config` |
| Display and stack light | Display and attached I/O are FXR60 only. Stack light is FXR60 Premium only. FXR90 has no stack light | `get_displayConfig`, `set_displayConfig`, `get_inputOutputDevices`, `get_stackled`, `set_stackled` |
| Management events | Heartbeat (`radio_control`, `reader_gateway`, `system`, `userapps`), GPI, GPO, user app, error, warning. Firmware progress and notification publish on their own and are not toggled in `managementEventConfig` | `set_config` for `managementEventConfig`. `set_importCloudConfig` for the management-event destination |
| Logs | Configuration plus syslog, radio-control log, reader-gateway warning and error logs, radio packet log. Two of those files can be deleted | `get_logs`, `set_logs`, `get_logs_syslog`, `del_syslogs`, `get_rc_log`, `get_rg_warn_logs`, `get_rg_error_logs`, `get_radio_pkt_logs`, `del_radio_pkt_logs` |
| Firmware and restart | OS from a URL, progress event, revert, reboot | `set_os`, `firmwareUpdateProgress`, `revertback`, `reboot`, `get_version` |
| User applications | Install a `.deb` from a URL, list, start, stop, autostart, send a request, pass data to Reader Gateway, uninstall. Stop a running app before uninstall | `set_installUserapp`, `get_userapps`, `set_startUserapp`, `set_stopUserapp`, `set_autostartUserapp`, `set_reqToUserapp`, `set_dataToRG`, `set_uninstallUserapp` |
| Pass-through | Send `mode` or `status` to Radio Control | `set_passthru` |

Payload `command` strings above are the values in the MQTT schema. A few operation ids in `x-operationOrder` differ from those strings (`set_update_cert`, `install_user_app`, `get_user_apps`, and the other user-app ids). The reference uses the payload string.

### Dependencies the guide has to teach in order

1. A data connection must exist before a tag or BLE event has a place to go. `set_config` writes data connections. `set_importCloudConfig` writes control, management, and management-event connections, and can also write data.
2. `set_bleConfig` before a `start` that includes BLE.
3. `set_impinjGen2X` before a `start` that sets `applyImpinjGen2X`. `start` applies the saved feature. It does not create it.
4. `set_mode` before `start`. `start` runs the mode already stored.
5. `stop` returns the reader to idle before a mode or BLE change. The `stop` description says to do this before changing mode or BLE settings.
6. Install a certificate before a connection refers to it by name.
7. `get_userapps` before start, stop, autostart, or uninstall. Stop before uninstall.
8. `managementEventConfig` does not choose the broker. The management-event connection does. Firmware progress and notification still need that destination, and they are not switches in `managementEventConfig`.

### Cross-field rules inside `set_mode`

The mode schema states these constraints:

- `accesses` is not allowed in `INVENTORY`.
- Query and a prefix filter cannot both be set. When a prefix filter is used, selects cannot be used.
- `radioStartConditions` and `radioStopConditions` are not allowed in `PORTAL`.
- `reportFilter` and `accesses` cannot both be set.
- `accesses` cannot be set with `tagMetaData` containing `RESERVED`, `EPC`, `TID`, or `USER`.
- `reportFilter` cannot be set with those `tagMetaData` values unless `reportFilter.addl_keys` is configured.
- `transmitPower`, `antennaStopCondition`, and `query` array lengths must match `antennas`.
- `SIMPLE` does not accept `tagMetaData`. It reports `eventNum`, `format`, and `idHex`.

`get_mode` is how a developer sees configured values versus effective values.

### Reader limits

- Display and `get_inputOutputDevices`: FXR60 only.
- Stack light: FXR60 Premium only. Not other FXR60 variants. Not FXR90.
- `wan0`, eSIM, and GPS: FXR90 only.
- Integrated antenna IDs 5 and 6: FXR60 readers that have integrated antennas.
- Local REST is always enabled and is not turned off through `set_network`.
- REST login is the only REST call that uses basic authentication. Later REST calls use the bearer token.
- Tag, BLE, and management events are MQTT publications. They are not REST responses.

### Information required

Do not write these as facts:

- A fixed topic pattern, wildcard rules, last will, or retained-message behavior beyond the connection fields the schema lists (`qos`, `cleanSession`, `keepAlive`, `reconnectDelay`, `publishTopic`, `subscribeTopic`).
- Whether a command is delivered more than once, whether responses are ordered, or whether the reader times out a command.
- A factory reset or re-bootstrap command. None is in either contract.
- A barcode scanner. None is in either contract.
- A fleet controller, tenant, or access-rule model.
- Whether `set_region` must succeed before `set_mode` will accept transmit power.
- What `FX7500`, `FX9600`, and `ATR7000` mean when `get_version` returns them.
- How an application should size a broker or guarantee delivery. The contracts define batching, retention, and reconnect fields. They do not define capacity numbers for a deployment.

## 2. User journey

The navigation follows this path. Each step has one home.

| Step | Developer question | Home |
|---|---|---|
| 1 | What is this product? | Introduction |
| 2–3 | How do the pieces fit, including Reader Gateway and Radio Control? | Architecture |
| 4–8 | How do MQTT commands, responses, topics, and destinations work? | MQTT communication, then Connections |
| 9 | How do I set identity, region, time, and network? | Reader configuration |
| 10–11 | How do I configure RFID and start or stop it? | RFID operations |
| 12 | How do tag events arrive? | Tag data |
| 13 | How does BLE work? | BLE |
| 14 | How do management events and the heartbeat work? | Monitoring |
| 15 | How do I maintain logs, firmware, I/O, and user applications? | Logs, Firmware, Reader I/O, User applications |
| 16 | Something failed. Where do I look? | Troubleshooting |
| 17 | What is the exact field? | API Reference |

Local REST is taught in Architecture and used in Getting Started for identification. It is not a second product track. Events force MQTT for any workflow that must see tags, BLE, or heartbeats.

## 3. Content types

- **Concept** — what it is and how the pieces relate. No click-by-click procedure.
- **Task** — one job, in the order the commands must run.
- **Tutorial** — a full path that crosses several tasks. The tutorial sequences the tasks. It does not copy them.
- **Reference** — the command catalog only. Schemas stay in the contract files. The reference points at the operation.

## 4. Sections

### Introduction

Purpose: decide whether this reader and these contracts are the right surface.

Question: What can I do with an FXR60 or FXR90, and which files are the authority?

| Topic | Type | Commands | Prerequisites | Cross-links |
|---|---|---|---|---|
| What the IoT Connector does | Concept | — | — | Architecture, Getting Started |
| Supported readers | Concept | `get_version`, `get_readerCapabilities` | — | Reader I/O, Cellular |
| How this guide uses the contracts | Concept | — | — | API Reference |

### Architecture

Purpose: give the model every later task assumes.

Question: Who talks to whom, and where does state live?

| Topic | Type | Commands | Prerequisites | Cross-links |
|---|---|---|---|---|
| How the reader, broker, and application work together | Concept | — | Introduction | Connections, MQTT communication |
| Reader Gateway and Radio Control | Concept | Heartbeat sections, `get_rc_log`, `get_rg_warn_logs`, `get_rg_error_logs`, `set_passthru` | — | Heartbeat, Logs |
| Two ways to reach the reader | Concept | `GET /cloud/localRestLogin`, MQTT command envelope | — | Getting Started, REST in the reference |
| Where commands and events go | Concept | `endpointConfig` in `get_config` and `set_importCloudConfig` | — | Connections |
| How configuration is stored | Concept | `set_mode`, `set_config`, `set_importCloudConfig` | — | Configure a mode, Connections |

Reader Gateway and Radio Control get a page because those names appear in the heartbeat, the logs, and `component` on management events. The page may only say what the contracts say those sections contain. **Information required:** an internal block diagram beyond that.

### Getting Started

Purpose: one MQTT path from a reachable reader to one tag event.

Question: How do I prove this reader reads a tag?

| Topic | Type | Commands | Prerequisites | Cross-links |
|---|---|---|---|---|
| What you need | Concept | — | A reader and a data connection, or the steps to create one | Connections |
| Identify the reader | Task | `get_version`. REST alternative: login, then `GET /cloud/version` | A path to the reader | Supported readers |
| Read your first tag | Tutorial | `get_mode` or `set_mode` `SIMPLE`, subscribe to the configured data topic, `start`, read `tagDataEvents`, `stop` | Data connection already present. Commands and the tag event both use MQTT | Operating modes, Tag data |

### MQTT communication

Purpose: explain the exchange the connection pages then configure.

Question: What do I send, what comes back, and which connection fields does this API actually define?

| Topic | Type | Commands | Prerequisites | Cross-links |
|---|---|---|---|---|
| How a command and its response work | Concept | Envelope: `command`, `command_id`, `response` | — | API Reference |
| Topics, quality of service, and sessions | Concept | Connection `options`: host, port, protocol, `qos`, `cleanSession`, `keepAlive`, reconnect delays, `publishTopic`, `subscribeTopic` | — | Connections |
| What this API does not specify about MQTT | Concept | — | — | Mark the Information required list. Do not import rules from another product |

### Connections

Purpose: put each stream on a destination before expecting data.

Question: Where do commands, tag events, BLE events, and management events go?

| Topic | Type | Commands | Prerequisites | Cross-links |
|---|---|---|---|---|
| Choose where each stream is published | Concept | `endpointConfig.control`, `.data`, `.management` | Architecture | Configure connections |
| Configure data, control, and management connections | Task | `get_config`, `set_config` for data, `set_importCloudConfig` for control and management | Network path | Batching, Certificates |
| Batching and retention | Task | `set_config` and per-connection options on `set_importCloudConfig` | A data connection | Tag data, Troubleshooting |
| Secure a connection with certificates | Task | `set_updateCertificate`, CA install, then the connection's certificate name, `verifyPeer`, `verifyHost` | Certificate material at a URL the reader can fetch | Certificates fields in the reference |

`set_config` cannot configure control or management. That split is the point of the task page.

### RFID operations

Purpose: decide how the radio reads, then run it.

Question: Which mode do I want, and what has to be true before `start`?

| Topic | Type | Commands | Prerequisites | Cross-links |
|---|---|---|---|---|
| Operating modes | Concept | Mode `type` | Architecture | Configure a mode, Tag data |
| Antennas, power, and RF | Concept | Antennas, transmit power, environment, cable loss, FXR60 IDs 5 and 6 | — | Configure a mode |
| Configure a mode | Task | `get_mode`, `stop` if inventory is active, `set_mode`, `get_mode` | Cross-field rules in section 1 | Each mode's fields live in the reference |
| Start and stop inventory | Task | `start`, `stop`, `get_status` | Mode is stored. BLE config first if `scanType` includes `ble` | BLE, Gen2X |
| Choose which tags are read | Task | Select and prefix filter inside `set_mode`. `set_preSelection` for `rxSawFilter` only | Mode page. Prefix and select cannot both be used | Reported fields |
| Choose which fields are reported | Task | `reportFilter`, `rssiFilter`, `tagMetaData` inside `set_mode` | Cross-field rules with `accesses` | Tag data |
| Read and write tag memory | Task | `accesses` inside `set_mode` for `CUSTOM` | Not valid in `INVENTORY`. Conflicts with `reportFilter` and some `tagMetaData` | Tag data `accessResults` |
| Preselection | Task | `get_preSelection`, `set_preSelection` | — | Antennas and RF. Do not describe this as Gen2 select |
| Impinj Gen2X | Task | `get_readerCapabilities`, `set_impinjGen2X`, `get_impinjGen2X`, `start` with `applyImpinjGen2X`, `get_status` | One feature. Cannot combine that flag with a BLE-only `scanType` | Start and stop |

`PORTAL` trigger and radio start or stop conditions are headings on Configure a mode, because they are mode fields. `radioStartConditions` and `radioStopConditions` are rejected in `PORTAL`.

### Tag data

Purpose: consume the stream the mode produces.

Question: What arrives, when, and why might it not?

| Topic | Type | Commands | Prerequisites | Cross-links |
|---|---|---|---|---|
| How a read becomes an event | Concept | `tagDataEvents` | Data connection, inventory active, event `type` equals mode | Operating modes |
| Read a tag event | Task | Parse the event for the mode that was set. `SIMPLE` is `eventNum`, `format`, `idHex` | Subscribe to the data topic before `start` | Workflows |

Per-mode field tables stay in the reference. The task page says which shape to expect and which fields are absent in `SIMPLE`.

### BLE

Purpose: keep BLE off the RFID path.

Question: How do I scan, and where do beacon events arrive?

| Topic | Type | Commands | Prerequisites | Cross-links |
|---|---|---|---|---|
| Configure BLE | Task | `get_bleConfig`, `set_bleConfig` | Build 4.0.11 or later for `scanType` | Data connection |
| Start and stop a BLE scan | Task | `start` and `stop` with `scanType` | BLE config. Empty body does not scan BLE | Inventory |
| Read BLE data events | Task | `ble_data_events` | BLE data is not a tag event | Route RFID and BLE tutorial |

### Reader configuration

Purpose: make the reader legal, identifiable, and reachable.

Question: What do I set before I trust tag reads?

| Topic | Type | Commands | Prerequisites | Cross-links |
|---|---|---|---|---|
| Region, time, and identity | Task | Region commands, time zone, NTP, hostname, password | `get_supportedRegionList` before `set_region` | Supported readers |
| Network | Task | `get_network`, `get_networkInterfaces`, `get_availableWifiNetworks`, `set_network`, `get_readPoints` | One interface per call. Confirm the path still answers | Getting Started |
| Cellular and GPS | Task | `get_eSimConfig`, `set_eSimConfig`, `get_gpsCoordinates` | FXR90. `wan0` is absent on FXR60 | Supported readers |

**Information required:** whether an unset region causes `set_mode` to fail. The task tells the developer to read the supported list and set the region. It does not claim the reader enforces an order the schema does not state.

### Reader I/O

Purpose: physical inputs, outputs, and the FXR60 panel.

Question: How do I see a GPI, drive a GPO, or use the panel on the model that has it?

| Topic | Type | Commands | Prerequisites | Cross-links |
|---|---|---|---|---|
| GPIO | Task | `get_gpi_status`, `set_gpo`, `get_gpostatus`, `GPIO-LED` in `set_config` | `GPIO-LED` replaces the whole object. Read `get_config` first | PORTAL trigger, GPI events |
| Application LED | Task | `get_appled`, `set_appled` | — | GPIO-LED actions |
| Display and stack light | Task | Display commands, `get_inputOutputDevices`, stack-light commands | Confirm model. Stack light is FXR60 Premium only | `notification_event` |

### User applications

Purpose: software on the reader, separate from RFID `start`.

Question: How do I install an application and tell it from inventory?

| Topic | Type | Commands | Prerequisites | Cross-links |
|---|---|---|---|---|
| Install and run a user application | Task | `set_installUserapp`, `get_userapps`, `set_startUserapp`, `set_stopUserapp`, `set_autostartUserapp`, `set_uninstallUserapp` | Stop before uninstall | Heartbeat `userapps` |
| Send data to an application | Task | `set_reqToUserapp`, `set_dataToRG` | Application is running for a request. MQTT request requires `userapp` in the body | User-app events |

### Monitoring

Purpose: ask for health, and receive the events the reader publishes on its own.

Question: How do I know the reader is up and what changed?

| Topic | Type | Commands | Prerequisites | Cross-links |
|---|---|---|---|---|
| Turn management events on | Task | Management-event connection, then `managementEventConfig` in `set_config` | Destination first | Connections |
| Heartbeat | Concept | `heartbeat` and its four sections, `get_status` | Reporting is on | Reader Gateway and Radio Control |
| Errors, warnings, and notifications | Task | `error`, `warning`, `notification_event`, GPI and GPO events | Same destination. Firmware progress is separate | Firmware, Display |

### Logs

Purpose: the files behind the heartbeat.

Question: Which file matches the layer that failed, and which files can I delete?

| Topic | Type | Commands | Prerequisites | Cross-links |
|---|---|---|---|---|
| Read and clear logs | Task | `get_logs`, `set_logs`, the five get-log commands, `del_syslogs`, `del_radio_pkt_logs` | Copy before delete. Only syslog and radio packet log have delete commands | Troubleshooting |

### Firmware and restart

Purpose: change the OS or reboot without losing the thread of what comes back.

Question: How do I update, watch progress, revert, or restart?

| Topic | Type | Commands | Prerequisites | Cross-links |
|---|---|---|---|---|
| Update, revert, or restart | Task | `get_version`, `set_os`, `firmwareUpdateProgress`, `revertback`, `reboot` | Management-event destination if progress must be seen. `start` is where RFID resume after reboot is chosen | Monitoring |

### Workflows

Purpose: end-to-end sequences. Each step links to a task. It does not restate the task.

| Topic | Type | Sequence |
|---|---|---|
| Read your first tag | Tutorial | Already in Getting Started. Do not write it twice |
| Send tag data to a broker | Tutorial | Data connection → `SIMPLE` or the chosen mode → `start` → consume `tagDataEvents` → `stop` |
| Portal read | Tutorial | GPI available → `PORTAL` mode with its trigger → do not send radio start or stop conditions → `start` → tag events after the trigger → `stop` |
| Conveyor read | Tutorial | `CONVEYOR` mode → `start` → consume that event type → `stop` |
| Route RFID and BLE separately | Tutorial | Two data connections or two topics → `set_bleConfig` → `start` with RFID and `scanType` `ble` → tag events and `BLE_DATA` on their destinations → `stop` |
| Watch the heartbeat | Tutorial | Management-event connection → `managementEventConfig.heartbeat` → subscribe → compare with `get_status` |

`INVENTORY` and `CUSTOM` are tasks on Configure a mode, not extra tutorials. Their extra fields are mode fields. A tutorial would repeat the task.

### Troubleshooting

Purpose: start from what is visible and route to the task that owns the fix.

Question: Which layer failed?

| Topic | Type | Look here | Cross-links |
|---|---|---|---|
| Start from what you can see | Tutorial | `get_version`, `get_status`, the log that matches the layer | Logs |
| Network and local REST | Task | `get_networkInterfaces`, `set_network` path loss, login and bearer token, FXR90 cellular | Network |
| Commands and events | Task | Command response missing, one `endpointConfig` section up and another down, retention not replaying | Connections, MQTT communication |
| RFID reads | Task | No `tagDataEvents`, wrong event `type`, rejected `set_mode`, antenna, PORTAL trigger, `accessResults` | RFID operations |
| BLE | Task | No `scanType`, build older than 4.0.11, filters, `BLE_DATA` absent while tags still arrive | BLE |
| Firmware, I/O, and user applications | Task | `firmwareUpdateProgress`, GPI or GPO, display or stack light on the wrong model, user app not started | Those task pages |

## 5. Workflows

Commands are the payload names. REST equivalents exist for the same actions under `/cloud/…` except the event streams.

### Initial reader setup

Goal: know the unit, set region and clock, and keep the address you will use.

Prerequisites: a network path.

`get_version` → `get_supportedRegionList` → `set_region` → `set_timeZone` → `set_ntpServer` → `get_network` → `set_network` only if the interface must change.

### MQTT destinations

Goal: give commands and events a connection.

Prerequisites: broker host, port, and topics you intend to use. **Information required:** any topic layout the reader requires beyond the `publishTopic` and `subscribeTopic` arrays you send.

`get_config` → `set_importCloudConfig` for control, management, and management events → `set_config` when the change is data-plane only.

### First RFID tag read

Goal: one `SIMPLE` tag event over MQTT.

Prerequisites: a data connection.

Subscribe to the data topic → `set_mode` with `type` `SIMPLE` → `start` with an empty body → read `tagDataEvents` → `stop`.

### SIMPLE, INVENTORY, PORTAL, CONVEYOR, CUSTOM

Goal: run that mode.

Prerequisites: `stop` if a session is active. Send the whole mode object.

`get_mode` → `set_mode` with that `type` and the fields that type allows → `get_mode` → `start` → read events whose `type` matches → `stop`.

PORTAL adds the GPI trigger inside the mode and omits `radioStartConditions` and `radioStopConditions`. CUSTOM is the mode that carries access operations. INVENTORY cannot include `accesses`.

### RFID filtering and tag metadata

Goal: limit which tags are inventoried and which fields are published.

`set_mode` with either a prefix filter or selects, not both → `reportFilter`, `rssiFilter`, and `tagMetaData` within the cross-field rules → `start` → compare a tag event with `get_mode`.

### Preselection

Goal: turn the `rxSawFilter` on or off.

`get_preSelection` → `set_preSelection` → `start`. This does not change select or the prefix filter.

### Impinj Gen2X

Goal: run one saved Gen2X feature on the next RFID start.

`get_readerCapabilities` → `set_impinjGen2X` with one feature → `get_impinjGen2X` → `start` with `applyImpinjGen2X` and without a BLE-only `scanType` → `get_status` for `impinjGen2X.isActive`.

### BLE scanning

Goal: receive `BLE_DATA`.

`set_bleConfig` → data destination → `start` with `scanType` including `ble` → read `ble_data_events` → `stop` with `scanType` if RFID should keep running.

### RFID and BLE together

Goal: both streams in one session.

Same as BLE, and the `start` body includes RFID plus `ble`. Do not set `applyImpinjGen2X` on a BLE-only start. A combined start may include the flag. Confirm against the schema note: the flag cannot be combined with `scanType` `["ble"]`. A body that is only BLE cannot also apply Gen2X.

### Route RFID and BLE

Goal: separate destinations.

Configure more than one data connection, or more than one publish topic, in `set_config` or `set_importCloudConfig` → `start` with a targeted `scanType` object keyed by data-endpoint name when the scan should not be global.

**Information required:** a recommended topic split beyond "the connection you configure is where that stream is published."

### Management events and heartbeat

Goal: receive heartbeats, errors, and warnings.

`set_importCloudConfig` management-event connection → `set_config` `managementEventConfig` → subscribe → `get_status` to compare.

### GPIO

Goal: read an input and drive an output.

`get_gpi_status` → `set_gpo` → optional `GPIO-LED` in `set_config` → enable `gpiEvents` and `gpoEvents` if the application should see changes.

### User applications

Goal: run software on the reader across reboot.

`set_installUserapp` → `get_userapps` → `set_startUserapp` → `set_autostartUserapp` → `set_stopUserapp` before `set_uninstallUserapp`.

### Firmware update

Goal: move to another OS and know whether it finished.

`get_version` → `set_os` → `firmwareUpdateProgress` → `get_version` → `revertback` only after reading `revertBackFirmware`.

## 6. Concept pages the reference does not replace

| Page | Why it is its own page |
|---|---|
| How the reader, broker, and application work together | The contracts never say who owns a session. Every task assumes it. |
| Reader Gateway and Radio Control | Developers meet the names in heartbeats, logs, and `component`. Without a page they treat them as extra APIs. |
| Two ways to reach the reader | REST can start inventory and still return no tag event. That surprise belongs in one place. |
| Where commands and events go | `set_config` and `set_importCloudConfig` look like duplicates until the planes are named. |
| How configuration is stored | `set_mode` replaces the object. `GPIO-LED` replaces its object. Cloud import updates included sections. One rule page prevents three task pages from restating it. |
| How a command and its response work | `command_id` correlation is the integration contract. The reference only shows the schema. |
| Operating modes | The five types decide the tag event. Meeting them first inside `set_mode`'s schema is too late. |
| How a read becomes an event | Ties `set_mode`, an active inventory, the data connection, and `tagDataEvents` into one sentence the task pages can point at. |
| Heartbeat | The four sections are the map for logs and troubleshooting. |
| What this API does not specify about MQTT | Stops the guide from copying delivery rules that are not in these contracts. |

## 7. What the guide does not do

The guide does not have sections named System APIs, Network APIs, BLE APIs, GPIO APIs, or Firmware APIs. Those names are the reference groups.

Reader Gateway is not an RFID chapter. Radio Control is not an RFID chapter. BLE is not a network page. Wi-Fi is a heading on Network, because `set_network` updates `mlan0` as one interface.

## 8. API Reference

Group names follow the contract. Commands are the MQTT payload `command` values. REST paths are the matching `/cloud/…` operations in the REST contract, plus `GET /cloud/localRestLogin`, which has no MQTT command.

### Control

`get_mode`, `set_mode`, `start`, `stop`, `get_preSelection`, `set_preSelection`

### Impinj Gen2X

`get_impinjGen2X`, `set_impinjGen2X`

### System

`get_version`, `get_status`, `get_config`, `set_config`, `set_passthru`, `set_importCloudConfig`, `get_readerCapabilities`, `get_cableLossCompensation`, `set_cableLossCompensation`, `reboot`, `set_password`, `get_hostname`, `set_hostname`

### Network

`get_network`, `set_network`, `get_availableWifiNetworks`, `get_networkInterfaces`, `get_readPoints`, `get_gpsCoordinates`, `get_eSimConfig`, `set_eSimConfig`

### Region

`get_region`, `set_region`, `get_supportedRegionList`, `get_supportedStandardList`

### GPIO

`get_gpi_status`, `get_gpostatus`, `set_gpo`

### LED

`get_appled`, `set_appled`, `get_stackled`, `set_stackled`

### Display

`get_displayConfig`, `set_displayConfig`, `get_inputOutputDevices`

### Date and time

`get_timeZone`, `set_timeZone`, `get_ntpServer`, `set_ntpServer`

### Certificate

`get_certs`, `set_updateCertificate`, `del_certs`, `refresh-cert`, `get_CACertificates`, `set_InstallCACertificate`, `del_CACertificate`

Confirm `get_certs`, `del_certs`, `refresh-cert`, and `set_InstallCACertificate` against the payload `command` enum while writing the reference page. The descriptions use those names. The operation-id list uses `set_update_cert` and `set_installCACertificate`.

### Logs

`get_logs`, `set_logs`, `get_logs_syslog`, `del_syslogs`, `get_rc_log`, `get_rg_warn_logs`, `get_rg_error_logs`, `get_radio_pkt_logs`, `del_radio_pkt_logs`

### Firmware

`set_os`, `revertback`

### User applications

`set_installUserapp`, `get_userapps`, `set_startUserapp`, `set_stopUserapp`, `set_autostartUserapp`, `set_reqToUserapp`, `set_dataToRG`, `set_uninstallUserapp`

### BLE

`get_bleConfig`, `set_bleConfig`

### Management events

`heartbeat`, `heartbeat_radio_control`, `heartbeat_reader_gateway`, `heartbeat_system`, `heartbeat_userapps`, `gpi`, `gpo`, `userapp_event`, `error`, `warning`, `firmwareUpdateProgress`, `notification_event`

### Tag data events

`tagDataEvents`

### BLE data events

`ble_data_events`

### Local REST only

`GET /cloud/localRestLogin`

## 9. Navigation tree

```
FXR Developer Guide
│
├── 1. Introduction
│   ├── What the IoT Connector does
│   ├── Supported readers
│   └── How this guide uses the contracts
│
├── 2. Architecture
│   ├── How the reader, broker, and application work together
│   ├── Reader Gateway and Radio Control
│   ├── Two ways to reach the reader
│   ├── Where commands and events go
│   └── How configuration is stored
│
├── 3. Getting Started
│   ├── What you need
│   ├── Identify the reader
│   └── Read your first tag
│
├── 4. MQTT communication
│   ├── How a command and its response work
│   ├── Topics, quality of service, and sessions
│   └── What this API does not specify about MQTT
│
├── 5. Connections
│   ├── Choose where each stream is published
│   ├── Configure data, control, and management connections
│   ├── Batching and retention
│   └── Secure a connection with certificates
│
├── 6. RFID operations
│   ├── Operating modes
│   ├── Antennas, power, and RF
│   ├── Configure a mode
│   ├── Start and stop inventory
│   ├── Choose which tags are read
│   ├── Choose which fields are reported
│   ├── Read and write tag memory
│   ├── Preselection
│   └── Impinj Gen2X
│
├── 7. Tag data
│   ├── How a read becomes an event
│   └── Read a tag event
│
├── 8. BLE
│   ├── Configure BLE
│   ├── Start and stop a BLE scan
│   └── Read BLE data events
│
├── 9. Reader configuration
│   ├── Region, time, and identity
│   ├── Network
│   └── Cellular and GPS
│
├── 10. Reader I/O
│   ├── GPIO
│   ├── Application LED
│   └── Display and stack light
│
├── 11. User applications
│   ├── Install and run a user application
│   └── Send data to an application
│
├── 12. Monitoring
│   ├── Turn management events on
│   ├── Heartbeat
│   └── Errors, warnings, and notifications
│
├── 13. Logs
│   └── Read and clear logs
│
├── 14. Firmware and restart
│   └── Update, revert, or restart
│
├── 15. Workflows
│   ├── Send tag data to a broker
│   ├── Portal read
│   ├── Conveyor read
│   ├── Route RFID and BLE separately
│   └── Watch the heartbeat
│
├── 16. Troubleshooting
│   ├── Start from what you can see
│   ├── Network and local REST
│   ├── Commands and events
│   ├── RFID reads
│   ├── BLE
│   └── Firmware, I/O, and user applications
│
└── API Reference
    ├── Control
    ├── Impinj Gen2X
    ├── System
    ├── Network
    ├── Region
    ├── GPIO
    ├── LED
    ├── Display
    ├── Date and time
    ├── Certificate
    ├── Logs
    ├── Firmware
    ├── User applications
    ├── BLE
    ├── Management events
    ├── Tag data events
    ├── BLE data events
    └── Local REST login
```

Forty-four guide topics, plus the reference groups. Getting Started owns the first-tag tutorial, so Workflows does not repeat it.

## 10. Writing order

### Phase 1 — Foundation

Write Introduction, Architecture, and "What this API does not specify about MQTT."

Later pages link here instead of restating planes, `set_mode` replacement, and the REST event gap. Do not start task pages before "Where commands and events go" and "How configuration is stored" are stable.

### Phase 2 — Getting Started

Write Identify the reader and Read your first tag.

Depends on Phase 1. Uses `SIMPLE` and assumes a data connection. If that assumption is too strong for a new developer, write "Configure data, control, and management connections" in the same phase and link it from What you need.

### Phase 3 — RFID

Write Operating modes, Configure a mode, Start and stop inventory, then How a read becomes an event.

This is the center of the product. Antennas, tag selection, reported fields, and preselection come immediately after, because they are mode fields and the `rxSawFilter` command. Gen2X and tag memory wait until `start` and `CUSTOM` are clear.

### Phase 4 — Events

Write Tag data, BLE, Turn management events on, and Heartbeat.

Depends on Connections and on Phase 3. BLE stays behind RFID so `scanType` is explained against an empty `start`.

### Phase 5 — Management

Write Region, time, and identity, Network, Certificates, Logs, and Firmware.

Network can move earlier if Getting Started readers do not already have an address. Certificates move earlier if the first broker requires TLS.

### Phase 6 — Advanced

Write Cellular and GPS, GPIO, Application LED, Display and stack light, and User applications.

Each page is model-scoped or is a second runtime. They are real. They are not on the first-tag path.

### Phase 7 — Troubleshooting and the remaining workflows

Write the troubleshooting routes, then Portal, Conveyor, Route RFID and BLE, and Watch the heartbeat.

Troubleshooting links to pages that must already exist. Workflows are sequences over those pages.

### Phase 8 — API Reference

Fill the reference groups from the contracts after the guide names are stable. The reference does not invent a second explanation of a workflow.

Dependencies: Phase 3 depends on Phase 1. Phase 4 depends on Phase 3 and Connections. Phase 7 depends on every task it routes to. The reference can be indexed in parallel, and its prose waits until the guide topics stop moving.
