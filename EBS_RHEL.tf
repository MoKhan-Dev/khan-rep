resource "aws_instance" "RHEL1" {
  count         = 1
  ami           = "ami-0fe630eb857a6ec83"
  instance_type = "t2.medium"
  key_name      = "red hat"
  availability_zone = "us-east-1a"
  tags = {
    Name = "RHEL-VM1"
  }
}

resource "aws_ebs_volume" "st1_volume" {
  availability_zone = "us-east-1a"
  type = "st1"
  size = 150
  tags = {
    Name = "ST1_VOLUME"
  }
}

resource "aws_volume_attachment" "ebs_st1" {
  device_name = "/dev/sdj"
  volume_id = "vol-0a8bc131b530184d8"
  instance_id = "i-077e94f5f31d17d18"
}

resource "aws_ebs_volume" "gp2_volume" {
  availability_zone = "us-east-1a"
  type = "gp2"
  size = 8
  tags = {
    Name = "GP2_VOLUME"
  }
}

resource "aws_volume_attachment" "ebs_gp2" {
  device_name = "/dev/sdh"
  volume_id = "vol-0863e4a5ed6a2ff1b"
  instance_id = "i-077e94f5f31d17d18"
}

resource "aws_ebs_snapshot" "gp2_snapshot" {
  volume_id = "vol-0863e4a5ed6a2ff1b"
  tags = {
    Name = "GP2_SNAPSHOT"
  }
}






