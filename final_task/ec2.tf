resource "aws_instance" "ec2-nat" {
  ami                    = var.nat-image_id
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.public_1.id
  vpc_security_group_ids = [aws_security_group.public-sg.id]
  source_dest_check     = false
  key_name               = "mike-week6-ssh"

  tags = {
    Name = "ec2-nat"
  }
}


resource "aws_instance" "ec2-private" {
  ami                    = var.image_id
  instance_type          = var.ec2_instance_type
  availability_zone      = var.private-1-az
  subnet_id              = aws_subnet.private_1.id
  vpc_security_group_ids = [aws_security_group.private-sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile_week6_7.name
  key_name               = "mike-week6-ssh"
  user_data              = <<EOF
  		#! /bin/bash
        sudo su
        wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-linux-x64.rpm

        sudo yum install -y jdk-8u141-linux-x64.rpm

        aws s3api get-object --bucket testbucketformikeyatsenko21 --key persist3-2021-0.0.1-SNAPSHOT.jar persist3-2021-0.0.1-SNAPSHOT.jar
        export RDS_HOST=${aws_db_instance.rds_db.endpoint}

        java -jar persist3-2021-0.0.1-SNAPSHOT.jar
  	EOF

  tags = {
    Name = "ec2-private"
  }
}

resource "aws_launch_template" "public-lt" {
  name_prefix            = "public-lt"
  image_id               = var.image_id
  instance_type          = var.ec2_instance_type
  vpc_security_group_ids = [aws_security_group.public-sg.id]
  key_name               = "mike-week6-ssh"
  user_data              = filebase64("${path.module}/user-data.sh")

  iam_instance_profile {
    arn = aws_iam_instance_profile.ec2_profile_week6_7.arn

  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "ec2-public"
    }
  }
}

resource "aws_autoscaling_group" "public-ag" {
  name                = "public-ag"
  max_size            = 2
  min_size            = 2
  vpc_zone_identifier = [aws_subnet.public_1.id, aws_subnet.public_2.id]


  launch_template {
    id      = aws_launch_template.public-lt.id
    version = aws_launch_template.public-lt.latest_version
  }
}