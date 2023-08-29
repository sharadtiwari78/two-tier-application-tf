# RSA key of size 4096 bits
resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key_pem" {
  content  = tls_private_key.private_key.private_key_pem
  filename = var.file_name
}

resource "aws_key_pair" "generated" {
  key_name   = var.key_name
  public_key = tls_private_key.private_key.public_key_openssh
  lifecycle {
    ignore_changes = [key_name]
  }
}