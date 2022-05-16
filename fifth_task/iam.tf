resource "aws_iam_instance_profile" "yatsenko_iam" {
  name = "yatsenko_iam"
  role = aws_iam_role.sqs-sns-role.name
}

resource "aws_iam_role" "sqs-sns-role" {
  name = "sqs-sns-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
  EOF
}

resource "aws_iam_role_policy" "s3_" {
  name = "s3"
  role = aws_iam_role.sqs-sns-role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
     {
        "Action": [
          "s3:GetObject"
        ],
        "Effect": "Allow",
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": "sqs:*",
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": "sns:*",
        "Resource": "*"
      }
    ]
}
  EOF
}
