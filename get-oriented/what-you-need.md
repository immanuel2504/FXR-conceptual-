# What you need

Before the first command, you need the reader and a path to the API you will use.

**The reader.** An FXR60 or FXR90. Know which one it is. Display and stack-light commands apply to the FXR60 only.

**A network path.** REST is local: the application calls the reader. MQTT is the command, response, and event channel described in the MQTT contract. Pick one for the first session.

**REST credentials.** The REST contract describes two ways into Authorize:

- If you already have a bearer token from the dashboard, send it as `Authorization: Bearer <token>`.
- If you do not, authenticate `GET /cloud/localRestLogin` with the admin login. The response `message` is the bearer token. Copy it into Authorize and send it on later calls. This login is the only REST operation that uses basic authentication. The others expect the bearer token.

**A first read of identity.** `get_version` / `GET /cloud/version` tells you the model, serial number, and component versions. That confirms you are talking to the reader you think you are.

You do not need a tag in the field yet. Identity and status work before inventory starts.

**Related:** [Quick start](../quick-start/index.md) · [Two interfaces](../core-concepts/two-interfaces.md)
