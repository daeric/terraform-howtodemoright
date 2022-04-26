resource "aws_instance" "vm2" {
  ami           = "ami-0f9fc25dd2506cf6d"
  instance_type = "t2.micro"
  key_name      = "MyKeyPair"
  subnet_id     = "subnet-0170967c983eec7f0"
  vpc_security_group_ids     = "sg-0bd62723542b6f5fd"
}
