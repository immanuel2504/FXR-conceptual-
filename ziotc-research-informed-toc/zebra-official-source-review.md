# Zebra official ZIoTC source review

Source reviewed: [Zebra IoT Connector documentation](https://zebradevs.github.io/rfid-ziotc-docs/)

Review date: 13 October 2026

## Scope warning

The linked site explicitly lists FX7500, FX9600, and ATR7000 as supported
readers. The API contracts in this workspace target FXR60 and FXR90. The site is
therefore authoritative for the established ZIoTC architecture and legacy-reader
workflows, but firmware-specific fields, limits, UI locations, and behavior must
be checked against the current FXR contracts, release notes, or engineering.

## Product details confirmed by the source

### Product model

- ZIoTC is a built-in reader feature, not a cloud-only service.
- It uses MQTT, REST, HTTP POST, and JSON to manage and control readers and to
  deliver tag data and events.
- The documented reader software components are Reader Gateway, Radio Control,
  Reader Manager, and Reader Webserver.

Sources:

- [What is IoT Connector and System Overview](https://zebradevs.github.io/rfid-ziotc-docs/introduction/intro/index.html)
- [Supported readers and related documents](https://zebradevs.github.io/rfid-ziotc-docs/about/index.html)

### Logical interfaces

The source separates the connector into four interface roles:

1. Management — synchronous configuration and device-management commands.
2. Control — synchronous radio configuration and start/stop commands.
3. Management Events — asynchronous heartbeat, GPIO, error, warning, and health
   events.
4. Data — RFID tag events, with two data endpoints documented for the legacy
   reader family.

Management and Control can use MQTT or local REST. Management Events can use
MQTT or HTTP POST. Data can be mapped to a supported endpoint.

### Deployment models

The source defines three deployment models:

- Pure cloud — Management, Control, and Data use a cloud provider.
- Local — MQTT or HTTP(S) data delivery, with Management and Control through
  local REST or MQTT.
- Hybrid — interface roles can be assigned to different local and remote
  destinations.

Source: [Deployment Modes](https://zebradevs.github.io/rfid-ziotc-docs/introduction/deployment_modes/index.html)

### Configuration workflow

The documented web-console workflow is:

1. Add an endpoint configuration.
2. Assign interfaces to endpoints.
3. Start or connect the IoT Connector service.
4. Verify interface Connection Status and Connection Error.

The legacy web-console path is **Communication > Zebra IoT Connector >
Configuration**. Supported endpoint choices shown in that documentation include
MQTT, HTTP, AWS IoT Core, Azure IoT Hub, TCP, WebSocket, and keyboard/HID.

Source: [Quick Zebra IoT Connector Setup](https://zebradevs.github.io/rfid-ziotc-docs/setupziotc/index.html)

### MQTT

- The legacy generic-broker guide states MQTT 3.1.1.
- Its example requires FX7500/FX9600 firmware 3.10.X or later and ATR7000
  firmware 3.17.X or later.
- The web workflow exposes server, port, protocol, client ID, clean session,
  basic authentication, keepalive, topics, and certificates.
- Management, Control, Health/Management Events, and Tag Data have distinct topic
  assignments.

Source: [Connect Fixed Readers to an MQTT Broker](https://zebradevs.github.io/rfid-ziotc-docs/other_cloud_support/MQTT/index.html)

These firmware requirements and the MQTT-version statement are not automatically
valid for FXR60 or FXR90.

### Operating modes and tag access

The legacy site documents Simple, Inventory, Portal, Conveyer, Directionality,
and Custom. The current FXR contracts in this workspace use SIMPLE, INVENTORY,
PORTAL, CONVEYOR, and CUSTOM; Directionality is not present in those contracts.

Legacy firmware 3.24.43 adds documented Read, Write, Lock, and Kill access
operations, with up to 64 access operations in a sequence. Current FXR limits
must be verified independently.

Sources:

- [Operating Modes](https://zebradevs.github.io/rfid-ziotc-docs/introduction/operating_modes/index.html)
- [Access Operations](https://zebradevs.github.io/rfid-ziotc-docs/performing_access_operations/index.html)

### Batching, retention, and reconnect behavior

The source documents:

- Batching by maximum payload size and reporting interval.
- Retention by maximum age, maximum event count, and replay throttle.
- A legacy default capacity of 150,000 events.
- Retained events being lost when the reader reboots.
- MQTT disconnect detection based on keepalive.
- Possible duplicate data after reconnect, identifiable by event number.
- A recommendation to size replay throttle using reader count, read rate, and
  server-processing capacity.

Sources:

- [Tag Data Batching](https://zebradevs.github.io/rfid-ziotc-docs/batching_and_retention/tag_data/batching.html)
- [Tag Data Retention](https://zebradevs.github.io/rfid-ziotc-docs/batching_and_retention/tag_data/retention.html)

The current FXR contracts contain retention and batching fields, but persistence,
duplicate, discard, and default-value behavior must be validated per FXR release.

### Certificates

The legacy documentation distinguishes server, client, and application
certificates. It recommends client certificates for ZIoTC outgoing connections
and states that the documented readers accept certificates in PFX format. It
supports browser upload and server-based installation over HTTPS, FTPS, or SCP.

Source: [Certificate Management](https://zebradevs.github.io/rfid-ziotc-docs/certificate_management/index.html)

Certificate types, formats, and installation methods require separate FXR60 and
FXR90 validation.

### Embedded Data Analytics applications

- Readers can host embedded applications that filter or analyze data and perform
  actions before data leaves the reader.
- Applications can be written in Python or Node.js.
- A locally running application can call management and control REST APIs over
  `127.0.0.1` according to the legacy guide.
- Applications are packaged as Debian `.deb` packages.
- They can be installed through the reader administrative console or managed by
  ZIoTC commands for list, install, uninstall, start, stop, and autostart.

Sources:

- [Data Analytics application overview](https://zebradevs.github.io/rfid-ziotc-docs/user_apps/index.html)
- [Python DA applications](https://zebradevs.github.io/rfid-ziotc-docs/user_apps/python/index.html)
- [Node.js DA applications](https://zebradevs.github.io/rfid-ziotc-docs/user_apps/nodejs/index.html)
- [Packaging and Deployment](https://zebradevs.github.io/rfid-ziotc-docs/user_apps/packaging_and_deployment.html)

### Migration

The official site contains migration guidance for FxConnect, 123RFID Desktop,
and RFID API3. Migration material should remain outside the normal first-use path
but be indexed from the reference and release/migration area.

## Changes made to the proposed TOC

- Added an explicit source hierarchy and reader-family compatibility warning.
- Made local, pure-cloud, and hybrid deployment models explicit.
- Added reader software components and the web-console workflow.
- Expanded MQTT, certificate, mTLS, batching, and retention topics.
- Added reconnect replay and duplicate-event handling.
- Added embedded Python/Node.js Data Analytics application topics.
- Added migration guides.
- Added validation questions for legacy-to-FXR behavior differences.
