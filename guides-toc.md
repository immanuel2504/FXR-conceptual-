# Fixed Reader IoT Connector Guides

The sidebar is the section and page order. The bullets under a page are that page's rail. These guides cover the fixed reader. A heading names FXR60 or FXR90 only where that model differs.

## Get Oriented

### Scope

### How the Documentation Is Organized

### About the Content-Type Badges

### Reading Paths

### Learn by Doing

### What the IoT Connector Is

- What It Lets You Do
- What It Does Not Do
- Which Readers Run It
- Where to Go Next

### Reader Models

- What the Fixed Readers Share
- Display Is FXR60
- Stack Light Is FXR60 Premium
- Cellular and GPS Are FXR90
- Check the Model and Capabilities

### What You Need

- Reader
- Network
- MQTT Broker or Local REST Access
- Credentials
- Tags and Antennas
- Before You Begin

## Quick Start

### Quick Start: Read Your First Tag

- Confirm a Data Destination
- Identify the Reader
- Set a SIMPLE Mode
- Subscribe to the Data Topic
- Start RFID Inventory
- Read the First Tag Event
- Stop
- What Just Happened

## Understand the IoT Connector

### How the IoT Connector Works

- Who Takes Part
- Where State Lives
- MQTT and Local REST
- Endpoint Planes
- The Shape of an Exchange

### Use the Local REST API

- Basic Authentication Is the Login
- Later Calls Use the Bearer Token
- REST Does Not Carry the Event Streams
- Local REST Is Always Enabled

### MQTT Connections, Topics, and Delivery

- Publish and Subscribe
- Configurable Topics
- Quality of Service
- Clean Sessions and Keep-Alive
- Reconnect Delays
- Connection Types

### Endpoint Planes and Event Streams

- Data Events
- Control Command-Response
- Management Events
- Management Command-Response
- One Connection or Several
- Route RFID and BLE Separately

### Commands, Responses, and Events

- REST Request and Response
- MQTT Command and Response
- Correlate with command_id
- Events Are Not Replies
- Tag Data, BLE Data, and Management Events

### Delivery, Batching, Retention, and Reconnects

- Batch Before Publishing
- Retain Events While Offline
- Limit Retention
- Throttle Replay
- Reconnect with Backoff
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
- The Event type Is the Mode
- Required Fields
- Optional Metadata
- Access Results
- Report and RSSI Filters
- When No Tag Data Arrives

### The Configuration Model

- Mode Is Replaced as a Whole
- GPIO-LED Is Replaced as a Whole
- Data-Plane Configuration
- Cloud Endpoint Configuration
- Management-Event Configuration
- Read Before You Write
- What a Reboot Changes

## Configure and Use One Reader

### Inspect Reader Identity, Capabilities, and Status

- Read the Model and Serial Number
- Discover Antennas, GPIO, Endpoints, and Gen2X
- Check Health and Activity
- Check Network Interfaces and Read Points

### Prepare the Reader Baseline

- Read the Supported Regions
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
- Confirm the Change
- If the Reader Becomes Unreachable

### Connect over Cellular

- This Interface Is on the FXR90
- Confirm wan0
- Read eSIM Profiles
- Add or Select a Profile
- Enable the Profile
- Read the Last GPS Position
- If Cellular Does Not Connect

### Install and Manage Certificates

- Before You Begin
- Install a Device Certificate
- Install a CA Certificate
- List Installed Certificates
- Refresh a Certificate
- Delete a Certificate
- Rotate Certificates

### Secure an Endpoint with TLS

- Before You Begin
- Install the Trust Material
- Reference the Installed Certificate
- Enable Peer and Host Verification
- Confirm the Connection
- If TLS Fails

### Configure Reader Endpoint Planes

- Before You Begin
- Read the Current Configuration
- Choose the Plane and Connection Type
- Configure Data Events
- Configure Control Command-Response
- Configure Management Events
- Configure Management Command-Response
- Confirm Each Connection
- Clear a Connection Safely

### Configure Data Batching and Offline Retention

- Choose Global or Per-Connection Settings
- Set the Reporting Interval and Payload Size
- Set Event and Time Limits
- Set Replay Throttling
- Confirm with Gateway Counters

### Configure an Operating Mode

- Before You Begin
- Read Configured or Effective Values
- SIMPLE
- INVENTORY
- PORTAL
- CONVEYOR
- CUSTOM
- Send the Whole Mode
- Read It Back
- Handle Invalid Combinations

### Configure Antennas and Cable-Loss Compensation

- Discover Read Points
- Select External or Integrated Antennas
- Integrated Antenna IDs on the FXR60
- Set Transmit Power
- Match Per-Antenna Arrays
- Read Cable-Loss Settings
- Apply Compensation
- Confirm the Result

### Configure Trigger and Stop Conditions

