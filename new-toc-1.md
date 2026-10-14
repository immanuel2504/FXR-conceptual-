# Fixed Reader IoT Connector Guides — New TOC 1

The sections and pages below define the sidebar reading path. Bullets under a page are that page's right-hand rail. The API contracts remain the source for command fields, response codes, and schemas.

## Get Oriented

### Scope

### How to Use These Guides

- Page Types and Content Badges
- Reading Paths
- Learn by Doing
- Where to Find API Details

### What the IoT Connector Is

- What It Lets You Do
- What It Does Not Do
- MQTT and Local REST
- Which Readers Run It
- Where to Go Next

### Meet the FXR60 and FXR90

- What Both Readers Share
- FXR60 Integrated Antennas
- FXR60 Display and Stack Light
- FXR90 Cellular and GPS
- Check the Model and Capabilities

### What You Need

- Reader and Antennas
- Network
- MQTT Broker or Local REST Access
- Credentials and Certificates
- RFID Tags or BLE Devices
- Before You Begin

## Quick Start

### Quick Start: Read Your First Tag over MQTT

- Confirm the Data and Command-Response Connections
- Subscribe to the Response and Data Topics
- Identify the Reader
- Configure SIMPLE Mode
- Start RFID Inventory
- Read the First Tag Event
- Stop Inventory
- What Just Happened

## Understand the IoT Connector

### How the IoT Connector Works

- Who Takes Part
- Where State Lives
- MQTT and Local REST
- Configuration and Runtime Control
- The Shape of an Exchange

### Choose MQTT or Local REST

- Use MQTT for Commands and Published Events
- Use Local REST for Direct Request and Response
- REST Login and Bearer Authentication
- REST Does Not Carry Event Streams
- When an Integration Uses Both

### How Operating Modes Read Tags

- The Mode Controls the Inventory Workflow
- SIMPLE
- INVENTORY
- PORTAL
- CONVEYOR
- CUSTOM
- Mode-Specific Rules
- Mode Is Replaced as a Whole

### Where Commands and Events Go

- Data Events
- Control Command-Response
- Management Events
- Management Command-Response
- Configurable Topics and Destinations
- One Connection or Several
- Route RFID and BLE Separately

### Commands, Responses, and Events

- REST Request and Response
- MQTT Command and Response
- Correlate Responses with command_id
- Events Are Not Command Replies
- Tag Data, BLE Data, and Management Events

### Delivery, Retention, and Reconnects

- MQTT Quality of Service
- Clean Sessions and Keep-Alive
- Reconnect with Backoff
- Batch Before Publishing
- Retain Events While Offline
- Limit and Throttle Replay
- What Resumes After Reboot

### The Security Model

- REST Credentials and Bearer Tokens
- Secure Endpoint Connections
- Verify the Peer and Host
- Device Certificates
- CA Certificates
- Certificates Referred to by Name

### The Tag Data Stream

- Where Tag Data Is Published
- The Event Type Is the Operating Mode
- Fields Every Tag Event Contains
- Mode-Specific Fields
- Optional Metadata
- Access Results
- Report and RSSI Filters

### The BLE Data Stream

- Configure BLE Before Scanning
- Supported Beacon Formats
- The BLE_DATA Envelope
- Where eventNum Appears
- Route BLE and RFID Independently
- BLE Does Not Autostart or Auto-Resume

### The Management Event Stream

- The Common Event Envelope
- Heartbeats
- GPI and GPO Events
- Errors and Warnings
- User-Application Events
- Automatic Firmware and Display Notifications

### The Configuration Model

- Operating Mode Is a Complete Replacement
- GPIO-LED Is a Complete Replacement
- Configure Data and Management-Event Behavior
- Configure Cloud Endpoint Connections
- Read Before You Write
- What a Reboot Changes

## Configure and Use One Reader

### Inspect Reader Identity, Capabilities, and Status

