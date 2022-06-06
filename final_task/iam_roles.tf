resource "aws_iam_role" "ec2_access_role_week6" {
  name = "ec2_access_role_week6"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Sid       = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "just some tag"
  }
}

resource "aws_iam_instance_profile" "ec2_profile_week6_7" {
  name = "ec2_profile_week6_7"
  role = aws_iam_role.ec2_access_role_week6.name
}
resource "aws_iam_role_policy" "s3_get_object_access_policy" {
  name = "s3_get_object_access_policy"
  role = aws_iam_role.ec2_access_role_week6.id

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

resource "aws_iam_role_policy" "dynamodb_access_policy" {
  name = "dynamodb_access_policy"
  role = aws_iam_role.ec2_access_role_week6.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "SpecificTable",
        "Effect" : "Allow",
        "Action" : [
          "dynamodb:*"
        ],
        "Resource" : "arn:aws:dynamodb:us-west-2:532442580831:table/*"
      }
    ]
  })
}

resource "aws_iam_role_policy" "rds_access_policy" {
  name = "rds_access_policy"
  role = aws_iam_role.ec2_access_role_week6.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "SpecificTable",
        "Effect" : "Allow",
        "Action" : [
          "rds-db:*"
        ],
        "Resource" : "arn:aws:rds-db:us-west-2:532442580831:dbuser:*/*"
      }
    ]
  })
}

resource "aws_iam_role_policy" "sns_access_policy" {
  name = "sns_access_policy"
  role = aws_iam_role.ec2_access_role_week6.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "sns:Publish",
          "sns:CreateTopic"
        ],
        "Effect" : "Allow",
        "Resource" : "arn:aws:sns:us-west-2:532442580831:edu-lohika-training-aws-sns-topic"
      }
    ]
  })
}

resource "aws_iam_role_policy" "sqs_access_policy" {
  name = "sqs_access_policy"
  role = aws_iam_role.ec2_access_role_week6.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:GetQueueUrl"
        ],
        "Effect" : "Allow",
        "Resource" : "arn:aws:sqs:us-west-2:532442580831:edu-lohika-training-aws-sqs-queue"
      }
    ]
  })
}
