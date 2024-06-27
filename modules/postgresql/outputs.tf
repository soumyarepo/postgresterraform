output "postgresql_server_name" {
  description = "The name of the PostgreSQL server"
  value       = azurerm_postgresql_server.postgres_server.name
}

output "postgresql_server_fqdn" {
  description = "The FQDN of the PostgreSQL server"
  value       = azurerm_postgresql_server.postgres_server.fqdn
}

output "postgresql_database_name" {
  description = "The name of the PostgreSQL database"
  value       = azurerm_postgresql_database.postgres_db.name
}