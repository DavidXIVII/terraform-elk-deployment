# AWS Instance Deployment

resource "aws_instance" "elk_server" {
  ami                    = "ami-0c9354388bb36c088"
  instance_type          = var.instance
  key_name               = var.key
  vpc_security_group_ids = [aws_security_group.elk.id]

  tags = {
    Name = var.instance_name
  }

  # Installation Script

  provisioner "file" {
    source      = "./default"
    destination = "default"

    connection {
      host        = self.public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key)
    }
  }

  provisioner "file" {
    source = "./02-beats-input.conf"
    destination = "02-beats-input.conf"

    connection {
      host        = self.public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key)
    }
  }

  provisioner "file" {
    source = "./30-elasticsearch-output.conf"
    destination = "30-elasticsearch-output.conf"

    connection {
      host        = self.public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key)
    }
  }

  provisioner "remote-exec" {
    script = "${path.module}/script.sh"

    connection {
      host        = self.public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key)
    }
  }
}
