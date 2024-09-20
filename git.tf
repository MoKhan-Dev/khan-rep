provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "RHEL1" {
  count         = 1
  ami           = "ami-0fe630eb857a6ec83"
  instance_type = "t2.medium"
  key_name      = "red hat"
  vpc_security_group_ids = [aws_security_group.Allow_HTTP_and_SSH.id]
  tags = {
    Name = "RHEL-VM1"
  }

user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install nano -y
    sudo yum install vim -y
    sudo yum install tree -y
    sudo semanage permissive -a httpd_t 
    sudo yum install git -y
    sudo yum install fontconfig java-17-openjdk -y  
    sudo yum install wget -y
    sudo wget -O /etc/yum.repos.d/jenkins.repo \https://pkg.jenkins.io/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    sudo yum upgrade -y
    sudo yum install jenkins -y
    sudo systemctl daemon-reload
    sudo systemctl start jenkins
    sudo systemctl enable jenkins
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
  ingress {
    description = "jenkins"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "All traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]   
  }
}