# Two interfaces

The MQTT contract is version 1.0.0. The REST contract is version 3.0.0. They are not two generations of one file. They are two transports for the FXR60 and FXR90.

MQTT commands are named in the MQTT file (`start`, `get_version`, `set_mode`). Many of those commands list a REST endpoint for the same action (`PUT /cloud/start`, `GET /cloud/version`). The REST file is the local HTTP surface: paths under `/cloud/…`.

Use REST when the application can call the reader directly and can hold a bearer token. `GET /cloud/localRestLogin` is the login. It is the only REST operation secured with basic authentication. Its `message` is the bearer token. Later calls send `Authorization: Bearer <token>`.

Use MQTT when the application exchanges commands, responses, and events on the MQTT channel the contract describes. Commands are bidirectional: cloud to device, and device to cloud. Events are published by the reader when status changes or when a configured condition occurs. REST does not carry those event streams. Heartbeats, tag data events, and BLE data events are defined on the MQTT contract.

An integration should pick one transport and stay with it. Mixing them in one session means two authentications and two views of reader state.

**Related:** [Commands, responses, and events](commands-responses-and-events.md) · [What you need](../get-oriented/what-you-need.md)
