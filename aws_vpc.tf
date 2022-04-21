# Create a VPC
resource "aws_vpc" "tech-exercise" {
  cidr_block = "192.168.1.0/24"
}