# RDS Parameter Group Variables
variable "parameter_group_name" {
  description = "Name of the RDS parameter group"
  type        = string
}

variable "parameter_group_family" {
  description = "The family of the RDS parameter group (e.g., postgres14, postgres16)"
  type        = string
}

variable "force_ssl_value" {
  description = "Value for rds.force_ssl parameter"
  type        = string
  default     = "0"
}



# RDS Instance Variables
variable "engine" {
  description = "Database engine"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Version of the database engine"
  type        = string
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "allocated_storage" {
  description = "The allocated storage in GB"
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "Storage type for RDS instance (e.g., gp2, standard)"
  type        = string
  default     = "gp2"
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "username" {
  description = "The master username for the database"
  type        = string
}

variable "password" {
  description = "The master password for the database"
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "Database port number"
  type        = number
  default     = 5432
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs to assign to the RDS instance"
  type        = list(string)
}

variable "publicly_accessible" {
  description = "If true, the RDS instance will be publicly accessible"
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Determines whether a final snapshot is created before the DB instance is deleted"
  type        = bool
  default     = true
}

# DB Subnet Group Variables
variable "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the DB subnet group"
  type        = list(string)
  #default = var.subnet_ids
}