- Read the Model and Serial Number
- Discover Antennas, GPIO, Endpoints, and Gen2X
- Check Health and Activity
- Check Network Interfaces and Read Points

### Prepare the Reader Baseline

- Read the Supported Regions and Standards
- Set the Regulatory Region
- Set the Time Zone and NTP Server
- Set the Hostname
- Change a Local Password
- Confirm the Baseline

### Configure Reader Networking

- Before You Begin
- Read the Current Interfaces
- Scan for Wi-Fi Networks
- Configure One Interface
- Respect the Wi-Fi and Access-Point Exclusion
- Confirm the Change
- If the Reader Becomes Unreachable

### Connect an FXR90 over Cellular

- Confirm the Model and wan0
- Read the eSIM Profiles
- Add or Select a Profile
- Enable the Profile
- Read the Last GPS Position
- If Cellular Does Not Connect

### Install Certificates and Secure Connections

- Before You Begin
- Install a Device Certificate
- Install a CA Certificate
- Reference Installed Certificates from an Endpoint
- Enable Peer and Host Verification
- Confirm the Secure Connection
- Refresh, Rotate, or Delete a Certificate
- If TLS Fails

### Configure Command and Event Connections

- Before You Begin
- Read the Current Configuration
- Choose the Plane and Connection Type
- Configure Data Events
- Configure Control Command-Response
- Configure Management Events
- Configure Management Command-Response
- Configure Batching and Offline Retention
- Confirm Each Connection
- Clear a Connection Safely

### Configure an Operating Mode

- Before You Begin
- Read Configured or Effective Values
- Choose the Mode
- Configure Mode-Specific Settings
- Configure Trigger and Stop Conditions
- Stop Active Reading
- Send the Complete Mode
- Read It Back
- Handle Invalid Combinations

### Configure Antennas and RF Behavior

- Discover Read Points
- Select External or Integrated Antennas
- Use the FXR60 Integrated Antenna IDs
- Set Transmit Power
- Match Per-Antenna Arrays
- Choose the RF Environment
- Configure Cable-Loss Compensation
- Configure rxSawFilter Preselection
- Test and Confirm the Result

### Select, Filter, and Shape Tag Reports

- Choose a Prefix Filter or Gen2 Select
- Configure Query and Selects
- Respect Selection Conflicts
- Configure the Report Filter
- Configure the RSSI Filter
- Choose Tag Metadata
- Respect Mode and Access Restrictions
- Confirm the Published Fields

### Read and Write Tag Memory

- Choose the Memory Bank
- Configure Read, Write, Lock, Kill, or Access Operations
- Supply Access Credentials
- Start Inventory
- Read accessResults
- Remove the Operations When Finished

### Configure Impinj Gen2X

- Check Reader Capabilities
- Choose One Feature
- Configure FastID, TagFocus, TagProtect, or TagQuieting
- Read Back the Saved Feature
- Apply It When Inventory Starts
- Confirm It Is Active
- Remove or Replace the Saved Feature

### Start and Stop RFID and BLE

- Before You Begin
- Check Current Activity
- Understand the RFID-Only Default
- Start RFID, BLE, or Both
- Target Named Data Connections
- Apply Gen2X to RFID
- Stop the Intended Scan Type
- Choose RFID Reboot Persistence
- Remember That BLE Never Auto-Resumes

### Scan for BLE Devices and Beacons

- Check the Firmware Build
- Read the BLE Configuration
- Enable Beacon Protocols
- Add Protocol, RSSI, and Service Filters
- Confirm the Data Destination
- Start Scanning
- Read BLE_DATA Events
- Stop the Scan

### Automate GPIO and Reader Indicators

- Read GPI and GPO State
- Set a GPO
- Configure GPIO and LED Defaults
- Configure Triggered Actions
- Control the Application LED
- Enable GPI and GPO Events
- Confirm the Physical Result

