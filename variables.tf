variable "cluster_name" {
  type = string
}
variable "subnet_name" {
  type = string
}
variable "password" {
  type      = string
  sensitive = true
}
variable "endpoint" {
  type = string
}
variable "user" {
  type = string
}
variable "foundation_endpoint" {
  type = string
}
variable "foundation_port" {
  type = string
}
data "nutanix_cluster" "cluster" {
  name = var.cluster_name
}
data "nutanix_subnet" "subnet" {
  subnet_name = var.subnet_name
}
