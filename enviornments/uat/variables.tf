variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure location where resources will be deployed"
  type        = string
}

variable "prefix" {
  description = "Prefix for naming resources"
  type        = string
}

variable "admin_username" {
  description = "Administrator username for PostgreSQL server"
  type        = string
}

variable "admin_password" {
  description = "Administrator password for PostgreSQL server"
  type        = string
}

variable "database_name" {
  description = "The name of the PostgreSQL database"
  type        = string
}