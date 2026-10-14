# FXR Fixed Reader

Each subject has one home. Getting Started is the first successful path. The later sections are where you look a setting up. Tutorials are sequences across those pages, not a second copy of them. Command fields, response codes, and schemas stay in the MQTT and REST contracts.

Wi-Fi is part of Network. BLE is a scan, not a network setting. Reader Gateway and Radio Control are heartbeat areas, so they sit on the Heartbeat page.

## Overview

### What is an FXR reader?

- A fixed reader stays in one place and reports what it reads
- What the IoT Connector lets you do
- What it does not do
- MQTT and local REST are two ways to reach the same reader
- Where to go next

### Supported readers

- What the fixed readers share
- FXR60 integrated antennas
- Display is FXR60
- Stack light is FXR60 Premium
- Cellular and GPS are FXR90
- Check the model and capabilities

### System architecture

- Who takes part
- Where state lives
- Where commands and events go
- Commands, responses, and events
- Reads follow an operating mode
- What is replaced and what is updated
- Local REST does not carry the event streams

## Getting Started

### Connect the reader

- Power, antennas, and tags
- Confirm the reader has an address
- Identify the reader
- Log in with local REST when you are on the LAN

### Configure the network

- Do this once, so the later steps can reach the reader
- Read the current interfaces
- Keep the path you are using
- Set the address for this session
- Confirm the reader still answers
- Change Wi-Fi or cellular from the Network pages

### Start reading tags

- Commands and tag data both use MQTT
- Confirm a data destination
- Subscribe to the data topic
- Set a SIMPLE mode
- Start RFID inventory
- Read the first tag event
- Stop
- What just happened

## Reader Configuration

### Region, time, and identity

- Read the supported regions
- Set the regulatory region
- Set the time zone and NTP server
- Set the hostname
- Change a local password
- Confirm the baseline

### Network

- Use this page to change Ethernet, Wi-Fi, or read points after the reader is online
- Read the current interfaces
- Ethernet
- Wi-Fi
- Read points and location
- If the reader becomes unreachable

### Cellular

- This interface is on the FXR90
- Confirm wan0
- Read eSIM profiles
- Add or select a profile
- Enable the profile
- Read the last GPS position
- If cellular does not connect

### Certificates

- Install a device certificate
- Install a CA certificate
- List installed certificates
- Reference a certificate by name
- Enable peer and host verification
- Confirm the connection
- Refresh, rotate, or delete a certificate
- If TLS fails

### Command and event connections

- Read the current configuration
- Data events
- Control command-response
- Management events
- Management command-response
- Batching and retention
- Confirm a connection
- Clear a connection safely

### GPIO

- Read GPI and GPO state
- Set a GPO
- Configure defaults and triggered actions
- Control the application LED
- Confirm the physical result

### Display and stack light

- Confirm the model and variant
- Inspect attached devices
- Configure the display
- Read the stack-light state
- Set color, flash, brightness, and duration

### User applications

- List installed applications
- Install an application
- Start, stop, and autostart
- Exchange requests and data
- Uninstall an application

### Firmware

- Read the current and available versions
- Prepare the download
- Start the update
- Follow download and per-component progress
- Confirm the new version
- Restart the reader
- Revert to the previous OS

## RFID Operations

### Operating modes

- SIMPLE
- INVENTORY
- PORTAL
- CONVEYOR
- CUSTOM
- The event type is the mode
- Send the whole mode
- Antenna stop conditions
- Radio start and stop conditions
- The PORTAL GPI trigger
- Read the mode back

### Antennas and RF

- Discover read points
- Select external or integrated antennas
- Integrated antenna IDs on the FXR60
- Set transmit power
- Apply cable-loss compensation
- Choose an environment profile
- Enable or disable rxSawFilter
- Configure Gen2 query settings
- Test the change

### Inventory

- Check current activity
- An empty body starts RFID only
- Stop the intended scan
- Stop before you reconfigure or restart
- RFID can resume after a reboot
- BLE never auto-resumes

### Reported tags

- Choose a prefix filter or Gen2 select
- Respect the mutual exclusions
- Configure the report filter and the RSSI filter
- Choose tag metadata
- Confirm the published fields

### Tag operations

- Choose the memory bank
- Configure read, write, lock, kill, or access
- Supply access credentials
- Read accessResults
- Remove the operations

### Gen2X

- Check reader capabilities
- Choose one feature
- Configure FastID, TagFocus, TagProtect, or TagQuieting
- Read back the saved feature
- Apply it at start
- Confirm it is active

### BLE scanning

- Check the firmware build
- Enable protocols and filters
- Configure the data destination
- Start the scan
- Read BLE_DATA events
- Stop the scan

## APIs

### REST API

- Local REST is always enabled
- Log in with basic authentication
- Send the bearer token on later calls
- Call a local endpoint
- What a REST response does not include
- Field details stay in the REST contract

### MQTT API

- Publish and subscribe on the configured topics
- Build the command envelope
- Give every command a unique command_id
- Subscribe before you depend on a reply
- Quality of service, sessions, and reconnect
- Field details stay in the MQTT contract

## Events

### Turn event reporting on

- Configure the destination first
- Choose the heartbeat fields and interval
- Enable GPI, GPO, and user-app events
- Configure errors and warnings
- Firmware progress and notifications publish on their own
- Confirm publication

### Tag data events

- Where tag data is published
- Events arrive only while inventory is active
- The event type is the mode
- Required fields, optional metadata, and access results
- When no tag data arrives

### BLE data events

- Recognize BLE_DATA
- Dispatch by beacon type
- Parse the common advertisement fields
- Parse the protocol-specific object
- Read the top-level event number

### Management events

- The common envelope
- Errors and warnings
- GPI and GPO
- User applications
- Firmware progress and notifications
- An event is not the reply to a command

### Heartbeat

- Radio Control
- Reader Gateway
- System
- User applications
- Power, temperature, and resources
- What a missed heartbeat means

## Tutorials

### Configure a reader

- Identify the reader on Supported readers
- Set region, time, and identity
- Set the network
- Secure the connection when the broker requires it
- Configure the command and event connections
- Set the operating mode

### Start inventory

- Read the operating mode
- Set antennas and transmit power
- Start inventory
- Confirm tag events are arriving
- Stop inventory

### Receive tag data

- Subscribe to the data topic before you start
- Match the event type to the mode
- Parse required and optional fields
- Store records in batches
- Decide what to do when a report is missing

## Troubleshooting

### Start here

- Start from what you can see
- Read identity, capabilities, and status
- Read logs before you clear them
- Choose network, RFID, the API, or the reader itself
- Count affected readers before you treat it as one unit
- Capture the evidence, then escalate

### Network problems

- The reader has no reachable address
- Wi-Fi association fails
- Ethernet has no link
- Cellular does not connect
- Login fails or a bearer token is rejected
- The reader disappears after a network change

### RFID problems

- No tag data arrives
- Tags are missed or they repeat too often
- Reads come from the wrong antenna
- An antenna is disconnected
- PORTAL does not start
- The wrong mode runs, or a set is rejected
- Effective values differ from configured values
- Access results fail

### API errors

- A command gets no response
- A connection stays down
- One stream works and another does not
- Events stop during a disconnect
- Retained data does not replay

### BLE, peripherals, and firmware

- BLE does not start
- No BLE_DATA events arrive
- A GPI trigger is not seen
- A GPO or LED action does not run
- The display does not start, or the stack light is unsupported
- A user application does not start or does not survive reboot
- A firmware update does not finish
