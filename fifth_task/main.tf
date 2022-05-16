provider "aws" {
  access_key = "AKIA2OB26KJBVD6VKJIZ"
  secret_key = "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"
  region = "us-east-1"

}

# Create a Security Group for an EC2 instance
resource "aws_security_group" "ec2-sec-sqs-sns" {
  name = "ec2-sec-sqs-sns"
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
    Name = "ec2-security"
  }
}



resource "aws_instance" "ec2" {
  ami			          = var.instance_ami
  instance_type           = var.instance_type
  key_name = "ec2_instance"
  vpc_security_group_ids  = [aws_security_group.ec2-sec-sqs-sns.id]
  iam_instance_profile   = aws_iam_instance_profile.yatsenko_iam.name

}

resource "aws_sns_topic" "sns" {
  name = "sns"
}

resource "aws_sqs_queue" "sqs" {
  name = "sqs"
}


