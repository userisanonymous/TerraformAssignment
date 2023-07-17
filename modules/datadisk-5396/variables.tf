# variables.tf

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Location of the resources"
  type        = string
}

variable "disk_size_gb" {
  description = "Size of the data disk in GB"
  type        = number
}

variable "storage_account_type" {
  description = "Type of storage account for the data disks"
  type        = string
}

variable "disk_create_option" {
  type = string
}

variable "linux_vm_names" {
  description = "List of Linux VM names"
  type        = list(string)
}

variable "linux_vm_ids" {
  description = "List of Linux VM resource IDs"
  type        = list(string)
}

variable "windows_vm_ids" {
  description = "List of Windows VM resource IDs"
  type        =  list(string)
}

variable "windows_vm_name" {
  description = "List of Windows VM resource name"
  type        =  list(string)
}

locals {
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "N01595396 Shivam"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}