resource "aws_instance" "web_instance" {
  ami           = "ami-0f9fc25dd2506cf6d"
  instance_type = "t2.micro"
  key_name      = "MyKeyPair"
}
