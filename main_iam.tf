resource "aws_iam_role_policy" "test-lambda-ddb-access" {
  name = "test-lambda-ddb-access"
  role = aws_iam_role.test-lambda-role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "dynamodb:GetShardIterator",
          "dynamodb:DescribeStream",
          "dynamodb:GetRecords"
        ],
        "Resource" : "arn:aws:dynamodb:*:*:table/*/stream/*"
      },
      {
        "Sid" : "VisualEditor1",
        "Effect" : "Allow",
        "Action" : [
          "lambda:InvokeFunction",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "VisualEditor2",
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogStream",
          "dynamodb:PutItem",
          "logs:CreateLogGroup",
          "logs:PutLogEvents"
        ],
        "Resource" : [
          "arn:aws:dynamodb:*:*:table/*",
          "arn:aws:logs:*:*:*"
        ]
      },
      {
        "Sid" : "VisualEditor3",
        "Effect" : "Allow",
        "Action" : "dynamodb:ListStreams",
        "Resource" : "arn:aws:dynamodb:*:*:table/*/stream/*"
      }
    ]
  })
}

resource "aws_iam_role" "test-lambda-role" {
  name = "test-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}
