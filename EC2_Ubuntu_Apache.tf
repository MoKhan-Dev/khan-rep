provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "Ubuntu_1" {
  count         = 1
  ami           = "ami-07d9b9ddc6cd8dd30"
  instance_type = "t2.medium"
  key_name      = "ubuntu"
  tags = {
    Name = "Ubuntu-VM"
 }

user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo apt-get install apache2 -y
    sudo ufw allow 'Apache'
    sudo ufw enable -y
    sudo echo "This is for hostname $(hostname -f)" > /var/www/html/index.html
  EOF
}

resource "aws_security_group" "Allow-HTTP" {

  name = "Allow-HTTP"
  ingress {
    description = "http"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}