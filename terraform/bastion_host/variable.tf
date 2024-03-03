variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_pair" {
  description = "key pair"
  type        = string
  default     = "mykey"
}

variable "ami_type" {
  default = "ami-0440d3b780d96b29d"
}

variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  default     = "10.0.0.0/16"
}

variable "project_name" {
  description = "name of project"
  type        = string
  default     = "timeoff"
}

variable "public_subnet_cidr_blocks" {
  description = "VPC Public Subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}