data "aws_subnet" "private" {
  vpc_id = var.vpc_id

  # You can add additional filtering criteria here if needed
}
