# Diagnose by system area

The heartbeat sections are the map. Each section is one layer of the reader. Read the latest heartbeat, then the log for that layer.

## Radio

`radio_control` reports antenna states, whether the radio is connected and active, and radio-control counters. Tag data events are produced here, and only while inventory is running.

If this section shows the radio idle, `start` has not been accepted or `stop` has already run. If antennas are not in the state you configured, read `get_mode`. Remember that `set_mode` replaced the whole mode the last time it succeeded.

The radio packet log (`get_radio_pkt_logs`) is the detailed radio record. The radio-control log is `get_rc_log`.

## Reader gateway

`reader_gateway` reports messaging counters, uptime, errors, warnings, and interface connection status. This is the layer between the reader and the MQTT side of the contract.

Reader-gateway warning and error logs are `get_rg_warn_logs` and `get_rg_error_logs`. The `error` and `warning` events are the live form of the same conditions.

If commands still complete and this section shows an interface down, events can stop while REST still answers on the local network.

## System

`system` reports resources, storage, time, temperature, power, network identity, and GPIO state. Compare network identity with `get_network` and `get_hostname`. Compare GPIO with `get_gpi_status` when a portal does not trigger.

Time skew shows up here and in the date-and-time commands (`get_timeZone`, `get_ntpServer`). Certificate failures often sit next to a clock that is wrong.

## Your application

If version, status, and heartbeats are healthy and tag events are arriving at the reader, the remaining gap is the consumer: the wrong event `type`, a parser built for `SIMPLE` while the mode is `PORTAL`, or a subscription that started after inventory had already been running.

User applications on the reader are their own layer. `userapps` in the heartbeat and `userapp_event` describe them. A failed user application does not by itself mean RFID inventory has stopped.

**Related:** [Recovery playbooks](../recovery-playbooks/index.md) · [Operate and monitor](../../operate-and-monitor/index.md)
