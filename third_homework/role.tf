resource "aws_iam_role_policy" "s3" {
  name = "s3"
  role = aws_iam_role.ec2_s3.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "s3:GetObject"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2" {
  name = "ec2"
  role = aws_iam_role.ec2_s3.name
}

resource "aws_iam_role" "ec2_s3" {
  name = "ec2_s3"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}