# Security Group Deployment

resource "aws_security_group" "elk" {
  name_prefix = "elk"
  description = "Secuity Group for ELK"

  # proxy_pass to Kibana

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP Redirection To Kibana"
  }

  # proxy_pass to ElasticSearch

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP Redirection To ElasticSearch"

  }
  # Fleet Server Port

  ingress {
    from_port   = 8220
    to_port     = 8220
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Fleet Server"
  }

  # ElasticSearch Port (Depreceated - We are using nginx - to be deleted)

  ingress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Elasticsearch"
  }

  # Logstash port

  ingress {
    from_port   = 5043
    to_port     = 5044
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Logstash"
  }

  # Kibana port (Depreceated - We are using nginx - to be deleted)

  ingress {
    from_port   = 5601
    to_port     = 5601
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Kibana"
  }

  # SSH port

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Enables SSH Connection"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
