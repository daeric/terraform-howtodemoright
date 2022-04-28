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