### Configure the FXR60 Display and Stack Light

- Confirm the Model and Variant
- Inspect Attached Devices
- Configure the Display
- Watch Display Notifications
- Read the Stack-Light State
- Set Color, Flash, Brightness, and Duration
- Handle Unsupported Hardware

### Manage User Applications

- Before You Begin
- List Installed Applications
- Install an Application
- Start and Stop It
- Configure Autostart
- Exchange Requests and Data
- Monitor Status and Events
- Uninstall It

### Update Firmware, Restart, and Revert

- Before You Begin
- Read Current and Available Versions
- Prepare the Download and Trust Settings
- Start the Update
- Follow Firmware Progress
- Confirm the New Version
- Restart the Reader
- Revert to the Previous OS
- Recover After Failure

## Build Your Integration

### Plan Your Integration

- Choose MQTT, Local REST, or Both
- Choose Endpoint Types
- Separate Configuration from Runtime Control
- Decide Which Event Streams the Application Needs
- Account for Reader Model and Firmware Differences

### Call the Local REST API

- Log In with Basic Authentication
- Store the Bearer Token
- Choose the Method and Path
- Send the Request Body
- Read the HTTP Status and Response Body
- Log In Again When Authentication Fails

### Connect and Send Commands over MQTT

- Match the Configured Host, Port, and Topics
- Match the Configured QoS
- Subscribe Before Publishing
- Build the Command Envelope
- Give Every Command a Unique command_id
- Match the Response to the Pending Command
- Read the Response and Failure Details

### Handle Management Events

- Subscribe to the Management-Event Topic
- Recognize the Common Envelope
- Dispatch by type and component
- Preserve eventNum and timestamp
- Keep Events Separate from Command Responses

### Consume Tag Data

- Subscribe to the Intended Data Connection
- Dispatch by Operating Mode
- Parse Required and Optional Fields
- Parse accessResults
- Associate Reads with Antennas
- Store and Process Batches

### Consume BLE Data

- Recognize BLE_DATA
- Dispatch by beaconType
- Parse Common Advertisement Fields
- Parse Protocol-Specific Objects
- Handle the Top-Level eventNum

### Recover from Disconnects

- Configure Clean Sessions and Keep-Alive
- Configure Reconnect Backoff
- Retain Data While Offline
- Replay at a Controlled Rate
- Recheck Reader Activity After Reconnect

### Manage Data Throughput

- Tune Reporting Intervals and Payload Size
- Filter Before Publishing
- Route Streams Across Connections
- Limit Offline Retention
- Watch Retained, Dropped, and Queued Counts

### Test Your Integration

- Validate Requests Against the Contracts
- Test Every Configured Mode Shape
- Test RFID and BLE Independently
- Test Management Events
- Test Authentication and Connection Failures
- Test Against a Reader

## Operate and Monitor

### Build a Reader Health View

- Reader Reachability
- Radio and Antenna State
- Endpoint Connections
- CPU, RAM, Storage, Temperature, and Uptime
- RFID and BLE Activity
- GPIO and User Applications
- Model-Specific Capabilities

### Configure Management Event Reporting

- Configure the Management-Event Destination
- Choose Heartbeat Fields
- Set the Heartbeat Interval
- Enable GPI, GPO, and User-App Events
- Configure Errors and Warnings
- Confirm Publication

### Monitor Connectivity and Data Delivery

- Watch Interface Connection Status
- Compare REST Status with Heartbeats
- Watch Message Counts
- Watch Retained, Dropped, and Queued Data
- Detect Reconnects and Delivery Gaps

### Monitor Reader and Scan Activity

- Read Health on Demand
- Follow System and Radio Heartbeats
- Check Antenna State
- Check RFID Activity
- Check BLE Scan State
- Check Power Source and Negotiation

### Monitor User Applications and Peripherals

