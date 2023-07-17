
variable "resource_group_name" {
    type = string
}

variable "location" {
  type = string
}

variable "lb_pip" {
  type = string
}

variable "lb_name" {
  type = string
}

variable "vnet_id" {
  type = string
}

variable "nic_linux" {
  type = list(string)
}

variable "linux_name" {
  type = list(string)
}

locals {
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "N01595396 Shivam"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}
