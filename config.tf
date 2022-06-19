terraform {
  required_version = ">= 0.12.6"

  required_providers {
    archive = "~> 1.3.0"
    aws     = "~> 2.43.0"
  }
}

provider "aws" {
  region = var.aws_region
}
