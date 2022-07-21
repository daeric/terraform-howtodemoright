#Provider info
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

#Import image
resource "nutanix_image" "Ubuntu" {
  name        = "Ubuntu"
  source_uri  = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}

#Create VMs
resource "nutanix_virtual_machine" "PROD" {
  name                 = "PROD"
  cluster_uuid         = data.nutanix_cluster.cluster.id
  num_vcpus_per_socket = "2"
  num_sockets          = "1"
  memory_size_mib      = 2048

  guest_customization_cloud_init_user_data = base64encode(templatefile("${path.module}/resources/cloud-init/apache.tpl", { hostname = "PROD" }))
  
  disk_list {
    data_source_reference = {
      kind = "image"
      uuid = nutanix_image.Ubuntu.id
    }
  }

  disk_list {
    disk_size_mib   = 100000
    disk_size_bytes = 104857600000
  }

  disk_list {
    disk_size_bytes = 0

    data_source_reference = {}

    device_properties {
      device_type = "CDROM"
      disk_address = {
        device_index = "1"
        adapter_type = "SATA"
      }
    }
  }

  categories {
    name   = "Environment"
    value  = "Production"
  }

  nic_list {
    subnet_uuid = data.nutanix_subnet.subnet.id
  }

  nutanix_guest_tools = {
    state           = "ENABLED",
    iso_mount_state = "MOUNTED"
  }

   ngt_enabled_capability_list = [
    "SELF_SERVICE_RESTORE",
    "VSS_SNAPSHOT"
  ]
}


resource "nutanix_virtual_machine" "DEV" {
  name                 = "DEV"
  cluster_uuid         = data.nutanix_cluster.cluster.id
  num_vcpus_per_socket = "2"
  num_sockets          = "1"
  memory_size_mib      = 2048

  guest_customization_cloud_init_user_data = base64encode(templatefile("${path.module}/resources/cloud-init/apache.tpl", { hostname = "DEV" }))
  
  disk_list {
    data_source_reference = {
      kind = "image"
      uuid = nutanix_image.Ubuntu.id
    }
  }

  disk_list {
    disk_size_mib   = 100000
    disk_size_bytes = 104857600000
  }

  disk_list {
    disk_size_bytes = 0

    data_source_reference = {}

    device_properties {
      device_type = "CDROM"
      disk_address = {
        device_index = "1"
        adapter_type = "SATA"
      }
    }
  }

  categories {
    name   = "Environment"
    value  = "Dev"
  }

  nic_list {
    subnet_uuid = data.nutanix_subnet.subnet.id
  }

  nutanix_guest_tools = {
    state           = "ENABLED",
    iso_mount_state = "MOUNTED"
  }

   ngt_enabled_capability_list = [
    "SELF_SERVICE_RESTORE",
    "VSS_SNAPSHOT"
  ]
}

#Create Isolation Policy
resource "nutanix_network_security_rule" "isolation" {
    name        = "isolate-prod-from-dev"
    description = "Isolate Production from Dev"

    isolation_rule_action = "APPLY"

    isolation_rule_first_entity_filter_kind_list = ["vm"]
    isolation_rule_first_entity_filter_type      = "CATEGORIES_MATCH_ALL"
    isolation_rule_first_entity_filter_params {
        name   = "Environment"
        values = ["Production"]
    }

    isolation_rule_second_entity_filter_kind_list = ["vm"]
    isolation_rule_second_entity_filter_type      = "CATEGORIES_MATCH_ALL"
    isolation_rule_second_entity_filter_params {
        name   = "Environment"
        values = ["Dev"]
    }
}
