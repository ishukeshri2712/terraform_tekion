variable "vpc-name" {
  type = string
  default = ""
}

variable "vpc-cidr" {
  type = string
  default = ""
}

variable "availability_zone" { //make it a list
  type = list(string)
  
}

variable "public_web_subnet-cidr" {
  type = list(string)
  
}

variable "private_app_subnet-cidr" {
  type = list(string)
  
}

variable "private_db_subnet-cidr" {
  type = list(string)
  
}


variable "environment" {
  type = string
  default = ""
}

variable "enable_nat_gateway" {
  type = bool
  default = true
}