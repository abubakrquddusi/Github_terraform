terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }
# Adding this to the branch




  # required_version = ">= 0.14.9"
}
/*tgierraform {
  backend "remote" {
    organization = "AbubakrQuddusi"

    workspaces {
      name = "Github-TerraformWorkspace"
    }
  }
}
*/
provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-MYTFRG"
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-MyTFVnet"
  address_space       = var.Vnet_address
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "MyTFSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.Subnet_address

}

resource "azurerm_network_interface" "nic" {
  name                = "${var.prefix}-nic"
  location            = azurerm_virtual_network.vnet.location
  resource_group_name = azurerm_resource_group.rg.name


  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "VM" {
  name                             = "${var.prefix}-MyVM"
  location                         = var.location
  resource_group_name              = azurerm_resource_group.rg.name
  network_interface_ids            = [azurerm_network_interface.nic.id]
  vm_size                          = "Standard_DS1_v2"
  #delete_os_disk_on_termination    = true
  #delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "ubuntuVM"
    admin_username = "intadmin"
    admin_password = "15amc1sc0$"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}
