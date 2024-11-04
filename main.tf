provider "aws" {
  region = "us-west-2"
}

variable "vpc_id" {
  default = "vpc-0e82420fb68e6585c"
}

variable "instance_name" {
  default = ["jenkins.server", "Tomcat-1", "Monitoring_pigin", "Nexus"]
}

resource "aws_instance" "ec2" {
  count                  = 4
  ami                    = "ami-004a0173a724e2261"
  instance_type          = "t2.medium"
  key_name               = "us-west-02"
  vpc_security_group_ids = ["sg-0d890a3779134bcbe"]
  subnet_id              = "subnet-0b1be3912a15fbacc"

  # Set root volume size conditionally for "Nexus"
  root_block_device {
    volume_size = var.instance_name[count.index] == "Nexus" ? 20 : 8  # 20 GB for Nexus, 8 GB for others
    volume_type = "gp2"  # Volume type can be adjusted as needed
  }

  tags = {
    Name = var.instance_name[count.index]
  }
}
