data "nutanix_cluster" "cluster" {
  name = var.cluster_name
}
data "nutanix_subnet" "subnet" {
  subnet_name = var.subnet_name
}

resource "nutanix_image" "CentOS" {
  name        = "CentOS"
  source_uri  = "http://10.0.0.10/software/centos.qcow2"
}

resource "nutanix_virtual_machine" "VM1" {
  name                 = "VM1"
  cluster_uuid         = data.nutanix_cluster.cluster.id
  num_vcpus_per_socket = "4"
  num_sockets          = "1"
  memory_size_mib      = 8192

  disk_list {
    data_source_reference = {
      kind = "image"
      uuid = nutanix_image.CentOS.id
    }
  }

  nic_list {
    subnet_uuid = data.nutanix_subnet.subnet.id
  }
}