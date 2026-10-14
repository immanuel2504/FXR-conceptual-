# Operating modes

The operating mode is the configuration `start` uses for RFID inventory. `set_mode` writes it. The MQTT contract is explicit about how that write works: the call **replaces the entire mode configuration**. Omitted fields are not retained from the previous mode. Send the full object you want the reader to use.

`type` selects the workflow:

| Type | What the tag events do |
|---|---|
| `SIMPLE` | Reports every unique tag with the basic identity fields |
| `INVENTORY` | Reports unique tags for each antenna at a configured interval, including peak RSSI and read count |
| `PORTAL` | Reports unique tags after a GPI trigger starts the portal read cycle |
| `CONVEYOR` | A conveyor read cycle |
| `CUSTOM` | An advanced inventory workflow with optional metadata and tag-access results |

The same command also carries the RF setup for that mode: antenna ports, transmit power, environment profile, antenna stop conditions, Gen2 query, select, and access settings, and report filtering, including RSSI filtering and metadata options.

`PORTAL` depends on a GPI trigger. GPIO status and GPO control are separate commands (`get_gpi_status`, `set_gpo`). Configure the inputs before you expect a portal cycle to start on its own.

`start` does not rebuild the mode. It runs the mode already stored, and it can apply a previously saved Impinj Gen2X configuration at the moment inventory starts. Gen2X is its own pair of commands, `get_impinjGen2X` and `set_impinjGen2X`.

Preselection (`get_preSelection` / `set_preSelection`) is separate from the mode. It is tag selection applied around inventory, not a sixth mode type.

**Related:** [Read tags](../read-tags-and-barcodes/index.md) · [Quick start](../quick-start/index.md)
