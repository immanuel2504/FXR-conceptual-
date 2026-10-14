# What the IoT Connector is

The IoT Connector on an FXR reader is the interface your application uses to control the reader and receive what it reports. The contracts cover the **FXR60** and **FXR90** fixed RFID readers. They describe two ways to reach the same reader:

| API | Contract | Version | What it is |
|---|---|---|---|
| MQTT | `FXR_60-90_mqtt_api.json` | 1.0.0 | Commands, responses, and events used to monitor and control reader operation |
| REST | `FXR_60-90_rest_api.yaml` | 3.0.0 | The local REST surface for the same reader |

MQTT is bidirectional: the application sends a command, and the reader sends a response. The reader also publishes events on its own, without a command for that message. REST is request and response. You call an endpoint on the reader and read the body that comes back.

The work the contracts cover falls into four groups:

- **Control.** Choose an operating mode, then start or stop RFID inventory and, when you ask for it, BLE scanning.
- **Management.** Identity, status, configuration, network, certificates, region, time, logs, firmware, user applications, GPIO, and the FXR60 display and stack light.
- **Management events.** Heartbeats, firmware-update progress, GPI and GPO changes, errors, warnings, and user-application events.
- **Data events.** Tag reads while inventory is active, shaped by the operating mode, and BLE data events.

The MQTT contract names a REST endpoint beside many commands. `start` on MQTT is the same action as `PUT /cloud/start` on REST. `get_version` is `GET /cloud/version`. Use one interface in an integration. The other interface is the same reader, not a second product.

**Related:** [FXR60 and FXR90](fxr60-and-fxr90.md) · [Two interfaces](../core-concepts/two-interfaces.md)
