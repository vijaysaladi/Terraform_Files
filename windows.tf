resource "azurerm_windows_virtual_machine" "VJ_WIN_VM" {
  name                = "VJWinVM${count.index}"
  resource_group_name = azurerm_resource_group.Vijay_Auto_RG.name
  location            = azurerm_resource_group.Vijay_Auto_RG.location
  size                = "Standard_F2"
  admin_username      = "admino01"
  admin_password      = "P@$$word@123"
  network_interface_ids = [
    azurerm_network_interface.Vijay_NIC[count.index].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  count = var.OS_Version == "Windows" ? var.NO_Of_VMs : 0

}