#!/bin/sh

sudo apt update -y

sudo apt install wget apt-transport-https curl gnupg2 -y

# Installation Of Java
sudo apt install openjdk-11-jdk -y
java -version

# Installation of elasticsearch
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt update -y
sudo apt install elasticsearch -y
sudo systemctl start elasticsearch
sudo systemctl enable elasticsearch


# elasticsearch status check

curl -X GET "localhost:9200"

# Installation of kibana
sudo apt install kibana -y
sudo systemctl start kibana
sudo systemctl enable kibana

# Installation of NGiNX
sudo apt install nginx -y
sudo mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak

# Installation of logstash
sudo apt install logstash -y


sudo -u logstash /usr/share/logstash/bin/logstash --path.settings /etc/logstash -t
sudo systemctl start logstash
sudo systemctl enable logstash


# Installation of filebeat
sudo apt install filebeat -y
sudo filebeat modules enable system
sudo filebeat setup --pipelines --modules system
sudo filebeat setup --index-management -E output.logstash.enabled=false -E output.elasticsearch.hosts=["localhost:9200"]
sudo filebeat setup -E output.logstash.enabled=false -E output.elasticsearch.hosts=['localhost:9200'] -E setup.kibana.host=localhost:5601
sudo systemctl start filebeat
sudo systemctl enable filebeat

sudo mv ~/default /etc/nginx/sites-available/
sudo mv ~/02-beats-input.conf /etc/logstash/conf.d/
sudo mv ~/30-elasticsearch-output.conf /etc/logstash/conf.d/
sudo systemctl restart nginx.service
