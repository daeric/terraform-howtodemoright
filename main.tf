terraform {
  cloud {
    organization = "daeric"

    workspaces {
      name = "Nutanix"
    }
  }
}

data "nutanix_cluster" "cluster" {
  name = var.cluster_name
}
data "nutanix_subnet" "subnet" {
  subnet_name = var.subnet_name
}

resource "nutanix_image" "Server_2019_Image" {
  name        = "Server 2019 Image"
  source_uri  = "http://10.0.0.10/software/server2019.qcow2"
}

resource "nutanix_virtual_machine" "Windows_2019" {
  name                 = "Windows 2019"
  cluster_uuid         = data.nutanix_cluster.cluster.id
  num_vcpus_per_socket = "2"
  num_sockets          = "1"
  memory_size_mib      = 8192

  disk_list {
    data_source_reference = {
      kind = "image"
      uuid = nutanix_image.Server_2019_Image.id
    }
  }

  nic_list {
    subnet_uuid = data.nutanix_subnet.subnet.id
  }
}