- Choose Antenna Stop Conditions
- Configure Radio Start Conditions
- Configure Radio Stop Conditions
- Configure the PORTAL GPI Trigger
- Confirm the Cycle

### Start and Stop RFID and BLE

- Before You Begin
- Check Current Activity
- An Empty Body Starts RFID Only
- Start BLE
- Start Both
- Target Data Connections
- Stop the Intended Scan Type
- RFID Can Resume After Reboot
- BLE Never Auto-Resumes

### Tune the RF Environment

- Choose an Environment Profile
- Read the Preselection State
- Enable or Disable rxSawFilter
- Configure Gen2 Query Settings
- Test the Change

### Select Which Tags Enter Inventory

- Choose a Prefix Filter or Gen2 Select
- Configure the Query and Selects
- Respect the Mutual Exclusions
- Set the Selection Delays
- Confirm Which Tags Are Inventoried

### Filter and Shape Reported Tags

- Configure the Report Filter
- Configure the RSSI Filter
- Choose Tag Metadata
- Respect Mode and Access Restrictions
- Confirm the Published Fields

### Read and Write Tag Memory

- Choose the Memory Bank
- Configure Read, Write, Lock, Kill, or Access Operations
- Supply Access Credentials
- Read accessResults
- Remove the Operations

### Configure Impinj Gen2X

- Check Reader Capabilities
- Choose One Feature
- Configure FastID
- Configure TagFocus
- Configure TagProtect
- Configure TagQuieting
- Read Back the Saved Feature
- Apply It at Start
- Confirm It Is Active

### Scan for BLE Devices and Beacons

- Check the Firmware Build
- Read the BLE Configuration
- Enable Protocols
- Add Protocol and RSSI Filters
- Configure the Data Destination
- Start Scanning
- Read BLE_DATA Events
- Stop the Scan

### Automate GPIO and Reader Indicators

- Read GPI and GPO State
- Set a GPO
- Configure GPIO-LED Defaults
- Configure Triggered Actions
- Control the Application LED
- Enable GPI and GPO Events
- Confirm the Physical Result

### Configure the Display and Stack Light

- Confirm the Model and Variant
- Inspect Attached Devices
- Configure the Display
- Watch Display Notifications
- Read the Stack-Light State
- Set Color, Flash, Brightness, and Duration

### Manage User Applications

- Before You Begin
- List Installed Applications
- Install an Application
- Start and Stop It
- Configure Autostart
- Exchange Requests and Data
- Monitor Status and Events
- Uninstall It

### Capture and Manage Reader Logs

- Read the Logging Configuration
- Choose Component Levels
- Enable Radio-Packet Capture
- Download the Relevant Archives
- Preserve Evidence
- Clear Supported Logs

### Update Firmware, Restart, and Revert

- Before You Begin
- Read Current and Available Versions
- Prepare the Download
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
- Decide Which Streams the Application Needs

### Authenticate to Local REST

- Send the Basic-Authenticated Login
- Store the Bearer Token
- Send It on Later Calls
- Replace a Rejected Token

### Connect Your Application to MQTT

- Match the Configured Host and Port
- Use the Configured Topics
- Match the QoS
- Subscribe Before Starting Work
- Observe Connection State

### Send MQTT Commands and Match Responses

- Build the Command Envelope
- Give Every Command a Unique command_id
- Track Pending Commands
- Apply the response Rule
- Read Failure Details
- Remove the Completed Command

### Call Local REST and Handle Responses

- Choose the Method and Path
- Send the Bearer Token
- Send the Request Body
- Read the HTTP Status and Response Body
- Re-Authenticate When Required

### Handle Published Events

- Identify the Stream
- Recognize the Envelope
- Dispatch by type
- Keep Events Separate from Command Responses
- Preserve eventNum and timestamp

### Consume Tag Data

- Dispatch by Operating Mode
- Parse Required Fields
- Accept Optional Fields
- Parse accessResults
- Associate Antennas
- Store Batches

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
- Reconcile Reader Activity

### Manage Data Throughput

- Tune Reporting Intervals
- Tune Payload Size
- Filter Before Publishing
- Route Streams Across Connections
- Limit Offline Retention
- Watch Delivery Counters

### Test Your Integration

- Validate Requests Against the Contracts
- Test Each Mode Shape
- Test RFID and BLE Independently
- Test Management Events
- Test Authentication and Connection Failures
- Test Against a Reader

## Operate and Monitor

### What to Monitor and Why

- Reader Reachability
- Radio Activity
- Endpoint Connections
- Resource Use
- RFID and BLE Activity
- GPIO
- User Applications
- Firmware Work

### Configure Management Event Reporting

- Configure the Destination
- Choose Heartbeat Fields
- Set the Interval
- Enable GPI, GPO, and User-App Events
- Configure Errors and Warnings
- Confirm Publication

### Monitor Reader Connectivity and Delivery

