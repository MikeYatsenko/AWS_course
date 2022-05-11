resource "aws_iam_policy" "bucket_policy" {
  name        = "s3-policy"
  description = "Allow"
  policy = jsonencode({
    "Version" : "2012-10-17",
     "Statement" : [
    {
      "Sid" : "VisualEditor0",
      "Effect" : "Allow",
      "Action" : [
        "s3:PutObject",
        "s3:GetObject",
        "s3:ListBucket",
        "s3:DeleteObject"
      ],
      "Resource" : "*"
    }]})
}

resource "aws_iam_policy" "dynamodb_policy" {
  name = "dynamodb-policy"
  description = "Allow"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement":[{
      "Effect": "Allow",
      "Action": [
      "dynamodb:BatchGet*",
      "dynamodb:DescribeStream",
      "dynamodb:DescribeTable",
      "dynamodb:Get*",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:BatchWrite*",
      "dynamodb:CreateTable",
      "dynamodb:Delete*",
      "dynamodb:Update*",
      "dynamodb:PutItem",
      "dynamodb:List*",
      "dynamodb:DescribeReservedCapacity*",
      "dynamodb:DescribeLimits",
      "dynamodb:DescribeTimeToLive"
      ],
      "Resource": "*"
     }]
  })
}

resource "aws_iam_role" "access_role" {
  name = "acess_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dynamodb_policy" {
  role       = aws_iam_role.access_role.name
  policy_arn = aws_iam_policy.dynamodb_policy.arn
}

resource "aws_iam_role_policy_attachment" "s3_policy" {
  role       = aws_iam_role.access_role.name
  policy_arn = aws_iam_policy.bucket_policy.arn
}

resource "aws_iam_instance_profile" "yatsenko_iam" {
  name = "yatsenko_iam"
  role = aws_iam_role.access_role.name
}
