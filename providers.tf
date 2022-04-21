terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    nutanix = {
      source  = "nutanix/nutanix"
      version = ">=1.4.1"
    }
  }  
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Configure the Nutanix Provider
provider "nutanix" {
  username     = var.user
  password     = var.password
  endpoint     = var.endpoint
  insecure     = true
  wait_timeout = 60
}