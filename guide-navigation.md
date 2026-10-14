# FXR developer guide navigation

This navigation is organized by what a developer is trying to do. The product facts stay those in `FXR_60-90_mqtt_api.json` and `FXR_60-90_rest_api.yaml`. This file decides where each fact is taught once.

Two levels only: a section, then a page. A new feature is a new page under the matching goal. It does not add a new level.

## How to read this guide

| If you want to… | Start here |
|---|---|
| Learn the model | Learn the reader |
| Read a tag on one reader | Get started |
| Change a setting | The task page for that goal |
| Follow a full setup | Follow a workflow |
| Find out why something failed | Fix a problem |
| Look up a field or command | API Reference |

Workflows, troubleshooting, and the reference link to the task pages. They do not copy them.

## Words used throughout

Use these words in titles and body text. The API name is in parentheses when a developer must type it.

| Use this | Do not also call it |
|---|---|
| Operating mode | Read profile, performance profile |
| Tag data event | Tag report, tag stream, data endpoint event |
| BLE data event | Bluetooth event, beacon API |
| Management event | Alert API, status API |
| Connection | Endpoint plane, channel, slot |
| Command and response | Request API, callback |
| Local REST | The other API, HTTP API |
| Preselection | Select, tag filter |

Preselection is `rxSawFilter` (`set_preSelection`). Select and the prefix filter are fields inside `set_mode`. Those are different pages.

The first time Connections are explained, say that the contracts call them endpoint configuration. After that, the guide says connection.

## Page rules

Each page answers one question. The type is Concept, Task, Tutorial, or Reference.

A task page begins with what must already be done, as links. It then does one job. It ends with the related concept, the next task, and the reference group.

A tutorial is only a sequence of those links.

A troubleshooting page names the symptom, the first command to run, and the task page that owns the fix.

## 1. Learn the reader

Concepts only. Broad first.

| Page | Question | Depends on | Do not repeat this on |
|---|---|---|---|
| What the IoT Connector does | What can I do with this reader, and what is outside these contracts? | — | Task pages |
| Which reader you have | What is different on FXR60, FXR60 Premium, and FXR90? | — | Display, cellular, and antenna tasks. Those pages link here |
| How the pieces work together | Who is the reader, the broker, and my application, and where is state stored? | What the IoT Connector does | MQTT and connection tasks |
| How commands, responses, and events work | What do I send, what comes back, and what arrives on its own? | How the pieces work together | Every task that sends a command |
| How an operating mode shapes tag data | What do SIMPLE, INVENTORY, PORTAL, CONVEYOR, and CUSTOM change? | How commands, responses, and events work | Set the operating mode. That page links here |
| How configuration is saved | Which calls replace a whole object, and which update only what I send? | How the pieces work together | Set the operating mode, Connections, GPIO |

Also on "How commands, responses, and events work": local REST can run the same control calls and does not return tag, BLE, or management events. `command_id` matches a response to a command. Connection fields that exist in the schema (`qos`, `cleanSession`, `keepAlive`, reconnect delays, publish and subscribe topics) are named here. Rules the contracts do not state are listed once, as information the contracts do not provide. They are not given their own page.

Also on "How the pieces work together": Reader Gateway and Radio Control, because those names appear in the heartbeat, the logs, and event `component`. They are explained here. They are not a section.

## 2. Get started

One tutorial. The common path.

| Page | Question | Depends on |
|---|---|---|
| Read your first tag | How do I receive one SIMPLE tag data event over MQTT? | A data connection. If it does not exist yet, do Configure an MQTT broker first |

Sequence, as links: identify the reader, set operating mode SIMPLE, subscribe to the data topic, `start`, read the tag data event, `stop`.

Identifying the reader can use MQTT `get_version` or local REST login and `GET /cloud/version`. That choice is a step in the tutorial, with a link to "How commands, responses, and events work." It is not a second quick start.

## 3. Set up the reader

Tasks. Common setup first. Network is its own group, because `set_network` covers more than one way to reach the reader. The pages follow the order a developer does the work: see what is there, then change one interface.

