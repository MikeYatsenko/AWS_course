resource "aws_iam_role_policy" "s3_1" {
  name = "s3_1"
  role = aws_iam_role.ec2_s3_iam_instance_1.id

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

resource "aws_iam_instance_profile" "ec2_13" {
  name = "ec2_13"
  role = aws_iam_role.ec2_s3_iam_instance_1.id
}

resource "aws_iam_role" "ec2_s3_iam_instance_1" {
  name = "ec2_s3_iam_instance_1"

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