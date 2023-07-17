resource "azurerm_resource_group" "shivam_rg" {
  name     = var.resource_group_name
  location = var.location
  tags = local.tags
}