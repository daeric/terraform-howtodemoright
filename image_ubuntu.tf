resource "nutanix_image" "Ubuntu" {
  name        = "Ubuntu"
  source_uri  = "http://10.0.0.10/Software/Linux/Ubuntu/jammy-server-cloudimg-amd64.img"
}
