data "aws_vpc" "main" {
    tags = {
    name = "vpc"
  }
}

data "aws_subnet" "private" {
  count = local.private_subnet_count  # Use the count parameter here

  cidr_block = var.private_subnet_cidr_blocks[count.index]
  vpc_id     = data.aws_vpc.main.id

  tags = {
    Name = "privatesubnet"
  }
}

