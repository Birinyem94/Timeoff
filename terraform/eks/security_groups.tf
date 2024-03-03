
resource "aws_security_group" "eks_node_group_sg" {

  name        = "${var.cluster_name}-worker-nodes-sg"
  description = "Custom security group for worker nodes"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    description = "allow all ports between nodes"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  egress {
    description      = "Allow all egress traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ## Webhook of ALB can't reach the control plane without this rule
  ingress {
    description = "allow all ports from the control plane"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "eks_cluster_sg" {
  name        = "${var.cluster_name}-control-plane"
  description = "Custom security group for CP"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    description = "allow all ports from services"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  ingress {
    description = "allow all ports from LAN"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  egress {
    description      = "Allow all egress traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}