# Zebra FXR60 / FXR90 IoT Connector guides — New TOC 2

This table of contents is organized around customer outcomes. The guides explain how to deploy, integrate, operate, and troubleshoot a fixed reader. Command fields, response codes, schemas, and complete payload examples remain in the MQTT and REST API contracts.

## Overview

### About the IoT Connector

- What you can build
- Supported readers
- RFID, BLE, and reader management
- What the API contracts contain
- Where to begin

### Choose the right reader

- What the FXR60 and FXR90 share
- FXR60 integrated antennas
- FXR60 display and stack light
- FXR90 cellular connectivity and GPS
- Check capabilities instead of assuming

### Choose MQTT or local REST

- Use MQTT for commands and event streams
- Use REST for direct local control
- Understand the authentication difference
- Know when an application needs both

### Prepare your environment

- Reader, antennas, and tags
- Network and MQTT broker
- Local REST credentials
- Certificates and trust material
- Tools for testing

## Get started

### Quick start: Read your first RFID tag over MQTT

- Confirm the reader's MQTT connections
- Subscribe to the response and data topics
- Identify the reader
- Configure SIMPLE mode
- Start inventory
- Read the first tag event
- Stop inventory

### Quick start: Check and control a reader over REST

- Log in to the reader
- Save the bearer token
- Read identity and status
- Read the current operating mode
- Start and stop inventory
- Understand why tag events are not returned by REST

## Learn the essentials

### How the reader, broker, and application work together

- Reader responsibilities
- Broker responsibilities
- Application responsibilities
- State stored on the reader
- Configuration compared with runtime control

### Understand operating modes

- SIMPLE for basic unique-tag reads
- INVENTORY for periodic per-antenna reports
- PORTAL for GPI-triggered cycles
- CONVEYOR for conveyor workflows
- CUSTOM for advanced radio control
- Why changing mode replaces the complete mode

### Understand commands, responses, and events

- REST request and response
- MQTT command and response
- Match MQTT responses with command_id
- Events are not command replies
- Tag, BLE, and management event families

### Understand connections and event streams

- Data-event connections
- Control command-response connections
- Management-event connections
- Management command-response connections
- Configurable topics and destinations
- Route RFID and BLE independently

### Understand configuration ownership

- Operating-mode configuration
- Reader and data-plane configuration
- Cloud endpoint configuration
- Management-event configuration
- Read before you replace configuration

### Understand delivery and recovery

- MQTT QoS
- Clean sessions and keep-alive
- Reconnect backoff
- Batching and offline retention
- Replay limits and throttling
- RFID and BLE behavior after reboot

### Understand security

- REST login and bearer tokens
- TLS for endpoint connections
- Peer and hostname verification
- Device and CA certificates
- Certificate names and rotation

### Understand published data

- RFID tag-event envelope
- Fields determined by operating mode
- Optional metadata and access results
- BLE_DATA envelope and beacon formats
- Management-event envelope
- Event numbers and timestamps

## Set up the reader

### Identify the reader and check its capabilities

- Read the model and serial number
- Check component versions
- Discover antennas and read points
- Discover GPIO and endpoint support
- Check supported Gen2X features
- Read current status

### Set the reader's region, time, and identity

- Choose a supported region and standard
- Set the regulatory region
- Configure the time zone and NTP server
- Set the hostname
- Change a local account password
- Verify the baseline

### Connect the reader to the network

- Read the current interfaces
- Configure Ethernet or Wi-Fi
- Scan for Wi-Fi networks
- Configure the access-point interface
- Connect an FXR90 through cellular and eSIM
- Read FXR90 GPS coordinates
- Recover after an incorrect network change

### Install certificates and enable TLS

- Install device and CA certificates
- Reference an installed certificate
- Enable peer and hostname verification
- Confirm the secure connection
- Refresh or rotate a certificate
- Delete an obsolete certificate

### Configure command and event destinations

- Read the current configuration
- Choose a connection type
- Configure command-response connections
- Configure RFID and BLE data connections
- Configure the management-event connection
- Set batching and offline retention
- Confirm each connection

