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
>xpack.security.enabled: true
>
>xpack.security.authc.api_key.enabled: true

```sh
sudo systemctl restart elasticsearch.service
```

## 2 - Generate Passwords For Secured Connection
```sh
cd /usr/share/elasticsearch/
sudo ./bin/elasticsearch-setup-passwords interactive
```
Generate Passcodes (Write Them)

## 3 - Edit kibana with your elasticsearch credentials for kibana
```sh
sudo nano /etc/kibana/kibana.yml
```
Edit these 2 lines: (Note they both are commented with # so uncomment them)

* elasticsearch.username: "kibana_system" (Defualt Kibana username)
* elasticsearch.passowrd: [MY_KIBANA_SYSTEM_PASSWORD] (Generated in [Generate Passwords For Secured Connection](https://github.com/DavidXIVII/terraform-elk-deployment/blob/main/Installation.md#2---generate-passwords-for-secured-connection))

Restart Kibana
```sh
sudo systemctl restart kibana
```

You could also restart Elasticsearch but its not needed.
## 4 - Create A Fleet Server
> http://<elasticsearch-ip:port>/app/fleet/agents

Notice in this installation I'm using the created instnace as Fleet Server as well,

Before initiating your Fleet Server edit Fleet Settings: (You can find the button on the top right section of the webpage)
Under Fleet Server Hosts:
>http://<aws-private-dns-ip>:8220
>example: http://ip-172-31-7-173.eu-central-1.compute.internal:8220

Port 8220 is needed to be open so data can be sent to the server Fleet.

Under Elasticsearh Hosts:
>http://<aws-private-dns-ip>:8080
>example: http://ip-172-31-7-173.eu-central-1.compute.internal:8080

Port 8080 is a redirection to 9200 (Elasticsearh)

Refersh the fleet page or wait few seconds and follow the guidelines.
You'll be promoted to download an agent (just like in [#5 - Join A Node](https://github.com/DavidXIVII/terraform-elk-deployment/blob/main/Installation.md#5---join-a-node-to-the-fleet))

Extracted it & Run the given command prompt.

## 5 - Join A Node To The Fleet
After creating a Fleet you will have a new button "Add Agent".
You can and should follow the instructions promoted there to install the agent on a machine.

Download the Agent (we deployed elasticsearch version 7.17.6) that matches your system:
[Download Agent](https://www.elastic.co/downloads/past-releases/elastic-agent-7-17-6)

How to do it on Linux OS:
```sh
cd ~
wget https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-7.17.6-linux-x86_64.tar.gz -o elastic-agent.tar.gz
tar -xf elastic-agent.tar.gz
cd elastic-agent (!AUTO COMPLETE IT WITH TAB!)

```


Keep in mind due to us not running ELK on a secured https connection at so we will need to run the attachement command,
To be run not secure so we will add --insecure to the yml file we runs on the agents machine.

example:
```sh
sudo ./elastic-agent install --url=<fleet-ip>:<fleet-port> --enrollment-token=<token> -- insecure
```
