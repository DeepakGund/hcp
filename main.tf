provider "aws" {
  region = "us-west-2"
}

variable "vpc_id" {
  default = "vpc-0e82420fb68e6585c"
}

variable "instance_name" {
  default = ["jenkins.server", "tomcat", "3", "4"]
}

resource "aws_instance" "ec2" {
  count           = 4
  ami             = "ami-022b9b4e935404526"
  instance_type   = "t2.medium"
  key_name        = "us-west-02"
  vpc_security_group_ids = ["sg-0d890a3779134bcbe"]
  
  subnet_id       = var.vpc_id  # Adding the VPC ID to associate the instances with the specified VPC

  tags = {
    Name = var.instance_name[count.index]
  }
}
