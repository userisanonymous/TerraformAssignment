variable "nb_count" {
  type = number
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subent_id" {
  type = string
}

variable "windows_name" {
  type = string
}

variable "size" {
  type = string
}
variable "windows_username" {
  type = string
}

variable "windows_password" {
  type = string
}

variable "wos_disk_storage_account_type" {
  type = string
}

variable "wos_disk_size" {
  type = number
}

variable "wos_disk_caching" {
  type = string
}

variable "windows_publisher" {
  type = string
}

variable "windows_offer" {
  type = string
}

variable "windows_sku" {
  type = string
}

variable "windows_version" {
  type = string
}

variable "windows_avs" {
  type = string
}

variable "boot_diagnostics" {
  type = string

}

locals {
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "N01595396 Shivam"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}