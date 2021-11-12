/*variable "rg_name" {
  default = "${var.prefix}-MYTFRG"
}

variable "Virtual_Subnet_Name" {
  default = "${var.prefix}-MyTFVnet"
}
*/
variable "location" {

  default = "US EAST"
}

variable "Vnet_address" {

  default = ["10.0.0.0/16"]
}

variable "prefix" {

  default = "PRJNEWVM"

}

//variable "subnetname" {
//    default = "${var.prefix}-MyTFSubnet"

//}

variable "Subnet_address" {

  default = ["10.0.1.0/24"]


}