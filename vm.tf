resource "nutanix_virtual_machine" "VM" {
  name                 = "VM"
  cluster_uuid         = data.nutanix_cluster.cluster.id
  num_vcpus_per_socket = "2"
  num_sockets          = "1"
  memory_size_mib      = 2048

  guest_customization_cloud_init_user_data = base64encode(templatefile("${path.module}/resources/cloud-init/generic.tpl", { hostname = "VM" }))

  disk_list {    
    data_source_reference = {
        kind = "image"
        uuid = nutanix_image.Ubuntu.id
      }
      
    device_properties {
      disk_address = {
        device_index = 0
        adapter_type = "SCSI"
      }

      device_type = "DISK"
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
