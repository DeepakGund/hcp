provider "aws" {
  region = "us-west-2"
}

variable "vpc_id" {
  default = "vpc-0e82420fb68e6585c"
}

variable "instance_name" {
  default = ["jenkins.server", "Tomcat", "Nexus", "4"]
}

resource "aws_instance" "ec2" {
  count                  = 4
  ami                    = "ami-022b9b4e935404526"
  instance_type          = "t2.medium"
  key_name               = "us-west-02"
  vpc_security_group_ids = ["sg-0d890a3779134bcbe"]
  subnet_id              = "subnet-0b1be3912a15fbacc"

  # Add an extra 20 GB volume only for the "Nexus" instance
  dynamic "ebs_block_device" {
    for_each = var.instance_name[count.index] == "Nexus" ? [1] : []
    content {
      device_name = "/dev/sdf"  # Device name for the additional volume
      volume_size = 20          # Size of the additional volume in GB
      volume_type = "gp2"
    }
  }

  tags = {
    Name = var.instance_name[count.index]
  }
}
