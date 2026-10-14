# IoT Connector

Configure, read, and monitor an FXR fixed reader over MQTT and local REST.

- **Guides** — the tasks for one job, such as Ethernet, an MQTT broker, or a tag read
- **Concepts** — how the reader, operating modes, and connections work
- **Reference** — the command and event reference
- **API contracts** — `FXR_60-90_mqtt_api.json` and `FXR_60-90_rest_api.yaml`

Command fields and schemas stay in the contracts. A guide page links to the contract. It does not copy it.

## Tutorials

- How do I read my first tag?
- How do I connect the reader with Ethernet?
- How do I connect the reader with Wi-Fi?
- How do I send tag data to an MQTT broker?
- How do I send tag data to AWS IoT?
- How do I send tag data to Azure IoT?
- How do I run a portal read?
- How do I watch the reader with a heartbeat?

## Guides

Practical tasks. Do these after the tutorial that matches the job.

### Set up the reader

- How do I confirm the model and serial number?
- How do I set the region, time, and hostname?

### Network

- How do I see the network interfaces?
- How do I choose DHCP or a static address?
- How do I configure Ethernet?
- How do I discover Wi-Fi networks?
- How do I configure Wi-Fi?
- How do I configure cellular on an FXR90?
- How do I use the reader as an access point?
- How do I connect over a Bluetooth network?
- The reader no longer answers after a network change. What do I check?

### Endpoint configuration

- How do I choose a destination for commands and events?
- How do I configure an MQTT broker?
- How do I configure AWS IoT?
- How do I configure Azure IoT?
- How do I configure Google Cloud IoT?
- How do I POST tag data to a URL?
- How do I use a WebSocket, TCP server, or keyboard connection?
- How do I set batching and retention?
- How do I secure a connection with a certificate?

### Read tags

- How do I set the operating mode?
- How do I set antennas and transmit power?
- How do I start and stop reading?
- How do I choose which tags and fields are reported?
- How do I read and write tag memory?
- How do I use Impinj Gen2X?
- How do I turn RF preselection on or off?

### Data, monitoring, and maintenance

- How do I receive tag data events?
- How do I run a BLE scan?
- How do I receive BLE data events?
- How do I turn on heartbeats and alerts?
- How do I check reader health?
- How do I respond to errors and warnings?
- How do I read logs?
- How do I update or restart the reader?
- How do I use GPIO and the application LED?
- How do I use the display and stack light?
- How do I install and run a user application?
- How do I send data to a user application?

## Concepts

- What does the IoT Connector do?
- Which reader do I have?
- How do the reader, the broker, and my application work together?
- How do commands, responses, and events work?
- How does an operating mode shape tag data?
- How is configuration saved?
- What interfaces can the reader use?
- Where can the reader send commands and events?

## Reference

One page for each group in the contracts. Each command names the guide that uses it.

- Authentication
- Control
- Impinj Gen2X
- System
- Network
- Region
- Date and time
- Certificates
- GPIO
- LED
- Display
- Logs
- Firmware
- User applications
- BLE
- Management events
- Tag data events
- BLE data events

## Where to go next

| I want to… | Open |
|---|---|
| Read a tag now | How do I read my first tag? |
| Put the reader on the network | Network, under Guides |
| Send events to a broker or a cloud | Endpoint configuration, under Guides |
| Look up a field | Reference |
| Understand a rule before I change anything | Concepts |
