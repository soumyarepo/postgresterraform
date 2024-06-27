provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.prefix}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_rule" "postgres_rule" {
  name                        = "AllowPostgres"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "5432"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_postgresql_server" "postgres_server" {
  name                           = "${var.prefix}-psql-server"
  location                       = azurerm_resource_group.rg.location
  resource_group_name            = azurerm_resource_group.rg.name
  administrator_login            = var.admin_username
  administrator_login_password   = var.admin_password
  version                        = "11"
  sku_name                       = "B_Gen5_2"
  storage_mb                     = 5120
  backup_retention_days          = 7
  geo_redundant_backup_enabled   = false
  auto_grow_enabled              = true
  public_network_access_enabled  = false
  ssl_enforcement_enabled        = true  # or false, based on your requirement
}

resource "azurerm_postgresql_database" "postgres_db" {
  name                = var.database_name
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_postgresql_server.postgres_server.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}