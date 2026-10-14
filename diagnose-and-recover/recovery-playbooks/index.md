# Recovery playbooks

Each playbook uses only operations the contracts define. Read the log or status first. Delete a log only after you have copied it.

## Inventory is running and should not be

Send `stop` (`PUT /cloud/stop` on REST). Confirm with `get_status`. Tag data events are defined only while inventory is active, so they should end with the stop.

If a later reboot starts inventory again, the previous `start` was set to resume RFID after reboot. The next `start` is where that choice is made.

## The reader does not answer

1. On REST, repeat `GET /cloud/localRestLogin` and replace the bearer token.
2. Call `get_version` or `GET /cloud/version`.
3. If the last successful command was `set_network`, the address you are using may no longer be the reader. Use the network you configured, or the path you still have on site.
4. `reboot` is the restart. It drops the session. After it returns, identify the reader again before you send `set_mode` or `start`.

## A firmware update did not finish cleanly

Watch `firmwareUpdateProgress`. When the reader answers again, `get_version` reports `revertBackFirmware` and `availableOsUpgrades`. `revertback` (`/cloud/revertbackOS` on REST) restores the previous firmware. Run it only after you have read that version block and decided the running image is the one you want to leave.

## Portal or conveyor reads do not match the mode

Read `get_mode` and compare `type` with the tag events you actually receive. Then read GPI status. Fix the mode by sending a **complete** `set_mode`. A partial body removes the fields you did not send.

## Logs are the only record left

Copy, in this order, only the files that match the layer that failed:

- syslog, then `del_syslogs` if you must clear it
- radio-control log
- reader-gateway warning log and error log
- radio packet log, then `del_radio_pkt_logs` if you must clear it

Clearing a log is not a repair. It removes the record of the failure.

**Related:** [Diagnose by system area](../diagnose-by-system-area/index.md) · [Diagnose and recover](../index.md)
