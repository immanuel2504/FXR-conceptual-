# Scale to a fleet

The contracts describe one reader at a time. A fleet is many readers, each with its own identity, network, region, and mode. Nothing in the files provides a fleet controller. The same commands run once per reader.

What changes when there is more than one reader:

- **Identity.** `get_version` returns model and serial number. `get_hostname` / `set_hostname` is how you tell sites apart in your own records. Store the serial number with every configuration you send.
- **Regulatory region.** Readers in different countries do not share one `set_region` value. Read `get_supportedRegionList` on each reader.
- **Network and certificates.** Each reader has its own `set_network` and its own device and CA certificates. A network change can disconnect that reader only.
- **Mode.** `set_mode` replaces the whole mode on that reader. Keep the full mode document per deployment type (portal, conveyor, inventory) and send the matching document. Do not send a partial update and assume the previous antenna list remains.
- **Cloud configuration.** `set_importCloudConfig` imports a configuration onto the reader. That is the contract's bulk configuration operation. It still targets one reader.
- **Firmware.** `set_os` and `firmwareUpdateProgress` are per reader. `get_version` shows `availableOsUpgrades` and whether revert is available. Update one reader, confirm tag events and heartbeats, then the next.
- **FXR60-only hardware.** Do not send display or stack-light configuration to an FXR90 because a neighboring FXR60 accepted it.

User-application install and autostart are also per reader. An application installed on one unit is not present on the next until you install it there.

**Related:** [Manage your reader](../manage-your-reader/index.md) · [Operating modes](../core-concepts/operating-modes.md)
