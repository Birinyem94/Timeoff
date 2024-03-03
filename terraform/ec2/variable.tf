variable "key_pair" {
  description = "key pair"
  type        = string
  default     = "mykey"
}

variable "app" {
  default = ""
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t3.micro"
}

variable "asg_min" {
  default = 1
}

variable "asg_max" {
  default = 2
}

variable "asg_desired" {
  default = 1
}

variable "vol_size" {
  default = 20
}

variable "vol_type" {
  default = "gp3"
}

variable "enabled" {
  description = "Flag to enable/disable the creation of resources."
  type        = bool
}

variable "private_subnet_cidr_blocks" {
  description = "VPC Private Subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

