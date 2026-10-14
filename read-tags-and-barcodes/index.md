# Read tags

The main job of the reader is RFID inventory. BLE scanning is optional and stays off until a command asks for it. The contracts do not describe a barcode scanner.

## What has to be true first

1. The operating mode is the full configuration you want. `set_mode` replaces the previous mode.
2. The regulatory region is set.
3. Antennas and transmit power in that mode match the portal, dock, or conveyor.
4. For `PORTAL`, the GPI trigger is in place.
5. For Impinj Gen2X, the Gen2X configuration is already saved. `start` applies it. It does not create it.

## Start and stop

`start` starts RFID inventory, BLE scanning, or both.

- An empty body starts **RFID only**, using the current operating mode.
- BLE does not autostart. Include `scanType` with `ble` to scan BLE, and configure BLE with `set_bleConfig` first.
- One `start` can run RFID and BLE in the same session.
- `start` can also record whether RFID inventory should resume after a reboot.

`stop` ends that session.

## What comes back

Tag data events are published on the data event channel **while inventory is active**. The event `type` is the mode that produced the read:

- `SIMPLE` — each unique tag, basic identity fields
- `INVENTORY` — unique tags per antenna, on an interval, with peak RSSI and read count
- `PORTAL` — unique tags after the GPI trigger starts the cycle
- `CONVEYOR` — the conveyor cycle
- `CUSTOM` — optional metadata and tag-access results

There is one MQTT event, `tagDataEvents`, plus a page in the contract for each of those five shapes. Subscribe for the shape you configured. A `PORTAL` deployment that listens only for a continuous `SIMPLE` stream will look like a reader that never reads.

BLE reads are a different event, `ble_data_events`. They are not tag events.

REST can start and stop the reader. The tag and BLE streams are defined on the MQTT contract.

## Filtering

`set_mode` carries report filtering, RSSI filtering, and which metadata is reported. Preselection (`set_preSelection`) is the tag selection around the inventory. Both are configuration. They are not a second copy of the event.

**Related:** [Operating modes](../core-concepts/operating-modes.md) · [Quick start](../quick-start/index.md)
