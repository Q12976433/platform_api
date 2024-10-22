variable "cidr_block" {
  description = "VPC CIDR block"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

# Public Subnet Variables
variable "public_subnet_1_cidr" {
  description = "CIDR block for the first public subnet"
  type        = string
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for the second public subnet"
  type        = string
}

variable "public_az_1" {
  description = "Availability zone for the first public subnet"
  type        = string
}

variable "public_az_2" {
  description = "Availability zone for the second public subnet"
  type        = string
}

# Private Subnet Variables
variable "private_subnet_1_cidr" {
  description = "CIDR block for the first private subnet"
  type        = string
}

variable "private_subnet_2_cidr" {
  description = "CIDR block for the second private subnet"
  type        = string
  
}

variable "private_az_1" {
  description = "Availability zone for the first private subnet"
  type        = string
}

variable "private_az_2" {
  description = "Availability zone for the second private subnet"
  type        = string
}
