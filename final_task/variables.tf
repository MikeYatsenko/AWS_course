variable "public-1-az" {
  type    = string
  default = "us-west-2a"
}

variable "public-2-az" {
  type    = string
  default = "us-west-2b"
}

variable "private-1-az" {
  type    = string
  default = "us-west-2b"
}

variable "private-2-az" {
  type    = string
  default = "us-west-2c"
}

variable "vpc-cidr-block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public-1-cidr-block" {
  type    = string
  default = "10.0.1.0/24"
}

variable "public-2-cidr-block" {
  type    = string
  default = "10.0.2.0/24"
}

variable "private-1-cidr-block" {
  type    = string
  default = "10.0.3.0/24"
}

variable "private-2-cidr-block" {
  type    = string
  default = "10.0.4.0/24"
}

variable "image_id" {
  type    = string
  default = "ami-a0cfeed8"
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "nat-image_id" {
  type    = string
  default = "ami-a0cfeed8"
}

variable "dynamodb_table_name" {
  description = "DynamoDB table"
  type        = string
  default     = "edu-lohika-training-aws-dynamodb"
}

variable "rds_db_name" {
  description = "RDS DB name"
  type        = string
  default     = "EduLohikaTrainingAwsRds"
}