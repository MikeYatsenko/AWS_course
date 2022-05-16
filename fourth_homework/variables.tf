variable "instance_ami" {
  type = string
  default = "ami-785db401"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "dynamo_table_name" {
  type        = string
  default     = "aws-employees"
}