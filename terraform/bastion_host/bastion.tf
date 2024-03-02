resource "aws_instance" "bastion_host" {
  instance_type = var.instance_type
  ami           = var.ami_type
  key_name      = var.key_pair

  vpc_security_group_ids = ["${aws_security_group.default_egress.id}", "${aws_security_group.admin_access_public.id}", "${aws_security_group.admin_access_private.id}"]
  subnet_id              = aws_subnet.public.id

  tags = {
    Name = "bastion"
  }
}

resource "aws_key_pair" "mykey" {
  key_name   = var.key_pair
  public_key = file("~/.ssh/id_rsa.pub")
}

# Elastic IP for Bastion Host
resource "aws_eip" "bastion_eip" {
  depends_on = [aws_instance.bastion_host, aws_vpc.main]
  instance   = aws_instance.bastion_host.id
}