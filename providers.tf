terraform {
  provider {
    nutanix = {
      source  = "nutanix/nutanix"
      version = ">=1.4.1"
    }
  }
}

provider "nutanix" {
  username     = var.user
  password     = var.password
  endpoint     = var.endpoint
  insecure     = true
  wait_timeout = 60
}


terraform {
  provider {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
