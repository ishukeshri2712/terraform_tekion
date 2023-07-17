variable "region" {
  type        = string
  description = "region name in aws where the connector box will created."
}
variable "instance_id" {
  type        = string
  description = "instance if of the existing connector box"
}
variable "ami" {
  type    = string
  default = "ami id of the architecture of arm"
}
variable "device_name" {
  type        = string
  description = "volume device name"
}
variable "instance_type" {
  type        = string
  description = "instance type of the connector box"
}
variable "security_groups_mongo" {
 type =list(string)
 description = "security group attached to mongo " 
}
variable "vpc_id" {
  type        = string
  description = "vpc id of connector box"
}
