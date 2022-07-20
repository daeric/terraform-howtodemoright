terraform {
  required_providers {
    nutanix = {
      source = "nutanix/nutanix"
      version = ">=1.6.0"
    }
  }
}

provider "nutanix" {
  username            = var.user
  password            = var.password
  endpoint            = var.endpoint
  port                = 9440
  insecure            = true
  wait_timeout        = 10
  foundation_endpoint = var.foundation_endpoint
  foundation_port     = var.foundation_port
}
