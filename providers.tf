terraform {
  backend "remote" {
    organization = "TCW"
    workspaces{
      name = "GO-dev"
    }
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.aws_region
}