- Watch Application Running State and Resource Use
- Compare Runtime State with Autostart Configuration
- Handle User-App Events
- Watch GPIO Changes
- Handle FXR60 Display Notifications

### Respond to Errors and Warnings

- Recognize the Event Type and Component
- Read the Condition Details
- Compare with Heartbeat Counters
- Capture the Relevant Logs
- Confirm That the Condition Clears

## Scale to a Fleet

### What Changes When You Scale

- Every Reader Has Its Own State
- Models and Capabilities Differ
- Regions and Networks Stay Per Reader
- Endpoint Configuration Stays Per Reader
- Mixed Fleets Need Capability Branching
- No Fleet Controller Is Defined

### Provision Readers

- Identify Each Reader
- Apply the Baseline
- Configure Connections
- Apply the Complete Mode
- Install Certificates and Applications
- Verify Commands and Event Streams

### Keep Configuration Consistent

- Store Complete Mode Documents
- Store Configuration by Plane
- Read Back Effective State
- Compare Capabilities Before Applying
- Detect Drift
- Remediate One Domain at a Time

### Roll Out Changes in Stages

- Choose a Representative Reader
- Apply the Change
- Verify Commands and Event Streams
- Expand the Rollout
- Stop on New Errors or Delivery Loss

## Diagnose and Recover

### Diagnose and Recover

- Start from What You Can See
- Identify the Failing Interface or Stream
- Compare Status with Events
- Read the Relevant Configuration
- Capture Logs Before Clearing Them
- Choose a Recovery Path

### Network and Local REST

- Reader Has No Reachable Address
- Wi-Fi Association Fails
- Ethernet Has No Link
- FXR90 Cellular Does Not Connect
- Login Fails
- Bearer Authentication Fails
- Reader Disappears After a Network Change

### MQTT Connectivity and Delivery

- A Command Gets No Response
- One Endpoint Plane Works and Another Does Not
- A Connection Stays Down
- Events Stop During a Disconnect
- Retained Data Does Not Replay
- Data Is Dropped or Queued

### Operating Mode and RFID Read Performance

- Wrong Mode or Fields Are Active
- No Tag Data Arrives
- Tags Are Missed or Repeated
- Reads Come from the Wrong Antenna
- PORTAL Does Not Start
- Tag Access Results Fail
- Start with the Full Effective Mode

### BLE Scanning and Data

- BLE Does Not Start
- No BLE_DATA Events Arrive
- A Beacon Format Is Missing
- Filters Remove Expected Devices
- RFID Works but BLE Does Not
- Check the Firmware Build and Runtime State

### GPIO, Indicators, and FXR60 Peripherals

- A GPI Trigger Is Not Seen
- A GPO Does Not Change
- An LED Action Does Not Run
- The Display Does Not Start
- The Stack Light Is Unsupported
- Start with Capabilities and Current State

### User Applications

- Installation Fails
- An Application Does Not Start
- Autostart Does Not Survive Reboot
- Requests Get No Response
- Events or Heartbeats Are Missing

### Firmware Updates

- Download Does Not Start
- Progress Stops
- A Component Fails
- Reader Does Not Answer After Reboot
- The New Version Is Not Active
- Decide Whether to Revert

### Capture Diagnostic Evidence

- Capture Identity and Versions
- Capture Status and Heartbeats
- Choose the Relevant Log Level
- Enable Radio-Packet Capture When Needed
- Export Logs Before Clearing Them
- Preserve the Failing Configuration and Exchange

### Recovery Playbooks

- Stop Unexpected Reading
- Restore a Lost Data Connection
- Recover After a Network Change
- Rebuild an Operating Mode
- Recover a Failed Firmware Update
- Re-establish Monitoring

### Scope and Escalate an Incident

- Count the Affected Readers
- Group by Model, Site, Version, and Configuration
- Identify the Failing Plane
- Compare the Last Change
- Decide Whether to Halt a Rollout
- Package the Evidence
- Open the Support Case
