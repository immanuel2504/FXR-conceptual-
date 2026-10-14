# Diagnose and recover

Start from what you can observe, then use the command or event that covers that layer. The contracts do not define a numbered failure-mode catalog. They do define the status, logs, and events that show which layer failed.

## What you can see

| What you see | Where to look |
|---|---|
| No answer to a command | The path to the reader. On REST, confirm the bearer token from `GET /cloud/localRestLogin`. Then `GET /cloud/version` or `get_version`. |
| Commands succeed, no tag reads | Mode, `start`, and the event `type`. An empty `start` runs RFID only. Tag events exist only while inventory is active, and only on MQTT. |
| Portal never starts a cycle | GPI. Portal tag events follow a GPI trigger. Read `get_gpi_status`. |
| BLE scan returns nothing | `set_bleConfig` first. `start` does not scan BLE unless `scanType` includes `ble`. BLE results are `ble_data_events`, not tag events. |
| Reader was reachable, then not, after a network write | `set_network` changed the path you were using. |
| Firmware update seems stuck | `firmwareUpdateProgress`, then `get_version` for `availableOsUpgrades` and `revertBackFirmware`. |
| Wrong model behavior | `get_version`. Display and stack light are FXR60 only. |
| Need the record after the fact | Syslog, radio-control log, reader-gateway warning log, reader-gateway error log, radio packet log. |

Two routes from here:

- [Diagnose by system area](diagnose-by-system-area/index.md) — radio, gateway, system, network, and your application.
- [Recovery playbooks](recovery-playbooks/index.md) — stop, reboot, revert firmware, and read logs before deleting them.

**Related:** [Operate and monitor](../operate-and-monitor/index.md)
