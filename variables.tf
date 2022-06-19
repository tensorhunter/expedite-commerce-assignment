variable "aws_region" {
  default = "ap-northeast-1"
}

variable "function_name" {
  default = "expedite-commerce-lambda"
}

variable "api_gateway_name" {
  default = "expedite-commerce-api-gateway"
}

variable "model_name" {
  default = "expedite-commerce"
}

variable "image" {
  default = "305705277353.dkr.ecr.us-east-1.amazonaws.com/decision-trees-sample:latest"
}

variable "model_data_url" {
  default = "s3://sagemaker-ap-northeast-1-394436824645/nodels/model.tar.gz"
}

variable "endpoint_config_name" {
  default = "expedite-commerce-endpoint-config"
}

variable "endpoint_name" {
  default = "expedite-commerce-endpoint"
}
