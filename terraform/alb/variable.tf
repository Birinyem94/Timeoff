variable "public_subnet_cidr_blocks" {
  description = "VPC Public Subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}
  
variable "aws_security_group" {
  description = "security group"
  type = string
  default = ""
}