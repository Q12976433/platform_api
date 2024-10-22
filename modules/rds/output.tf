output "db_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.bqcore_db2.endpoint
}

output "db_address" {
  description = "RDS instance address"
  value       = aws_db_instance.bqcore_db2.address
}
