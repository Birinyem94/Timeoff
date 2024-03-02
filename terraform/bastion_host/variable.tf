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
  default = "ami-9a562df2"
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