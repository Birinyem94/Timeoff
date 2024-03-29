# EKS Cluster Input Variables
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "ekspro"
}

variable "cluster_version" {
  description = "Kubernetes minor version to use for the EKS cluster"
  type        = string
  default     = null
}

variable "min_size" {
  description = "min"
  type        = number
}

variable "max_size" {
  description = "max size of the autoescaling cluster node groups"
  type        = number
}

variable "des_size" {
  description = "desired size of the autoescaling cluster node groups"
  type        = number
}

variable "instance_types" {
  description = "List of subnet IDs to create resources in"
  type        = list(string)
}

variable "key_pair" {
  description = "key pair"
  type        = string
  default     = "mykey"
}

variable "ami_type" {
  description = ""
  type        = string
}

variable "disk_size" {
  description = "Disk space of nodes"
  type        = number
}

variable "cluster_service_ipv4_cidr" {
  description = "service ipv4 cidr for the kubernetes cluster"
  type        = string
  default     = null
}

variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
  type        = bool
  default     = false
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled. When it's set to `false` ensure to have a proper private access with `cluster_endpoint_private_access = true`."
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# EKS Node Group Variables
## Placeholder space you can create if required

variable "private_subnet_cidr_blocks" {
  description = "VPC Private Subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

#AWS-auth Configmap roles
variable "eks_roles" {
  description = "IAM roles to add to the EKS aws-auth config maps"
  type = list(object({
    role_arn  = string
    username = string
    groups   = list(string)
  }))
}
