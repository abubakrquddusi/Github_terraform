output "Resource_Group_Name" {
  value = azurerm_resource_group.rg

}

output "Vnet_Name" {
  value = azurerm_subnet.subnet.name
}

output "VNet_Address" {
  value = azurerm_virtual_network.vnet.id
}

output "Virtual_Machine_Name" {
  value = azurerm_virtual_machine.VM.name
}

output "IP_Address" {
  value = azurerm_network_interface.nic.private_ip_address

}