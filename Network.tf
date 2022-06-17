resource "azurerm_virtual_network" "vijay_auto_Network" {
  name                = "SVB_RG_Network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.Vijay_Auto_RG.location
  resource_group_name = azurerm_resource_group.Vijay_Auto_RG.name
}

output "Virtual_Network" {
  value = azurerm_virtual_network.vijay_auto_Network.name
}

resource "azurerm_subnet" "vijay_Auto_Subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.Vijay_Auto_RG.name
  virtual_network_name = azurerm_virtual_network.vijay_auto_Network.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "Vijay_Pub_IP" {
  name                = "Vijay_Pub_IP${count.index}"
  resource_group_name = azurerm_resource_group.Vijay_Auto_RG.name
  location            = azurerm_resource_group.Vijay_Auto_RG.location
  allocation_method   = "Static"
  count               = var.NO_Of_VMs
}

output "myips" {
  value = azurerm_public_ip.Vijay_Pub_IP[*].ip_address
}


resource "azurerm_network_interface" "Vijay_NIC" {
  name                = "Vijay_NIC${count.index}"
  location            = azurerm_resource_group.Vijay_Auto_RG.location
  resource_group_name = azurerm_resource_group.Vijay_Auto_RG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vijay_Auto_Subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.Vijay_Pub_IP[count.index].id
  }

  count = var.NO_Of_VMs
}