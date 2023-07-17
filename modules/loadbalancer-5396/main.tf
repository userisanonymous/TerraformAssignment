resource "azurerm_public_ip" "lb_pip" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.tags
}

resource "azurerm_lb" "load_balancer" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "${var.resource_group_name}-frontend-ip"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }

  tags = local.tags
}

resource "azurerm_lb_backend_address_pool" "backend_address_pool" {
  name            = "${var.resource_group_name}-backend-pool"
  loadbalancer_id = azurerm_lb.load_balancer.id
}

resource "azurerm_network_interface_backend_address_pool_association" "lb_nic_backend_association" {
  count                   = length(var.nic_linux)
  network_interface_id    = element(var.nic_linux, count.index)
  ip_configuration_name   = "${var.linux_name[count.index]}-ipconfig"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_address_pool.id
}

resource "azurerm_lb_probe" "lb_probe" {
  loadbalancer_id = azurerm_lb.load_balancer.id
  name            = "${var.resource_group_name}-ssh-probe"
  port            = 22
}

resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = azurerm_lb.load_balancer.id
  name                           = "${var.resource_group_name}-lb-rule"
  protocol                       = "Tcp"
  frontend_port                  = 3389
  backend_port                   = 3389
  frontend_ip_configuration_name = "${var.resource_group_name}-frontend-ip"

  depends_on = [var.nic_linux]
}
