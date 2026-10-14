# ZIoTC information architecture research

Research date: 13 October 2026. Links below were opened from manufacturer sites or manufacturer file hosts. A link is included only when that page or PDF was retrieved. Capabilities are limited to what those documents state.

ZIoTC, in the FXR60/FXR90 contracts, is software on the reader. The reader has Ethernet, Wi-Fi, and on the FXR90 a cellular interface. It publishes tag data, BLE data, and management events, and it accepts commands over MQTT and local REST. The comparable devices below are physical. Cloud products are mentioned only where a device manual tells the device how to connect to them.

## 1. Ten physical devices, by similarity to ZIoTC

Similarity means the device itself holds the client: it is configured on the device, it opens MQTT or HTTP to an external broker, and it publishes its own data.

| Rank | Device | Why it is close | Where the match stops |
|---|---|---|---|
| 1 | Opto 22 groov RIO, GRV-R7-MM1001-10 and GRV-R7-MM2001-10 | Edge I/O module. Power, first account, network, I/O, then built-in MQTT from groov Manage. Separate MQTT getting-started guide. | I/O and PID, not RFID. Several MQTT clients (groov Manage, Node-RED, Ignition Edge). |
| 2 | SICK SIG350 IO-Link Master | One physical gateway. Web UI. Integrated MQTT client and REST API publish sensor data in parallel with the fieldbus. | PROFINET or EtherNet/IP is the primary control path. MQTT follows the IO-Link JSON companion spec, not a vendor command set. |
| 3 | Moxa AIG-301 | One user manual from power and Ethernet to a web console, then generic MQTT, AWS IoT Core, and Azure IoT Device, plus certificates and diagnostics. | It is a programmable gateway. Modbus and OPC UA dominate the middle of the book. |
| 4 | Opto 22 groov EPIC, GRV-EPIC-PR1 and GRV-EPIC-PR2 | Same groov Manage and MQTT guide as RIO, on a larger controller. | Assembly of chassis, power supply, and I/O modules. More of a controller than a single reader. |
| 5 | Teltonika RUTX11 | Industrial router. Official wiki pages for Data to Server over MQTT, an MQTT publisher, and AWS IoT Core certificates. | The product is a router. The MQTT broker page is the router hosting Mosquitto, which is the reverse of ZIoTC. Fleet management is RMS, Teltonika’s cloud. |
| 6 | Advantech WISE-710 | Industrial gateway. Hardware manual for install. EdgeLink, which runs on the gateway, configures MQTT, AWS, and Azure and publishes tags. | MQTT is not in the hardware manual. EdgeLink Studio is a Windows utility plus software on the device. |
| 7 | Red Lion FlexEdge DA50A | Physical gateway. Installation guide, then Crimson 3.2 for configuration. Product page states MQTT to cloud servers. | The installation PDF does not contain the MQTT procedure. That lives in the Crimson software guide. |
| 8 | WAGO PFC200, 750-8213 | Physical controller. Manual lists MQTT, a web server, and web-based management. | MQTT and Sparkplug are enabled with a license and e!COCKPIT, not as a chapter of the controller manual. |
| 9 | HMS Ewon Flexy 205 | Physical gateway. Web wizards for system, Internet, and users. Official developer pages for MQTT to AWS IoT and Azure IoT Hub. | The device is an MQTT client only through BASIC or Java. There is no form-based MQTT page in the installation guide. |
| 10 | Siemens SIMATIC IOT2050 | Physical edge device. Official operating instructions for power, mounting, Ethernet, SSH, and network setup. | The operating instructions do not contain an MQTT chapter. MQTT, when used, is software the user installs, such as Node-RED. |

## 2. Official documentation

### Opto 22 groov RIO

