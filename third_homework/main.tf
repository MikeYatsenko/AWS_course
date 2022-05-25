provider "aws" {
  region     = "us-east-1"
}
# Create a Security Group for an EC2 instance
resource "aws_security_group" "example-instance-security_1" {
  name = "example-instance-security_1"
  description = "http/ssh connect"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {

    Name = "Security instance"
  }
}

# Create an EC2 instance
resource "aws_instance" "EC2Instance" {
  ami			          = var.instance_ami
  instance_type           = var.instance_type
  vpc_security_group_ids  = [aws_security_group.example-instance-security_1.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_13.name
  user_data = <<-EOF
	         #! /bin/bash
          aws s3api get-object --bucket testbucketformikeyatsenko21 --key sample.txt sample.txt
	        EOF
  key_name = "mike_ssh"
  tags = {
    Name = "terraform-example"
  }
}
