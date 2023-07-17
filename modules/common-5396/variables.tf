variable "resource_group_name" {
  type = string  
}

variable "location" {
  type = string  
}

variable "log_analytics_sku" {
  type = string
}

variable "retention_in_days" {
  type = number
}

variable "recovery_vault_sku" {
  type = string
}

variable "log_analytics_name" {
  type = string
}

variable "recovery_vault_name" {
  type = string
}

variable "storage_account_name" {
  type =  string
}

locals {
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "N01595396 Shivam"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}