variable "function_name" {}

variable "lambda_role_arn" {}

variable "endpoint_name" {}

resource "aws_lambda_function" "lambda" {
  filename         = data.archive_file.lambda.output_path
  source_code_hash = data.archive_file.lambda.output_base64sha256
  function_name    = var.function_name
  role             = var.lambda_role_arn
  handler          = "lambda_function.lambda_handler"

  runtime     = "python3.8"
  memory_size = 128
  timeout     = 30

  environment {
    variables = {
      ENDPOINT_NAME = var.endpoint_name
    }
  }
}

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "${path.module}/src/"
  output_path = "${path.module}/upload/lambda_function.zip"
}

output "lambda_invoke_arn" {
  value = aws_lambda_function.lambda.invoke_arn
}