### Configure antennas and RF behavior

- Discover available antenna ports
- Use FXR60 integrated antenna IDs
- Set transmit power
- Match settings to the antenna list
- Choose an RF environment
- Configure cable-loss compensation
- Enable rxSawFilter when needed

### Configure an RFID operating mode

- Read configured or effective mode values
- Stop active inventory
- Choose the operating mode
- Configure its trigger and stop behavior
- Send the complete mode
- Read it back
- Resolve invalid field combinations

### Select tags and shape tag reports

- Choose a prefix filter or Gen2 Select
- Configure query and selection behavior
- Filter reports by time, count, or RSSI
- Choose the reported metadata
- Respect mode and access restrictions
- Confirm the published fields

## Run reader workflows

### Start and stop RFID and BLE

- Check current activity
- Understand the RFID-only default
- Start RFID, BLE, or both
- Target named data connections
- Stop only the intended scan type
- Control RFID restart behavior
- Remember that BLE never auto-resumes

### Build a portal workflow

- Configure PORTAL mode
- Choose the GPI start signal
- Set the quiet-time stop interval
- Verify the physical input
- Start the reader
- Confirm portal tag events

### Build a conveyor workflow

- Configure CONVEYOR mode
- Choose antennas and power
- Configure cycle and stop behavior
- Start the reader
- Validate antenna assignment and reports

### Read and modify tag memory

- Choose the memory bank
- Configure read, write, lock, kill, or access operations
- Supply the required credentials
- Start inventory
- Read accessResults
- Remove access operations when finished

### Use Impinj Gen2X features

- Check reader and tag support
- Choose one Gen2X feature
- Configure FastID, TagFocus, TagProtect, or TagQuieting
- Verify the saved feature
- Apply it when inventory starts
- Confirm that it is active

### Scan for BLE devices and beacons

- Check the required firmware build
- Enable BLE scanning
- Choose beacon protocols
- Add protocol, RSSI, and service filters
- Start scanning
- Read BLE_DATA events
- Stop scanning

### Control GPIO and reader indicators

- Read GPI and GPO state
- Set a GPO
- Configure default GPIO and LED behavior
- Configure triggered actions
- Control the application LED
- Enable GPI and GPO events

### Use the FXR60 display and stack light

- Confirm the model and variant
- Inspect attached devices
- Configure the display
- Handle display connection notifications
- Read and set the stack light
- Handle unsupported hardware

### Install and run user applications

- List installed applications
- Install an application
- Start and stop it
- Configure autostart
- Exchange requests and data
- Monitor application status and events
- Uninstall it

### Update, restart, or revert the reader

- Check current and available versions
- Prepare the update source and trust settings
- Start the update
- Follow firmware progress
- Confirm the installed version
- Restart the reader
- Revert to the previous OS

## Build an application

### Plan the integration

- Choose MQTT, REST, or both
- Identify the required event streams
- Choose connection types and topics
- Separate setup from runtime control
- Account for model and firmware differences

### Call the local REST API

- Log in with Basic authentication
- Store and send the bearer token
- Choose the method and endpoint
- Send the request body
- Interpret the HTTP response
- Log in again after authentication fails

### Send commands over MQTT

- Connect to the configured broker
- Subscribe before publishing
- Build the command envelope
- Assign a unique command_id
- Match the response to the request
- Handle unsuccessful responses

### Process RFID tag events

- Subscribe to the intended data connection
- Dispatch by operating mode
- Parse required and optional fields
- Parse tag-access results
- Associate reads with antennas
- Process data in batches

### Process BLE and management events

- Distinguish BLE from management events
- Dispatch by event type
- Parse beacon-specific data
- Route errors, warnings, and GPIO events
- Preserve event numbers and timestamps
- Keep events separate from command responses

### Make the application resilient

- Detect a lost connection
- Reconnect with backoff
- Restore subscriptions
- Recheck reader activity
- Handle retained data replay
- Prevent processing overload during recovery

