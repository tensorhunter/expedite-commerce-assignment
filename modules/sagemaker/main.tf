variable "model_name" {}

variable "model_role_arn" {}

variable "image" {}

variable "model_data_url" {}

variable "endpoint_config_name" {}

variable "endpoint_name" {}

resource "aws_sagemaker_model" "model" {
  name               = "${var.model_name}-${uuid()}"
  execution_role_arn = var.model_role_arn

  primary_container {
    image          = var.image
    model_data_url = var.model_data_url
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = ["name"]
  }
}

resource "aws_sagemaker_endpoint_configuration" "ec" {
  name = "${var.endpoint_config_name}-${uuid()}"

  production_variants {
    variant_name           = "variant-a"
    model_name             = aws_sagemaker_model.model.name
    instance_type          = "ml.t2.medium"
    initial_instance_count = 1
    initial_variant_weight = 1
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = ["name"]
  }
}

resource "aws_sagemaker_endpoint" "endpoint" {
  name                 = var.endpoint_name
  endpoint_config_name = aws_sagemaker_endpoint_configuration.ec.name
}