- Purpose: universal edge I/O module that can publish field data with a built-in MQTT client.
- [User’s guide, form 2324](https://documents.opto22.com/2324_groov_RIO_Users_Guide.pdf) and the [document page](https://opto22.com/support/resources-tools/documents/2324-groov-rio-users-guide). Chapters include welcome and requirements, mounting and wiring, power, initialization, network and security, I/O, and maintenance.
- [In-the-box sheet, form 2342](https://documents.opto22.com/2342_groov_RIO_in_the_box.pdf). Power, create the admin account, Quick Start, then I/O and MQTT.
- [Getting Started with MQTT in groov Products, form 2350](https://documents.opto22.com/2350_Getting_Started_with_MQTT_in_groov_Products.pdf) and the [document page](https://opto22.com/support/resources-tools/documents/2350-getting-started-with-mqtt-in-groov-products). Broker, security, and which client to use.

### SICK SIG350

- Purpose: IO-Link master. PROFINET or EtherNet/IP to a PLC, and REST, MQTT, or OPC UA for other systems.
- English operating instructions for the PROFINET model: [IM0101468](https://www.sick.com/media/docs/8/68/468/operating_instructions_sig350_profinet_sensor_integration_gateway_en_im0101468.pdf).
- The same manual describes the web interface, the REST API, and the integrated MQTT client. Publication can be periodic or manual. Payloads follow JSON Integration for IO-Link V1.0.0.

### Moxa AIG-301

- Purpose: programmable IIoT gateway with Modbus, OPC UA, and cloud clients.
- [User manual v2.3, November 2025](https://moxa.com/getmedia/2094b92b-7ad2-478a-80be-ae51d49db79a/moxa-aig-301-series-manual-v2.3.pdf).
- [Product page](https://www.moxa.com/en/products/industrial-computing/iiot-gateways/programmable-iiot-gateways/aig-301-series), which lists that manual.
- [AIG-300 hardware manual](https://moxa.com/getmedia/24bc9963-20e4-4cbd-98e8-bfcd86f42e99/moxa-aig-300-series-hardware-manual-v1.0.pdf) for mounting, power, and ports.
- Manual path: power, serial, Ethernet, web console, dashboards, IP address, cellular, Wi-Fi, protocols, cloud clients, certificate center, maintenance, diagnostics. Appendix B points at further software and OpenAPI material. This research did not re-check that external OpenAPI URL.

### Opto 22 groov EPIC

- [User’s guide, form 2267](https://documents.opto22.com/2267_groov_EPIC_Users_Guide.pdf) and the [document page](https://opto22.com/support/resources-tools/documents/2267-groov-epic-user-s-guide).
- MQTT procedure is in the same form 2350 guide as RIO. The user’s guide chapter on data services covers broker configuration and enabling MQTT.

### Teltonika RUTX11

- [Data to Server](https://wiki.teltonika-networks.com/view/RUTX11_Data_to_Server). Collect device data and send it to an MQTT server, or to Azure IoT Hub with an added package.
- [MQTT](https://wiki.teltonika-networks.com/view/RUTX11_MQTT). Publisher, and a broker hosted on the router. The broker role is not the ZIoTC role.
- [Cloud Solutions](https://wiki.teltonika-networks.com/view/RUTX11_Cloud_Solutions). AWS IoT Core thing certificate and private key.
- A single printed getting-started manual was not part of the pages opened. The wiki is one page per WebUI feature.

### Advantech WISE-710

- Hardware: [WISE-710 user manual](https://advdownload.advantech.com/productfile/Downloadfile5/1-1WSSFFB/WISE-710_EN_User%20Manual_Ed.2.pdf). LEDs, COM, LAN, power, digital I/O.
- Software on the gateway: [EdgeLink quick start](https://advdownload.advantech.com/productfile/Downloadfile1/1-2BBA3O7/EdgeLink_Quick_Start.pdf). Ethernet, Wi-Fi, cellular, MQTT forwarding, batch download of a project.
- MQTT fields: [EdgeLink Cloud Service](https://learn.advantech.com/EdgeLink/Cloud/). Broker host, port 1883 or 8883, MQTT 3.1.1, client ID, user, password, keep-alive. Azure IoT Hub uses a connection string instead of those fields.

### Red Lion FlexEdge DA50A

- [Installation guide](https://www.redlion.net/sites/default/files/DA50A%20FlexEdge%C2%AE%201-Sled%20Gateway%20Product%20Manual.pdf). Power and ports. Configuration is Crimson 3.2, over USB, Ethernet, or a microSD image.
- [Crimson 3.2 software guide](https://www.redlion.net/sites/default/files/Crimson%203.2%20Software%20Guide%20English%20%28LP1153B%29%2019MB.pdf). Getting started and device configuration are in this second book.
- Product description of MQTT is on the [FlexEdge page](https://www.redlion.net/flexedge). The installation PDF does not itself walk through a broker.

### WAGO PFC200, 750-8213

- [Controller manual](https://www.wago.com/wagoweb/documentation/750/eng_manu/coupler_controller/m07508213_00000000_0en.pdf). Lists MQTT among communications. Configuration is CODESYS, e!COCKPIT, or web-based management.
- [IoT PLC page](https://www.wago.com/us/iot-plc-controller-with-mqtt). A firmware upgrade and a library send JSON over MQTT with TLS to Azure, AWS, or another broker. Cloud settings are entered in web-based management.
- Sparkplug is a separate license: [2759-247/211-1000 datasheet](https://www.wago.com/wagoweb/documentation/2759/eng_dat/d27590247_02111000_0en.pdf).

### HMS Ewon Flexy 205

- [Product page](https://www.hms-networks.com/p/flexy20500-00ma-ewon-flexy-205). States MQTT and HTTPS through embedded BASIC or Java, and a web interface with setup wizards.
- [Flexy documentation index](https://help.ewon.biz/devices/help/en/ewon-flexy-gateways.html). Points to the installation guide and the Flexy user manual.
- Older base-unit installation guide, still on the official help host: [IG-014](https://help.ewon.biz/legacydocumentation/Oldies%20-%20Installation%20Guides/IG-014-0-EN-(eWON%20Flexy%20-%20Base%20Units).pdf). Default web address, login, and wizards.
- MQTT to clouds, official developer site: [Azure](https://developer.ewon.biz/content/ewon-flexy-microsoft-azure) and [AWS](https://developer.ewon.biz/content/ewon-flexy-amazon-web-services). Both say MQTT needs a BASIC or Java program and cite application guide AUG-0073-00. A manufacturer-hosted PDF of AUG-0073-00 was not retrieved, so that guide is not linked here.

### Siemens SIMATIC IOT2050

- [Operating instructions](https://cache.industry.siemens.com/dl/files/073/109974073/att_1295970/v1/iot2050_operating_instructions_en_en-US.pdf), from the Siemens industry file cache. Mounting, power, Ethernet, example image, SSH, UART, and network interface setup.
- No MQTT, REST API, or broker chapter in that operating instruction. Do not treat Node-RED examples on other sites as the Siemens manual.

## 3. What their manuals contain

Present means the opened document has a real section for it. Missing means it was not found in the documents opened, not that the product cannot do it.

| Topic | groov RIO | SIG350 | AIG-301 | RUTX11 wiki | WISE-710 | DA50A | PFC200 | Flexy 205 | IOT2050 |
|---|---|---|---|---|---|---|---|---|---|
| Overview and architecture | Yes | Yes | Yes | Partial | Partial | Partial | Yes | Partial | Yes |
| Getting started | Yes, in-the-box sheet | In the operating instruction | Yes | Not in the pages opened | EdgeLink quick start | Install only | Manual, not a first MQTT success | Web wizard | Commissioning |
| Power and wiring | Yes | Yes | Yes, plus a hardware manual | Router hardware is a different page | Hardware manual | Install guide | Manual | Installation guide | Yes |
| Network | Yes | Yes | IP, cellular, Wi-Fi | The product is the network device | EdgeLink | Ports only in the install guide | Ethernet in the manual | Internet wizard | Yes |
| MQTT broker | Form 2350 and the user’s guide | Yes, integrated client | Generic MQTT Client | Data to Server and MQTT Publisher | EdgeLink Cloud | In Crimson, not the install guide | Web-based management after an upgrade | BASIC or Java | Missing |
| AWS / Azure as device tasks | Through the broker guide | Missing as named clouds | Separate chapters | Cloud Solutions and an Azure package | Separate EdgeLink sections | In Crimson | Marketing page names them | Developer articles | Missing |
| Certificates and accounts | Account, LDAP, security chapter | Web UI security is limited in the pages read | Certificate center and accounts | AWS certificate upload | Username, password, TLS port | OpenVPN certificates in a support article | TLS stated for MQTT | User wizard | Missing |
| Device operation | I/O channels | IO-Link ports | Modbus and OPC UA | Modbus, optional | Tags in EdgeLink | Crimson | IEC program | Tags, then script | User software |
| Data publishing | MQTT and Node-RED | Periodic or manual MQTT, REST | Cloud publish mode in the appendix | Data to Server interval | Tag upload conditions | Crimson | Variables chosen in the IEC program | Script publishes tag values | Missing |
| Application integration | Node-RED, Ignition, custom programs named | REST and MQTT described for other systems | OpenAPI pointed to from the manual | MQTT payload formats | Tag tables | Crimson | CODESYS libraries | Talk2M APIs and scripts | User software |
| Many devices | microSD and repeated setup, not a fleet controller | One master in the MQTT topic model | ThingsPro / DLM is Moxa’s service | RMS is Teltonika’s cloud | EdgeLink batch download | microSD image | One license per controller | Talk2M | Missing |
| Monitoring and maintenance | Firmware update, service chapter | LEDs and diagnostics | Dashboards, protocol status, diagnostic | Status fields on each wiki page | EdgeLink monitoring claim | Diagnostics port | Web server status | Journal and SMTP | Maintenance and battery |
| Troubleshooting | Support chapter | FAQ-style material in the instruction | Diagnostic chapter | Field descriptions, not one troubleshoot book | Not in the hardware manual | Not in the install guide | Not a dedicated MQTT troubleshoot chapter | Forum, not the install guide | Repair chapter |
| API reference | Not a single REST catalog in form 2324 | REST resources in the operating instruction | Appendix points outward | Tables on each wiki page | EdgeLink tag model | Crimson guide | Library documentation is separate | Programming reference, cited but not retrieved | Missing |

groov EPIC matches the groov RIO column for software topics and adds chassis assembly.

## 4. The three best examples

### Opto 22 groov RIO

Best pattern for ZIoTC. The in-the-box sheet is the getting started: power, create an admin account, run Quick Start, configure I/O, then publish with MQTT. The user’s guide holds mounting, network, security, and maintenance. Form 2350 is a separate MQTT book: choose the client, open a broker, secure it, and test. That split keeps the first success short and puts broker detail where the integrator looks for it.

Weakness for ZIoTC: three MQTT clients. ZIoTC has one client on the reader. Do not copy the choice among groov Manage, Node-RED, and Ignition.

### Moxa AIG-301

Best single-book pattern. The order is power, cable, web login, dashboard, system settings, the data protocol, then one chapter per cloud client, then certificates, then maintenance and diagnostics. Generic MQTT, AWS IoT Core, and Azure IoT Device are siblings. That is the right shape for ZIoTC’s `mqtt`, `mqtt-AWS`, and `mqtt-Azure` connection types.

Weakness: the book is organized like the web console. A ZIoTC reader does not have that console. Copy the order, not a fake menu. Firewall, OpenVPN, Modbus, and OPC UA are not ZIoTC chapters.

### SICK SIG350

Best pattern for “the device publishes itself.” One operating instruction covers wiring, the web UI, REST, and MQTT. The application developer is told the payload standard and that publishes are periodic or manual. REST and MQTT are two doors to the same device data.

Weakness: the fieldbus chapter is larger than the IoT chapter. ZIoTC’s main job is the RFID data, so RFID should not sit in an appendix behind a fieldbus.

## 5. Practices to keep

- Start with power, identity, and one successful publish. Opto’s in-the-box sheet and Moxa’s chapter 2 do this. The MQTT theory comes after.
- Put each destination in its own chapter after one shared connection chapter. Moxa does this for generic MQTT, AWS, and Azure.
- Keep certificates next to the connection that uses them, and also give them one security chapter. Advantech shows that Azure does not use the same fields as a generic broker.
- Split hardware installation from the communication guide when the hardware book would bury MQTT. Siemens and Red Lion show the failure mode: a hardware book with no broker chapter.
- Write troubleshooting as symptoms that point back to the setup chapter. Do not paste the setup procedure again.
- Many devices are documented as “repeat this on the next unit” or “load the same image.” A fleet controller is a different product. Teltonika RMS and Moxa DLM are those vendors’ cloud services, not part of the device manual’s device behavior.

## 6. Recommended ZIoTC table of contents

Roles are a second way in. The chapter order is the journey. Each page is written once.

Who starts where:

| Role | Start at |
|---|---|
| Solution architect | 1 and 5 |
| IT administrator or network engineer | 3, 4, and 8 |
| System integrator | 2, 6, and 7 |
| Application developer | 2, 9, and 15 |
| Cloud or DevOps engineer | 5 and 8 |
| Operations or support engineer | 10, 11, and 12 |

1. Plan the architecture
   - What the IoT Connector does
   - Which reader you have
   - How the reader, broker, and application fit together
   - How commands, responses, and events differ
   - How an operating mode shapes tag data
   - How configuration is saved

2. Getting started
   - What you need
   - Confirm the reader
   - Read your first tag over MQTT

3. Prepare the network
   - Understand network configuration
   - View network interfaces
   - Configure IP addressing
   - Configure Ethernet
   - Discover Wi-Fi networks
   - Configure Wi-Fi
   - Configure cellular
   - Use the reader as an access point
   - Connect over a Bluetooth network

4. Sign in and set the site
   - Sign in with local REST
   - Set region, time, and name

5. Connect a destination
   - Understand endpoint configuration
   - Configure an MQTT broker
   - Configure AWS IoT
   - Configure Azure IoT
   - Configure Google Cloud IoT
   - Configure an HTTP POST destination
   - Configure a WebSocket, TCP server, or keyboard connection
   - Configure batching and retention

6. Operate the reader
   - Set the operating mode
   - Set antennas and transmit power
   - Start and stop reading
   - Choose which tags and fields are reported
   - Read and write tag memory
   - Use Impinj Gen2X
   - Change RF preselection
   - Run a BLE scan

7. Receive data
   - Receive tag data events
   - Receive BLE data events

8. Secure the connection
   - Install certificates
   - Secure a connection
   - Change the local password

9. Integrate an application
   - Send a command and match the response
   - Call local REST
   - Handle management events
   - Build on the workflows: first tag, portal, conveyor, RFID and BLE apart

10. Deploy more than one reader
    - Repeat one reader’s setup on the next reader
    - What these contracts do not define for a fleet

11. Monitor and maintain
    - Turn on heartbeats and alerts
    - Check reader health
    - Respond to errors and warnings
    - Read logs
    - Update or restart the reader
    - Use GPIO and the application LED
    - Use the display and stack light
    - Install and run a user application

12. Troubleshoot
    - Start from what you can see
    - The reader does not answer
    - Commands or events do not arrive
    - Tag reads are missing or poor
    - BLE data does not arrive
    - A panel, application, or update failed

13. API reference
    - Authentication, control, Impinj Gen2X, system, network, region, date and time, certificates, GPIO, LED, display, logs, firmware, user applications, BLE, management events, tag data events, BLE data events

## 7. Gaps that need engineering validation

Do not write these as device behavior until engineering confirms them. They are absent from the FXR60/FXR90 contracts, and the comparison manuals do not fill a Zebra-specific fact.

- Power wiring, LED meaning, and a default IP address. Moxa and Opto publish these. The FXR contracts start after the reader answers.
- A web console. Comparison devices use one. ZIoTC’s local door in the contracts is REST, not a documented console.
- A required topic layout, last will, retained messages, duplicate command delivery, and command timeouts.
- Whether `set_region` must succeed before `set_mode` accepts transmit power.
- What `get_version` model strings `FX7500`, `FX9600`, and `ATR7000` mean on this software.
- A fleet controller, tenant, or shared credential model. Comparison vendors that have one document it as a separate service.
- Factory reset. Ewon and Phoenix Contact document it. The FXR contracts do not.
- Firewall rules and which outbound ports the reader requires. Teltonika and Moxa document this for their devices. The FXR contracts do not.
- Token lifetime for the local REST bearer token.
