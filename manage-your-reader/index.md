# Manage your reader

Management commands read or change one reader. They do not start inventory. On MQTT they are the Management Commands group. On REST they are the matching `/cloud/…` endpoints.

Do this before you depend on tag reads.

## Identity and health

- `get_version` / `GET /cloud/version` — model, serial number, component versions, available OS upgrades, and firmware revert information.
- `get_status` / `GET /cloud/status` — current status.
- `get_readerCapabilities` — what this reader can do.
- `get_config` / `set_config` — the stored configuration. `set_importCloudConfig` imports a cloud configuration.
- `get_hostname` / `set_hostname` — the reader hostname.
- `set_password` — the password update (`/cloud/updatePassword` on REST).

## Where it is allowed to transmit

- `get_region`, `set_region`, `get_supportedRegionList`, `get_supportedStandardList`.

Set the region before you raise transmit power. The supported lists are the values `set_region` can accept.

## Network

`get_network` and `set_network` are the network configuration. Around them:

- available Wi-Fi networks
- network interfaces
- read points
- GPS coordinates
- eSIM configuration (`get_eSimConfig` / `set_eSimConfig`)

Changing the network can drop the path you are using to send the command. Read the current configuration before you write a new one.

## Time, certificates, and firmware

- Time zone and NTP server, so log timestamps and certificates line up with the site.
- Device certificates (`get_certs`, `set_update_cert`, `del_certs`, `refresh-cert`) and CA certificates (list, install, delete).
- `set_os` updates the OS. `revertback` returns to the previous firmware. `firmwareUpdateProgress` is the event that reports progress while an update runs. `get_version` includes `availableOsUpgrades` and `revertBackFirmware`.

## GPIO, lights, and the FXR60 panel

- GPI status and GPO control. Portal mode starts a read cycle from a GPI trigger, so the inputs matter before that mode is useful.
- Application LED.
- Stack light and display configuration, **FXR60 only**. `get_inputOutputDevices` lists attached I/O devices on that model.

## User applications

The reader can run user applications: install, list, start, stop, autostart, pass data through to the reader gateway, and uninstall. Heartbeats include a user-application section, and `userapp_event` reports application activity. Install and autostart are how an application survives a reboot. They are separate from RFID `start`.

`reboot` restarts the reader. `start` can be told to resume RFID inventory after that reboot. A reboot still drops the current session.

**Related:** [FXR60 and FXR90](../get-oriented/fxr60-and-fxr90.md) · [Operate and monitor](../operate-and-monitor/index.md)
