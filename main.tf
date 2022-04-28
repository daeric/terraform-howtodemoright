data "nutanix_cluster" "cluster" {
  name = var.cluster_name
}
data "nutanix_subnet" "subnet" {
  subnet_name = var.subnet_name
}

resource "nutanix_virtual_machine" "PROD" {
  name                 = "PROD"
  cluster_uuid         = data.nutanix_cluster.cluster.id
  num_vcpus_per_socket = "4"
  num_sockets          = "1"
  memory_size_mib      = 8192
  
  categories {
    name   = "Environment"
    value  = "Production"
  }

  disk_list {
    data_source_reference = {
      kind = "image"
      uuid = "76e051a4-82d7-49fd-accf-6d026fdc6475"
    }
  }

  nic_list {
    subnet_uuid = data.nutanix_subnet.subnet.id
  }
}

resource "nutanix_virtual_machine" "DEV" {
  name                 = "DEV"
  cluster_uuid         = data.nutanix_cluster.cluster.id
  num_vcpus_per_socket = "4"
  num_sockets          = "1"
  memory_size_mib      = 8192
  
  categories {
    name   = "Environment"
    value  = "Dev"
  }

  disk_list {
    data_source_reference = {
      kind = "image"
      uuid = "76e051a4-82d7-49fd-accf-6d026fdc6475"
    }
  }

  nic_list {
    subnet_uuid = data.nutanix_subnet.subnet.id
  }
}

/*
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
*/
