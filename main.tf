module "sagemaker_role" {
  source = "./modules/iam"

  name       = "sagemaker"
  identifier = "sagemaker.amazonaws.com"
  policy     = data.aws_iam_policy.sagemaker_role_policy.policy
}

data "aws_iam_policy" "sagemaker_role_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
}

module "lambda_role" {
  source = "./modules/iam"

  name       = "lambda"
  identifier = "lambda.amazonaws.com"
  policy     = data.aws_iam_policy_document.lambda_policy_doc.json
}

data "aws_iam_policy_document" "lambda_policy_doc" {
  statement {
    effect  = "Allow"
    actions = ["sagemaker:InvokeEndpoint"]
    resources = [
      "arn:aws:sagemaker:${var.aws_region}:${data.aws_caller_identity.self.account_id}:endpoint/*"
    ]
  }

  statement {
    effect  = "Allow"
    actions = ["logs:CreateLogGroup"]
    resources = [
      "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.self.account_id}:*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.self.account_id}:log-group:/aws/lambda/${var.function_name}:*"
    ]
  }
}

data "aws_caller_identity" "self" {}

module "lambda" {
  source = "./modules/lambda"

  function_name   = var.function_name
  lambda_role_arn = module.lambda_role.iam_role_arn
  endpoint_name   = var.endpoint_name
}

module "apigateway" {
  source = "./modules/apigateway"

  function_name     = var.function_name
  api_gateway_name  = var.api_gateway_name
  lambda_invoke_arn = module.lambda.lambda_invoke_arn
}

module "sagemaker" {
  source = "./modules/sagemaker"

  model_name         = var.model_name
  model_role_arn     = module.sagemaker_role.iam_role_arn
  image              = var.image
  model_data_url     = var.model_data_url
  endpoint_config_name = var.endpoint_config_name
  endpoint_name        = var.endpoint_name
}

output "base_url" {
  value = module.apigateway.base_url
}
