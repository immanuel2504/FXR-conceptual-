# Commands, responses, and events

The MQTT contract groups messages into commands you send and events the reader publishes.

## Commands

A command is a request the application sends. The reader returns a response. The contract calls this bidirectional: cloud to device, and device to cloud.

The command groups are:

| Group | What it changes or reads |
|---|---|
| Control | Operating mode, preselection, start, and stop |
| Impinj Gen2X | The Impinj Gen2X configuration applied when RFID inventory starts |
| System | Version, status, configuration, capabilities, hostname, password, reboot, cable-loss compensation, pass-through, cloud-config import |
| App LED | Application LED |
| Stack LED | Stack light. FXR60 only |
| Display | Display configuration and attached I/O devices. FXR60 only |
| GPIO | GPI status and GPO state |
| Region | Regulatory region, supported regions, and supported standards |
| Logs | Log configuration and the log files |
| Date and time | Time zone and NTP server |
| Certificate | Device certificates and CA certificates |
| Network | Network configuration, Wi-Fi scan, interfaces, read points, GPS coordinates, eSIM |
| Firmware | OS update and firmware revert |
| User application | Install, start, stop, autostart, list, pass data, uninstall |
| BLE | BLE configuration |

REST exposes the same management and control actions as `/cloud/…` endpoints. It adds `GET /cloud/localRestLogin`, which MQTT does not use.

## Events

Management events are asynchronous. The reader publishes them when status changes or when a configured condition occurs. They are not the response to a command you just sent.

| Event | What it reports |
|---|---|
| Heartbeat | Periodic health: radio control, reader gateway, system, and user applications |
| Firmware update progress | Progress of a firmware update |
| GPI / GPO | Input and output changes |
| Error / warning | Error and warning conditions |
| User application | User-application activity |
| Notification | A notification event |

Tag data events report RFID reads on the data event channel while inventory is active. BLE data events report BLE scanning. Neither stream exists on the REST contract.

**Related:** [Operating modes](operating-modes.md) · [Operate and monitor](../operate-and-monitor/index.md)
