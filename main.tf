provider "aws" {
  region = "us-west-2"
}

variable "vpc_id" {
  default = "vpc-0e82420fb68e6585c"
}

variable "instance_name" {
  default = ["jenkins.server", "Tomcat", "Nesus", "4"]
}

resource "aws_instance" "ec2" {
  count                  = 4
  ami                    = "ami-022b9b4e935404526"
  instance_type          = "t2.medium"
  key_name               = "us-west-02"
  vpc_security_group_ids = ["sg-0d890a3779134bcbe"]
  subnet_id              = "subnet-0b1be3912a15fbacc"

  root_block_device {
    volume_size = 20  # Set the root volume size to 20 GB
    volume_type = "gp2"  # Optional: Choose volume type (gp2, gp3, io1, etc.)
  }

  tags = {
    Name = var.instance_name[count.index]
  }
}
