resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc-cidr-block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    name = "VPC"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public-1-cidr-block
  availability_zone       = var.public-1-az
  map_public_ip_on_launch = true

  tags = {
    name = "public_1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var. public-2-cidr-block
  availability_zone       = var.public-2-az
  map_public_ip_on_launch = true

  tags = {
    name = "public_2"
  }
}

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private-1-cidr-block
  availability_zone = var.private-1-az

  tags = {
    name = "private_1"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private-2-cidr-block
  availability_zone = var.private-2-az

  tags = {
    name = "private_2"
  }
}

resource "aws_internet_gateway" "public-gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "public-gw"
  }
}



resource "aws_db_subnet_group" "db-subnet" {
  name       = "db-subnet"
  subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]

  tags = {
    Name = "db-subnet"
  }
}


resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public-gw.id
  }

  tags = {
    Name = "public-route"
  }
}

resource "aws_route_table_association" "public-1-route-table-association" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table_association" "public-2-route-table-association" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table" "private-route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = aws_instance.ec2-nat.id
  }

  tags = {
    Name = "private-route"
  }
}

resource "aws_route_table_association" "private-1-route-table-association" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private-route.id
}

resource "aws_route_table_association" "private-2-route-table-association" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private-route.id
}