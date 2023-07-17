variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "network_name" {
  type = string 
}

variable "subnet_name" {
  type = string
}

variable "nsg_name" {
  type = string
}
variable "virtual_network_address_space" {
  description = "Address space of the virtual network"
  type        = list(string)
}

variable "subnet_address_space" {
  description = "Address prefixes of subnet"
  type        = list(string)
}

locals {
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "N01595396 Shivam"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}