### Tune and test the integration

- Filter before publishing
- Tune reporting intervals and payload size
- Limit offline retention and replay rate
- Watch dropped and queued message counts
- Test each configured event shape
- Test authentication and connection failures
- Test against a reader

## Operate readers in production

### Configure health and management reporting

- Configure the management-event destination
- Choose heartbeat sections and fields
- Set the heartbeat interval
- Enable GPIO and user-application events
- Configure errors and warnings
- Confirm publication

### Monitor reader health and activity

- Check reachability and uptime
- Watch CPU, RAM, storage, and temperature
- Check radio and antenna state
- Check RFID and BLE activity
- Check power source and negotiation
- Monitor user applications and peripherals

### Monitor connectivity and data delivery

- Watch interface connection state
- Compare REST status with heartbeats
- Watch sent, retained, dropped, and queued counts
- Detect reconnects and delivery gaps
- Confirm that event streams reach their consumers

### Respond to errors, warnings, and notifications

- Identify the event type and component
- Read the condition details
- Compare the event with heartbeat counters
- Check current status
- Preserve evidence
- Confirm that the condition clears

### Provision a fleet

- Identify every reader
- Branch by model and capabilities
- Apply the baseline configuration
- Configure connections and operating mode
- Install certificates and applications
- Verify commands and event streams

### Keep fleet configuration consistent

- Store complete desired configurations
- Compare desired and effective state
- Detect drift by configuration domain
- Remediate one domain at a time
- Account for regional and model differences

### Roll out changes safely

- Choose a representative reader
- Apply and verify the change
- Expand in stages
- Watch errors and delivery health
- Stop or revert the rollout when verification fails

## Troubleshoot and recover

### Start troubleshooting here

- Begin with the visible symptom
- Identify the affected interface or event stream
- Compare status with heartbeats
- Read the effective configuration
- Preserve logs before clearing them
- Choose the matching recovery path

### Reader or local REST is unreachable

- Reader does not answer after startup or reboot
- Ethernet, Wi-Fi, or cellular is unavailable
- Reader disappeared after a network change
- REST login fails
- Bearer authentication fails
- Confirm identity after reconnecting

### MQTT commands or events do not arrive

- Command receives no response
- One connection works while another fails
- Endpoint remains disconnected
- Events stop during a disconnect
- Retained data does not replay
- Messages are dropped or queued

### RFID inventory produces no or poor tag reads

- Inventory is not active
- Wrong operating mode is configured
- Tag events use an unexpected shape
- Tags are missed or repeated
- Reads come from the wrong antenna
- PORTAL does not start
- Tag-access operations fail

### BLE scanning produces no data

- Firmware does not support BLE scanning
- BLE is disabled or not started
- No BLE_DATA events arrive
- Beacon protocol is disabled
- Filters remove expected devices
- RFID works but BLE does not

### GPIO, indicators, or FXR60 peripherals do not respond

- GPI transition is not detected
- GPO does not change
- Triggered LED action does not run
- FXR60 display does not start
- Stack light is unavailable
- Check capabilities and current state

### A user application does not run correctly

- Installation fails
- Application does not start
- Autostart does not survive reboot
- Requests receive no response
- Events or heartbeat data are missing

### A firmware update does not finish

- Download does not start
- Progress stops
- A component update fails
- Reader does not return after reboot
- New version is not active
- Decide whether to revert

### Collect diagnostic evidence

- Capture reader identity and versions
- Capture status and recent heartbeats
- Choose the relevant logging level
- Enable radio-packet capture when needed
- Export logs before clearing them
- Preserve the failing configuration and exchange

### Recovery playbooks

- Stop unexpected reading
- Restore a lost command or event connection
- Recover after a network change
- Restore a known-good operating mode
- Recover or revert a failed firmware update
- Re-establish monitoring

### Scope and escalate a fleet incident

- Count affected readers
- Group by site, model, version, and configuration
- Identify the failing interface or stream
- Compare the last change
- Decide whether to halt a rollout
- Package evidence and open the support case
