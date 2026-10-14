# FXR60 and FXR90

Both models are in the same contracts. A command marked for FXR60 / FXR90, such as `get_version`, applies to both.

Two MQTT tag groups are limited to the FXR60:

- **Stack LED.** Stack-light commands. The contract says they are not applicable to the FXR90.
- **Display.** Display configuration and attached I/O device commands. The contract says they are not applicable to the FXR90.

Everything else in the tag groups — control, system, GPIO, region, logs, date and time, certificates, network, firmware, user applications, and BLE — is part of the shared FXR surface. Confirm the model with `get_version` (`GET /cloud/version` on REST) before calling a display or stack-light operation. That command returns the reader model and serial number along with the software versions.

**Related:** [What the IoT Connector is](what-the-iot-connector-is.md) · [Manage your reader](../manage-your-reader/index.md)
