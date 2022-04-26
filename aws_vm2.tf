resource "aws_instance" "vm2" {
  ami           = "ami-0f9fc25dd2506cf6d"
  instance_type = "t2.micro"
  key_name      = "MyKeyPair"
  subnet_id     = "subnet-01"
}