| Page | Question | Depends on |
|---|---|---|
| Confirm the reader | How do I know the model, serial number, and capabilities? | A path to the reader |
| Set region, time, and name | How do I set the regulatory region, clock, hostname, and password? | Confirm the reader. Read `get_supportedRegionList` before `set_region` |
| Understand network configuration | What interfaces can this reader use, and what does one `set_network` call change? | Confirm the reader. One interface per call: `eth0`, `mlan0`, `bnep0`, `uap0`, and `wan0` on FXR90. A change can drop the path you are using |
| View network interfaces | Which interfaces are present, and what is configured on them? | Understand network configuration. `get_network` and `get_networkInterfaces` |
| Configure IP addressing | How do I choose DHCP or a static IPv4 or IPv6 address? | View network interfaces. These fields are sent inside the interface object on `set_network`. They are not a separate command. Ethernet, Wi-Fi, and cellular link here instead of repeating the fields |
| Configure Ethernet | How do I set `eth0`, including 802.1X? | Configure IP addressing |
| Discover Wi-Fi networks | What Wi-Fi networks can the reader see? | View network interfaces. `get_availableWifiNetworks` |
| Configure Wi-Fi | How do I join a network on `mlan0`, including an enterprise network? | Discover Wi-Fi networks. Enterprise auth links to Secure a connection. `uap0` and `mlan0` cannot both be enabled |
| Configure cellular | How do I set `wan0` with a physical SIM or an eSIM, and read the last GPS position? | "Which reader you have." FXR90 only. eSIM is `set_eSimConfig` and `wan0.activeSim`. The physical SIM is the other `activeSim` value |
| Use the reader as an access point | How do I turn on `uap0` so other devices join the reader? | Understand network configuration. Cannot be enabled together with `mlan0` |
| Connect over a Bluetooth network | How do I pair and address `bnep0`? | Understand network configuration. This is not a BLE tag scan. BLE stays under Scan for BLE |
| Troubleshoot network connectivity | The reader no longer answers after a network change. What do I check? | The interface page you last changed. This is the only copy of those checks. "The reader does not answer" links here |
| Understand endpoint configuration | Where can this reader send commands and events, and which call writes which connection? | A working address from Network. `set_config` writes data connections. `set_importCloudConfig` writes control, management, and management-event connections, and can write data. Included sections change. Omitted sections stay |
| Configure an MQTT broker | How do I send a stream to my own MQTT broker? | Understand endpoint configuration. Connection type `mqtt` |
| Configure AWS IoT | How do I send a stream to AWS IoT Core? | Understand endpoint configuration. Connection type `mqtt-AWS` |
| Configure Azure IoT | How do I send a stream to Azure IoT Hub? | Understand endpoint configuration. Connection type `mqtt-Azure` |
| Configure Google Cloud IoT | How do I send a stream to Google Cloud IoT? | Understand endpoint configuration. Connection type `mqtt-GCP` |
| Configure an HTTP POST destination | How do I POST tag data to a URL? | Understand endpoint configuration. Connection type `httpPost` |
| Configure a WebSocket, TCP server, or keyboard connection | How do I use `WEBSOCKET`, `tcpip-server`, or `keyboard-emulation`? | Understand endpoint configuration. Only one connection of each of these three types is allowed at a time |
| Configure batching and retention | How do I group events and keep them while the reader is offline? | The data connection already exists. Receive tag data links here and does not explain the fields again |
| Secure a connection | How do I install a certificate and turn on TLS for a connection? | The endpoint page you are securing. A certificate is referred to by the name stored on the reader |

Read points (`get_readPoints`) stay on "Set antennas and transmit power." They name where the radio reads. They do not give the reader an address.

The order is the reader, then Network, then Endpoint configuration. MQTT broker, AWS IoT, and Azure IoT are the usual destinations. Google Cloud IoT, HTTP POST, WebSocket, TCP server, and keyboard emulation are the other types in the contract, so they stay in the same group. Each of those pages chooses a type. The shared rules stay on Understand endpoint configuration.

## 4. Read tags

Tasks. The usual read first. Memory, Gen2X, and preselection last.

| Page | Question | Depends on |
|---|---|---|
| Set the operating mode | How do I store SIMPLE, INVENTORY, PORTAL, CONVEYOR, or CUSTOM? | "How an operating mode shapes tag data." `stop` if a session is active. `set_mode` replaces the whole mode. Send the cross-field rules from the mode schema |
| Set antennas and transmit power | How do I choose ports, power, environment, and cable-loss compensation? | Set the operating mode. FXR60 integrated IDs 5 and 6 are on "Which reader you have" |
| Start and stop reading | How do I start or stop RFID inventory? | A stored mode. An empty body is RFID only |
| Choose which tags and fields are reported | How do I limit which tags are read and which fields are published? | Set the operating mode. A prefix filter and selects cannot both be used |
| Read and write tag memory | How do I run read, write, lock, kill, or access on a tag? | CUSTOM. `accesses` is not allowed in INVENTORY and conflicts with some report and metadata settings |
| Use Impinj Gen2X | How do I save one Gen2X feature and apply it when inventory starts? | `set_impinjGen2X` saves one of FastID, TagFocus, TagProtect, or TagQuieting. `start` applies it. `start` does not create it |
| Change RF preselection | How do I turn `rxSawFilter` on or off? | Independent of select. Use `set_preSelection` |

PORTAL's GPI trigger, and radio start and stop conditions, are steps on "Set the operating mode." Radio start and stop conditions are not allowed in PORTAL. There is not a separate page per mode.