- Watch Interface Connection Status
- Compare REST Status with Heartbeats
- Watch Message Counts
- Watch Retained, Dropped, and Queued Data
- Detect Reconnects

### Monitor Reader Health and Power

- Read Health on Demand
- Follow System and Radio Heartbeats
- Watch CPU, RAM, Storage, Temperature, and Uptime
- Check Power Source and Negotiation

### Monitor RFID and BLE Activity

- Check Radio Connection and Activity
- Check Antenna State
- Check BLE Scan State
- Compare Event Counts
- Confirm the Intended Data Connections

### Monitor User Applications

- Select User-App Heartbeat Fields
- Watch Running State and Resource Use
- Handle User-App Events
- Compare Against Autostart Configuration

### Respond to Errors, Warnings, and Notifications

- Subscribe to Management Events
- Recognize the Event Type
- Route by Component and Condition
- Correlate with Heartbeat Counters
- Handle Display Notifications

### Track Firmware Updates

- Subscribe Before Starting
- Follow Download and Overall Progress
- Track Per-Component Progress
- Recognize Completion or Failure
- Confirm the Version

### Build a Reader Health View

- Combine Status and Heartbeats
- Separate Radio, Gateway, System, and User-App Indicators
- Include Delivery Counters
- Mark Model-Specific Capabilities

## Scale to a Fleet

### What Changes When You Scale

- Every Reader Has Its Own State
- Model and Capability Differences Matter
- Regions and Networks Stay Per Reader
- Endpoint Configuration Stays Per Reader
- No Fleet Controller Is Defined

### Provision Readers

- Before You Begin
- Identify Each Reader
- Apply the Baseline
- Configure Endpoint Planes
- Apply the Mode
- Install Certificates and Applications
- Verify Every Reader

### Keep Configuration Consistent

- Store Complete Mode Documents
- Store Configuration by Plane
- Read Back Effective State
- Compare Capabilities
- Detect Drift
- Remediate One Domain at a Time

### Roll Out Changes in Stages

- Choose a Representative Reader
- Apply the Change
- Verify Commands and Streams
- Expand the Rollout
- Stop on New Errors or Delivery Loss

### Operate a Mixed Fleet

- Branch on Model and Capabilities
- Isolate Display and Stack-Light Work
- Isolate Cellular and GPS Work
- Keep Shared RFID Configuration Consistent

## Diagnose and Recover

### Diagnose and Recover

- Start from What You Can See
- Check the Relevant Plane
- Compare Status with Events
- Read Logs Before Clearing Them
- Choose a Recovery Path

### Diagnose by System Area

- Radio Control
- Reader Gateway
- System
- Network and Local REST
- User Applications
- Model-Specific Peripherals

### Reader and Hardware

- Reader Does Not Power or Boot
- The Reported Model Is Unexpected
- An Antenna Is Disconnected
- A Capability Is Missing
- Start with Identity, Capabilities, and Status

### Network and Local REST

- Reader Has No Reachable Address
- Wi-Fi Association Fails
- Ethernet Has No Link
- Cellular Does Not Connect
- Login Fails
- A Bearer Token Is Rejected
- The Reader Disappears After a Network Change

### MQTT Connectivity and Endpoint Delivery

- A Command Gets No Response
- A Connection Stays Down
- One Plane Works and Another Does Not
- Events Stop During a Disconnect
- Retained Data Does Not Replay

### Operating Mode and Configuration

- The Wrong Mode Runs
- A Set Is Rejected
- Fields Disappear After a Mode Change
- Effective Values Differ from Configured Values
- Start with the Full Configuration

### RFID Read Performance

- No Tag Data Arrives
- Tags Are Missed
- Tags Repeat Too Often
- Reads Come from the Wrong Antenna
- PORTAL Does Not Start
- Access Results Fail

### BLE Scanning and Data

- BLE Does Not Start
- No BLE_DATA Events Arrive
- A Beacon Format Is Missing
- Filters Remove Expected Devices
- RFID Works but BLE Does Not

### GPIO, Indicators, and the Reader Panel

- A GPI Trigger Is Not Seen
- A GPO Does Not Change
- An LED Action Does Not Run
- The Display Does Not Start
- The Stack Light Is Unsupported

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
- The Reader Does Not Return
- The New Version Is Not Active
- Decide Whether to Revert

### Recovery Playbooks

- Stop Unexpected Reading
- Restore a Lost Data Connection
- Recover After a Network Change
- Rebuild an Operating Mode
- Recover a Failed Firmware Update
- Re-establish Monitoring

### Scope a Fleet-Wide Incident

- Count Affected Readers
- Group by Model, Site, Version, and Configuration
- Identify the Failing Plane
- Compare the Last Change
- Decide Whether to Halt a Rollout

### Escalate to Support

- Capture Identity and Versions
- Capture Status and Heartbeats
- Export the Relevant Logs
- Preserve the Failing Configuration
- Record the Command or REST Exchange
- Open the Case
