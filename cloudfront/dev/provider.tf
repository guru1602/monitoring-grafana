terraform {
  required_version = ">= 0.13"
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "1.28.2"
    }
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {}
}
