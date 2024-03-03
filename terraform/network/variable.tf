variable "availability_zones" {
  default     = ["us-east-1a", "us-east-1b"]
  type        = list(string)
  description = "List of availability zones"
}

variable "vpc_cidr_block" {
  description = "Full VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "num_of_nat_gw_eip" {
  description = "number of natgateway"
  default = 2
  
}
variable "private_db_subnet_cidr_blocks" {
  description = "CIDR blocks for private DB subnets"
  default     = ["10.0.7.0/24", "10.8.0/24"]
}

variable "public_subnet_cidr_blocks" {
  description = "VPC Public Subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr_blocks" {
  description = "VPC Private Subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}




