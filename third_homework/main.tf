provider "aws" {
  access_key = "AKIA2OB26KJBVD6VKJIZ"
  secret_key = "q9zQb9QC2JaZSIUJjES/OVX9/kS4BfwlfRapTfzG"
  region = "eu-west-1"

}

# Create a Security Group for an EC2 instance
resource "aws_security_group" "terraform-example-instance-security" {
  name = "terraform-example-instance-security"
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
  ami			                = var.instance_ami
  instance_type           = var.instance_type
  vpc_security_group_ids  = [aws_security_group.terraform-example-instance-security.id]
  user_data = <<-EOF
	      #!/bin/bash
          aws s3api get-object --bucket testbucketformikeyatsenko --key sample.txt sample.txt
	      EOF

  tags = {
    Name = "terraform-example"
  }
}