## 5. Receive tag data

| Page | Question | Depends on |
|---|---|---|
| Receive tag data events | How do I read the event for the mode I set, and what do I do when none arrive? | Data connection. Inventory is active. Event `type` is the operating mode. SIMPLE reports `eventNum`, `format`, and `idHex` |

Field tables stay in the API Reference. This page says which shape to expect and links to the reference.

## 6. Scan for BLE

Separate from RFID. After tag data, because it is the next stream a developer adds.

| Page | Question | Depends on |
|---|---|---|
| Run a BLE scan | How do I configure BLE and start or stop it? | `set_bleConfig` first. Reader build 4.0.11 or later for `scanType`. Empty `start` does not scan BLE |
| Receive BLE data events | How do I read a BLE data event? | Run a BLE scan. This event is not a tag data event |

Running RFID and BLE in one `start` is a step on "Run a BLE scan," with a link to "Start and stop reading." Sending them to different connections is a workflow.

## 7. Monitor the reader

| Page | Question | Depends on |
|---|---|---|
| Turn on heartbeats and alerts | How do I choose the management events the reader publishes? | A management-event connection from Endpoint configuration. Firmware progress and notifications are not switches. They publish to that connection on their own |
| Check reader health | How do I read a heartbeat and compare it with status? | Turn on heartbeats and alerts. The four heartbeat areas link to "How the pieces work together" |
| Respond to errors and warnings | How do I tell an error, a warning, a GPIO event, and a notification apart? | The same management-event connection |

## 8. Maintain the reader

| Page | Question | Depends on |
|---|---|---|
| Read logs | Which log matches Radio Control, Reader Gateway, or the system, and which files can I delete? | Copy a log before deleting it. Only syslog and the radio packet log have delete commands |
| Update or restart the reader | How do I update the OS, watch progress, revert, or reboot? | A management-event connection if progress must be seen. RFID resume after reboot is chosen on `start`. Link to "Start and stop reading" |

## 9. Control inputs and indicators

Less common than reading tags. Its own section, so it is not mixed with logs or applications.

| Page | Question | Depends on |
|---|---|---|
| Use GPIO and the application LED | How do I read a GPI, set a GPO, and control the application LED? | `GPIO-LED` inside `set_config` replaces that whole object. Link to "How configuration is saved" and to the PORTAL step on "Set the operating mode" |
| Use the display and stack light | How do I configure the panel on the reader that has it? | "Which reader you have." Display is FXR60. Stack light is FXR60 Premium |

## 10. Run software on the reader

| Page | Question | Depends on |
|---|---|---|
| Install and run a user application | How do I install, start, stop, autostart, and remove software on the reader? | This is not RFID `start`. Stop the application before uninstall |
| Send data to a user application | How do I pass a request or data to an application? | The application is installed. MQTT `set_reqToUserapp` requires `userapp` in the body |

## 11. Follow a workflow

Tutorials only. Each page is an ordered list of links.

| Page | Question | Links through |
|---|---|---|
| Send tag data to a broker | How do I go from no connection to a tag data event? | Configure an MQTT broker, or Configure AWS IoT or Configure Azure IoT → Set the operating mode → Start and stop reading → Receive tag data events |
| Run a portal | How do I read tags after a GPI trigger? | Use GPIO and the application LED → Set the operating mode (PORTAL) → Start and stop reading → Receive tag data events |
| Run a conveyor | How do I run a CONVEYOR session? | Set the operating mode → Start and stop reading → Receive tag data events |
| Send RFID and BLE apart | How do I put tag data and BLE data on different connections? | Understand endpoint configuration → Run a BLE scan → Receive tag data events → Receive BLE data events |
| Watch the reader | How do I see heartbeats and compare them with status? | Turn on heartbeats and alerts → Check reader health |
| Set up the next reader | How do I repeat one reader's setup on another? | Confirm the reader → Set region, time, and name → the interface page you used → the endpoint page you used → Set the operating mode |

The contracts describe one reader at a time. "Set up the next reader" repeats those tasks per reader. A fleet controller, tenant model, or shared topic rule is not in the contracts, so this page does not describe one.

## 12. Fix a problem

Each page starts from a symptom and links to the task. It does not restate the procedure.

| Page | Question | First checks, then the task |
|---|---|---|
| Start here | What should I look at first? | `get_version`, `get_status`, then Read logs |
| The reader does not answer | Why is local REST or the address failing? | Troubleshoot network connectivity, then Secure a connection if the certificate or the token is the failure |
| Commands or events do not arrive | Why is one stream missing? | How commands, responses, and events work → Understand endpoint configuration |
| Tag reads are missing or poor | Why are there no tag data events, or the wrong ones? | Set the operating mode → Set antennas and transmit power → Start and stop reading → Receive tag data events |
| BLE data does not arrive | Why is BLE silent while RFID still works? | Run a BLE scan → Receive BLE data events |
| A panel, application, or update failed | Why did GPIO, the panel, a user application, or firmware stop? | The matching page in sections 8, 9, or 10 |

