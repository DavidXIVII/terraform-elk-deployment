# Edits Before Hand - DO THIS FIRST!
* Set the Variables.tf file to meet your own requirements.
	* Region
	* Key
	* Instance Type
	* Instance Name
	* Private Key Path

After Terraform deployed your server with all its dependencies.

## 1 - Enable Security Parameters In Elasticsearch
```sh
sudo nano /etc/elasticsearch/elasticsearch.yml
```
Add in the security section:
xpack.security.enabled: true
xpack.security.authc.api_key.enabled: true

## 2 - Generate Passwords For Secured Connection
```sh
sudo cd /usr/share/elasticsearch/
./bin/elasticsearch-setup-passwords interactive
```
Generate Passcodes (Write Them)

## 3 - Edit kibana with your elasticsearch credentials for kibana
```sh
sudo nano /etc/kibana/kibana.yml
```
Edit these 2 lines:

* elasticsearch.username: "kibana_system" (Defualt Kibana username)
* elasticsearch.passowrd: [MY_KIBANA_SYSTEM_PASSWORD] (Generated in [Generate Passwords For Secured Connection](https://github.com/DavidXIVII/terraform-elk-deployment/blob/main/Installation.md#2---generate-passwords-for-secured-connection))

Restart Kibana
```sh
sudo systemctl restart kibana
```

You could also restart Elasticsearch but its not needed.
## 4 - Create A Fleet Server
http://<elasticsearch-ip:port>/app/fleet/agents ; # you can create one on your local machine
In this instllation excessing the AWS Instance Public IP in port 80 granting you access to Elasticsearch

In the command line add --insecure due to us not working under a secure connection.

example:
```sh
sudo ./elastic-agent install --url=<fleet-ip>:<fleet-port> --enrollment-token=<token> -- insecure
```
