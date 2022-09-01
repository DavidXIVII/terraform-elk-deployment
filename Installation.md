## Edits Before Hand
- Set the Variables.tf file to meet your own requirements.
	* AWS Region
	* AWS Key
 * AWS Instance Type
 * AWS Instance Name
 - AWS Private Key Path

After Terraform deployed your server with all its dependencies.

#1 - Enable Security Parameters In Elasticsearch
sudo nano /etc/elasticsearch/elasticsearch.yml
Add in the security section:
xpack.security.enabled: true
xpack.security.authc.api_key.enabled: true


#2 - Generate Passwords For Secured Connection
sudo cd /usr/share/elasticsearch/
./bin/elasticsearch-setup-passwords interactive # Generate Passcodes (Write Them)

#3 - Edit kibana with your elasticsearch credentials for kibana
sudo nano /etc/kibana/kibana.yml
Edit these 2 lines:
elasticsearch.username: "kibana_system" (Defualt)
elasticsearch.passowrd: [MY_KIBANA_SYSTEM_PASSWORD] (Generated Before)
sudo systemctl restart kibana



#4 - Create A Fleet Server
http://<host-ip:port>/app/fleet/agents ; # you can create one on your local machine

Later at the fleet platform you can launch an agent using the link provided by the
fleet manager, and run the command provided.

## Note - Joinning an agent to fleet:
In the command line add --insecure due to us not working under a secure connection.
