# Operate and monitor

After the reader is in service, watch the events the reader publishes and the status you can ask for. This is all on the MQTT contract. REST can still read `GET /cloud/status` and `GET /cloud/version` when you can reach the reader.

## Heartbeat

A heartbeat is periodic. It is the standing picture of reader health, not an alarm by itself. The contract splits it into four sections, each also described on its own:

| Section | What it is for |
|---|---|
| `radio_control` | Antenna states, radio connection and activity, radio resource use, and radio-control counters |
| `reader_gateway` | Messaging counters, resource use, uptime, errors, warnings, and whether interfaces are connected |
| `system` | System resources, storage, time, temperature, power, network identity, and GPIO state |
| `userapps` | User-application status |

`heartbeat_interval` is the event that describes the interval itself.

## Conditions, not polls

These events fire when something changes:

- `error` and `warning`
- `gpi` and `gpo`
- `firmwareUpdateProgress` while `set_os` is running
- `userapp_event` for user applications
- `notification_event`

Subscribe to them before you need them. They are not retained in the REST API.

## Logs when an event is not enough

The Logs commands read and clear specific files: syslog, radio-control log, reader-gateway warning log, reader-gateway error log, and radio packet log. `set_logs` changes log configuration. `del_syslogs` and `del_radio_pkt_logs` delete those files. Read them before you delete them.

## A status call is still the check you control

`get_status` answers when you ask. Use it to confirm the reader is reachable and to compare against the last heartbeat. If heartbeats arrive and `get_status` fails, the failure is on the command path. If commands succeed and heartbeats stop, the failure is on the event path.

**Related:** [Diagnose and recover](../diagnose-and-recover/index.md) · [Manage your reader](../manage-your-reader/index.md)
