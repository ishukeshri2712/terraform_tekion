variable "project-name" {

  description = "project name"
}

variable "tag-env" {

}
variable "tag-name" {

}

variable "tag-bill_unit_name" {

}

variable "tag-project_unit" {

}

variable "tag-date" {

}


variable "subnets" {
  type        = list(string)
  description = "List of subnets that should be attached to alb"
}

variable "is_internal" {
  type        = bool
  description = "whether the alb is internal or internet facing"
}

variable "deletion_protection" {
  type        = bool
  description = "whether the alb is deletion protected or not"
}



variable "sg" {
  type = list(string)

  description = "security group id for alb"
}

variable "tg-arn" {
  description = "arn of target group"
}
variable "ln_forward_port" {
  description = "listner forward port"
}
variable "ln_forward_protocol" {
  description = "lsitener forward protocol"
}
variable "alb_arn" {
  description = "alb arn to attach to listener"
}

variable "listner_port" {
  description = "listner port"
}
variable "redirect_port" {
  description = "redirect port"

}
variable "ln_protocol" {
  description = "listener_protocol"
}

variable "redirect_protocol" {
  description = "redirect protocol"

}

variable "alb_arn" {
  description = "arn of the alb which should be attached to listener"

}

variable "redirect_status_code" {
  description = "redirect status code"
}
