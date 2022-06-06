provider "aws" {

  region = "us-west-2"

}



output "lb-dns" {
  value = aws_lb.lb.dns_name
}