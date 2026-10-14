# Quick start

One path from a reachable reader to a tag read. Field-level payloads stay in the contracts. This page is the order of operations.

## 1. Identify the reader

On REST, obtain a bearer token with `GET /cloud/localRestLogin`, then call `GET /cloud/version`.

On MQTT, send `get_version`.

The result includes the model and serial number. If the model is FXR90, leave display and stack-light commands out of this session.

## 2. Set the operating mode

Send `set_mode` (REST: `/cloud/mode`). The call **replaces the whole mode configuration**. Fields you leave out are not kept from the previous mode. Send the full mode you want.

The `type` is one of `SIMPLE`, `INVENTORY`, `PORTAL`, `CONVEYOR`, or `CUSTOM`. For a first read, `SIMPLE` reports each unique tag with the basic identity fields.

Also set the antennas and transmit power you intend to use. The mode is what `start` will run.

## 3. Start inventory

Send `start` (REST: `PUT /cloud/start`).

An empty request body **starts RFID inventory only**. BLE scanning does not start unless the body includes `scanType` with `ble`, and BLE has been configured first.

`start` uses the operating mode already configured. It can also apply a previously saved Impinj Gen2X configuration, and it can say whether RFID inventory should resume after a reboot.

## 4. Read the tag events

While inventory is active, tag data events arrive on the data event channel. The event `type` matches the mode you set: `SIMPLE`, `INVENTORY`, `CUSTOM`, `PORTAL`, or `CONVEYOR`.

## 5. Stop

Send `stop` (REST: `PUT /cloud/stop`) when the session is finished.

**Related:** [Operating modes](../core-concepts/operating-modes.md) · [Read tags](../read-tags-and-barcodes/index.md)
