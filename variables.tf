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
  default = "763104351884.dkr.ecr.ap-northeast-1.amazonaws.com/huggingface-pytorch-inference:1.10.2-transformers4.17.0-cpu-py38-ubuntu20.04"
}

variable "model_data_url" {
  default = "s3://sagemaker-ap-northeast-1-394436824645/opt/ml/model/model.tar.gz"
}

variable "endpoint_config_name" {
  default = "expedite-commerce-endpoint-config"
}

variable "endpoint_name" {
  default = "expedite-commerce-endpoint"
}
