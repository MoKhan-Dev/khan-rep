provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "Amazon-Linux2-Server" {
  count         = 1
  ami           = "ami-07761f3ae34c4478d"
  instance_type = "t2.micro"
  key_name      = "awslinux"
  tags = {
    Name = "Amazon-Linux2-VM"
}

user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl start httpd
    sudo systemctl enable httpd
    sudo yum install firewalld -y
    sudo systemctl start firewalld
    sudo systemctl enable firewalld
    sudo firewall-cmd --permanent --add-service=http
    sudo firewall-cmd --reload
    sudo echo "This is for hostname $(hostname -f)" > /var/www/html/index.html
  EOF
  }

# resource for RHEL with httpd server
resource "aws_instance" "RHEL-Server-HTTPD" {
  count         = 2
  ami           = "ami-0fe630eb857a6ec83"
  instance_type = "t2.micro"
  key_name      = "ubuntu"
  tags = {
    Name = "RHEL-Server-HTTPD"
  }
  user_data = <<-EOF
    #!/bin/bash
    sudo dnf install httpd -y
    sudo systemctl start httpd
    sudo systemctl enable httpd
    sudo yum install firewalld -y
    sudo systemctl start firewalld
    sudo firewall-cmd --permanent --add-service=http
    sudo firewall-cmd --reload
    sudo echo "This is for RHEL hostname $(hostname -f)" > /var/www/html/index.html
  EOF
}

resource "aws_security_group" "Allow_HTTP_and_SSH" {

  name = "Allow_HTTP_and_SSH"
  ingress {
    description = "http"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ssh"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}