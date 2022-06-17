resource "azurerm_linux_virtual_machine" "VJ_LIN_VM" {
  name                            = "VJLinVM${count.index}"
  resource_group_name             = azurerm_resource_group.Vijay_Auto_RG.name
  location                        = azurerm_resource_group.Vijay_Auto_RG.location
  size                            = "Standard_F2"
  admin_username                  = "admino01"
  admin_password                  = "P@$$word@123"
  disable_password_authentication = "false"
  network_interface_ids = [
    azurerm_network_interface.Vijay_NIC[count.index].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  count = var.OS_Version == "Linux" ? var.NO_Of_VMs : 0

}