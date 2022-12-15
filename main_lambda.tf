locals { #declaring local variables
  lambda_zip_location = "output/lambda-function.zip"
}

resource "aws_lambda_function" "resume-lambda-function" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = local.lambda_zip_location
  function_name = "resume-lambda-function"
  role          = aws_iam_role.test-lambda-role.arn

  handler = "lambda-function.handler"
  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  # source_code_hash = filebase64sha256("lambda_function_payload.zip")

  runtime = "nodejs16.x"

} 

data "archive_file" "lambda-archive" {
  type        = "zip"
  source_file = "lambda-function.js"
  output_path = local.lambda_zip_location
}

resource "aws_lambda_permission" "allow_api_gateway" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.resume-lambda-function.function_name
  principal     = "apigateway.amazonaws.com"
}

