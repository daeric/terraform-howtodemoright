resource "nutanix_image" "Ubuntu" {
  name        = "Ubuntu"
  source_uri  = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}
