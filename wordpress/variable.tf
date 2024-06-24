variable "vpc_cidr" {
    description = "VPC CIDR Value"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR Values"
  default     = ["10.0.0.0/25", "10.0.0.128/25"]
}

variable "private_app_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR Values"
  default     = ["10.0.1.0/26", "10.0.1.64/26"]
}

variable "private_db_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR Values"
  default     = ["10.0.1.128/26", "10.0.1.192/26"]
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["eu-west-2a", "eu-west-2b"]
}