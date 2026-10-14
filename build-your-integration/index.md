# Build your integration

An integration is the application that sends commands and consumes what the reader sends back. The contracts fix the shape of that exchange. They do not include a sample application.

## Choose the transport once

REST suits an application that can open a connection to the reader and store a bearer token. Log in with `GET /cloud/localRestLogin`, then send the token on every later call.

MQTT suits an application that must receive events. Tag data, BLE data, heartbeats, GPIO changes, errors, warnings, firmware progress, and user-application events are MQTT publications. A REST-only integration can configure and start the reader, and it will not see those streams.

## Treat set as replace

`set_mode` replaces the entire mode object. Read `get_mode` first if you intend to change one field, then send the complete object back. The same habit applies to any configuration you have not confirmed is a partial update. The mode command is the one the contract states outright.

## Pair the mode with the event

The tag event `type` equals the mode `type`. Build the consumer for the mode you set. Do not write one parser and point it at every tag event.

## Start is not configuration

Configure mode, region, antennas, and BLE before `start`. `start` runs that configuration. An empty `start` is a valid RFID start. It is not a request to invent a mode.

## Keep command responses and events apart

A command response answers the command you sent. A management event arrives because the reader published it. Firmware update progress, GPI, errors, and heartbeats will not appear as the body of `set_os` or `set_gpo`. The application needs a path for responses and a path for events.

## User applications are a second runtime

`install_user_app`, `start_user_app`, and `autostart_user_app` run software on the reader. That is separate from RFID `start`. Pass-through (`set_passthru`, and on REST `pass-through` and `setdataToRG`) forwards a payload. It is not inventory.

**Related:** [Two interfaces](../core-concepts/two-interfaces.md) · [Commands, responses, and events](../core-concepts/commands-responses-and-events.md)
