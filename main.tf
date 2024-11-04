provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "ec2" {
  count          = 4
  ami            = "ami-022b9b4e935404526"
  instance_type  = "t2.medium"
  key_name       = "us-west-02"  # Corrected the key name attribute
  vpc_security_group_ids = ["sg-0d890a3779134bcbe"]  # Corrected the security group attribute

  tags = {
    Name = var.instance_name[count.index]  # Fixed the variable reference and capitalized "Name" key
  }
}

variable "instance_name" {
  default = ["jenkins.server", "tomcat", "3", "4"]
}
