data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_launch_template" "launch_template" {
  name                   = "${var.project_name}-server"
  image_id               = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.security_group_ids]
  user_data              = filebase64("./modules/ec2/config.sh")

  tags = {
    Name = "${var.project_name}"
  }
}