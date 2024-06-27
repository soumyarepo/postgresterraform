provider "azurerm" {
  features {}
}

module "postgresql" {
  source              = "../../modules/postgresql"
  resource_group_name = var.resource_group_name
  location            = var.location
  prefix              = var.prefix
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  database_name       = var.database_name
}