Evidence to collect before asking for help is the last step on "Start here," not a second troubleshooting guide.

## 13. API Reference

Separate from the guide. One page per contract group. Each operation states the payload `command` value, the REST path when one exists, and a link to the guide page that uses it. Schemas stay in the contract files.

Authentication (`GET /cloud/localRestLogin`) · Control · Impinj Gen2X · System · Network · Region · Date and time · Certificates · GPIO · LED · Display · Logs · Firmware · User applications · BLE · Management events · Tag data events · BLE data events

`reboot` stays under System in the reference and is used by "Update or restart the reader" in the guide.

## Navigation tree

```
FXR developer guide
│
├── Learn the reader
│   ├── What the IoT Connector does
│   ├── Which reader you have
│   ├── How the pieces work together
│   ├── How commands, responses, and events work
│   ├── How an operating mode shapes tag data
│   └── How configuration is saved
│
├── Get started
│   └── Read your first tag
│
├── Set up the reader
│   ├── Confirm the reader
│   ├── Set region, time, and name
│   ├── Network
│   │   ├── Understand network configuration
│   │   ├── View network interfaces
│   │   ├── Configure IP addressing
│   │   ├── Configure Ethernet
│   │   ├── Discover Wi-Fi networks
│   │   ├── Configure Wi-Fi
│   │   ├── Configure cellular
│   │   ├── Use the reader as an access point
│   │   ├── Connect over a Bluetooth network
│   │   └── Troubleshoot network connectivity
│   ├── Endpoint configuration
│   │   ├── Understand endpoint configuration
│   │   ├── Configure an MQTT broker
│   │   ├── Configure AWS IoT
│   │   ├── Configure Azure IoT
│   │   ├── Configure Google Cloud IoT
│   │   ├── Configure an HTTP POST destination
│   │   ├── Configure a WebSocket, TCP server, or keyboard connection
│   │   └── Configure batching and retention
│   └── Secure a connection
│
├── Read tags
│   ├── Set the operating mode
│   ├── Set antennas and transmit power
│   ├── Start and stop reading
│   ├── Choose which tags and fields are reported
│   ├── Read and write tag memory
│   ├── Use Impinj Gen2X
│   └── Change RF preselection
│
├── Receive tag data
│   └── Receive tag data events
│
├── Scan for BLE
│   ├── Run a BLE scan
│   └── Receive BLE data events
│
├── Monitor the reader
│   ├── Turn on heartbeats and alerts
│   ├── Check reader health
│   └── Respond to errors and warnings
│
├── Maintain the reader
│   ├── Read logs
│   └── Update or restart the reader
│
├── Control inputs and indicators
│   ├── Use GPIO and the application LED
│   └── Use the display and stack light
│
├── Run software on the reader
│   ├── Install and run a user application
│   └── Send data to a user application
│
├── Follow a workflow
│   ├── Send tag data to a broker
│   ├── Run a portal
│   ├── Run a conveyor
│   ├── Send RFID and BLE apart
│   ├── Watch the reader
│   └── Set up the next reader
│
├── Fix a problem
│   ├── Start here
│   ├── The reader does not answer
│   ├── Commands or events do not arrive
│   ├── Tag reads are missing or poor
│   ├── BLE data does not arrive
│   └── A panel, application, or update failed
│
└── API Reference
    └── One page per contract group
```

## What moved, so it is not written twice

| Earlier draft | Home now |
|---|---|
| Reader Gateway and Radio Control as a section | One explanation on "How the pieces work together." Heartbeat details stay on "Check reader health" |
| A REST quick start beside the MQTT quick start | A step inside "Read your first tag" |
| A page per operating mode | "How an operating mode shapes tag data" and "Set the operating mode." Portal and conveyor sequences are workflows |
| MQTT communication, destinations, and batching as three chapters | One concept, one setup task |
| Build an application, plus workflows that repeat it | Tasks in the guide. Workflows only link to them |
| Route RFID and BLE in setup, in BLE, and in a tutorial | The workflow. BLE and Connections link to it |
| Fleet operations as a management chapter | "Set up the next reader," limited to repeating one reader's tasks |

## Writing order

Write "Learn the reader" first. Every later page links there instead of restating the model.

Then "Read your first tag" and the setup task it depends on, "Configure an MQTT broker."

Then Read tags, through "Start and stop reading," and "Receive tag data events."

Then Monitor, Maintain, and the advanced pages in sections 3, 4, 6, 9, and 10.

Then workflows and troubleshooting, after the pages they link to exist.

Fill the API Reference after the guide page titles stop changing, so each operation can link to a stable task.
