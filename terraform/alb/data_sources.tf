data "aws_vpc" "main" {
    tags = {
    name = "vpc"
  }
}

data "aws_subnet" "public" {
  count = local.public_subnet_count  # Use the count parameter here

  cidr_block = var.public_subnet_cidr_blocks[count.index]
  vpc_id     = data.aws_vpc.main.id

  tags = {
    Name = "publicsubnet"
  }
}
