############################## LOCALS ################################
locals {
  common_tags = {
    BillingCode = var.billing_code_tag
    Environment = var.environment_tag
  }

}


######################## DATA ###################################################################

data "aws_availability_zones" "available" {}


data "aws_ami" "aws-linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


########################### RESOURCES  ######################################



resource "aws_default_vpc" "default" {
}

resource "aws_security_group" "allow_ssh" {
  name        = "test_sg_002"
  description = "Allow HTTP and SSH ports for myserver"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "myserver" {
  ami                    = data.aws_ami.aws-linux.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  
  # connection block used by the external provisionner to connect to the instance 
  # as ssh and execute the script you gave it
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)

  }

  ##local-exec is possible if u want this machine to be the executer
  provisioner "remote-exec" {
    inline = [
      "sudo yum install nginx -y",
      "sudo service nginx start"
    ]
  }
  
}