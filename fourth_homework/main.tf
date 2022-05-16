provider "aws" {
  access_key = "AKIA2OB26KJBVD6VKJIZ"
  secret_key = "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"
  region = "us-east-1"

}

# Create a Security Group for an EC2 instance
resource "aws_security_group" "ec2-security" {
  name = "ec2-security"
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

resource "aws_security_group" "rds-security" {
  name        = "rds-security"
  description = "Connection to RDS"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance
resource "aws_instance" "ec2_instance" {
  ami			          = var.instance_ami
  instance_type           = var.instance_type
  key_name = "ec2_instance"
  vpc_security_group_ids  = [aws_security_group.ec2-security.id]
  iam_instance_profile   = aws_iam_instance_profile.yatsenko_iam.name
  user_data              = <<EOF
  		#! /bin/bash
  	   sudo amazon-linux-extras install postgresql13
       aws s3api get-object --bucket yatsenko-3-bucket --key rds-script.sql rds-script.sql
       aws s3api get-object --bucket yatsenko-3-bucket --key dynamodb-script.sh dynamodb-script.sh
  	EOF

}

# Create an RDS instance

resource "aws_db_instance" "yatsenko_3" {
  allocated_storage      = 10
  engine                 = "postgres"
  engine_version         = "13.5"
  username               = "yatsenko"
  password               = "yatsenko"
  skip_final_snapshot    = true
  instance_class         = "db.t4g.small"
  vpc_security_group_ids = [aws_security_group.rds-security.id]
}


# Create an Dynamo DB instance
resource "aws_dynamodb_table" "aws-employees" {
  name           = var.dynamo_table_name
  hash_key       = "id"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "id"
    type = "S"
  }

}

output "public_ip" {
  value = element(aws_instance.ec2_instance.*.public_ip,0)
}

output "rds" {
  value = aws_db_instance.yatsenko_3.endpoint
}