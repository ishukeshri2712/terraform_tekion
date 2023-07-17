variable "alt_name" {
    type = string
    description = "aws launch template name"
}

variable "launch_template_description" {
    type = string
    description = "launch template description"
}
variable "image_id" {
    type = string
    description = "AMI id for machine"
}

variable "instance_type" {
    type = string
    description = "instance type for EC2"
}

variable "vpc_security_group_ids" {
    type = list(string)
    description = "security group ids for EC2"
}

variable "add_storage_volume" {
    type = bool
    description = "Specifies if a new storage volume needs to be added to the ec2 machines launched"
}
variable "device_name" {
  type = string
}

variable "volume_size" {
  type = number
}

variable "volume_type" {
    type = string
}

variable "tag_specifications_resource_type" {
  type = string
}

variable "tag_specifications_name" {
    type = string
}

variable "key_name" {
    type = string
    description = "name for key pair for SSH"
}

variable "algorithm" {
    type = string
    description = "algorithm specified for tls"
}

variable "rsa_bits" {
    type = number
    description = "RSA size in bits"
}

variable "private_key_filename" {
  type = string
  description = "name of file containing private key"
}

variable "aws_autoscaling_policy_name" {
    type = string
    description = "name of auto scaling policy"
}

variable "autoscaling_group_name" {
    type = string
    description = "name of the autoscaling group name this policy is attached to"
}

variable "policy_type" {
    type = string
    description = "type pf policy"
}

variable "target_value" {
    type = number
    description = "no of EC2 instance AWS targets during sundden scale up"
}

variable "predefined_metric_type" {
    type = string
    description = "metric type for scaling"
}

variable "disable_scale_in" {
    type = bool
    description = "signifies whether scale in is disabled or not"
}

variable "asg_name" {
    description = "name of auto scaling group"
}

variable "subnet_ids" {
    type = list(string)
    description = "List of subnet ids"
}

variable "target_group" {
    type = list(string)
    description = "List of arns of ALBs"
}
variable "health_check_type" {
    type = string
    description = "Type of health check applied on asg, EC2 or ELB"
}

variable "health_check_grace_period" {
    type = number
    description = "Grace period for health check in seconds"
}

variable "desired_capacity_type" {
    type = string
    description = "desired capacity type can be in units, vcpus or memory-mib"
}

variable "desired_capacity" {
    type = number
    description = "desired no of units of EC2 running"
}

variable "min_size" {
    type = number
    description = "minimum no of units running at a time"
}

variable "max_size" {
    type = number
    description = "maximum no uf units running at a time"
}

variable "on_demand_allocation_strategy" {
    type = string
    description = "Allocation stratergy for on-demand instances"
}

variable "on_demand_percentage_above_base_capacity" {
    type = number
    description = "% of on demand instances to spot instances"
}

variable "spot_allocation_strategy" {
    type = string
    description = "allocation stratergy for spot instances"
}

variable "launch_template_version" {
    type = string
    description = "version of launch template"
}

variable "asg_tag_key" {
  type = string
  description = "key given to tag in asg"
}

variable "asg_tag_value" {
  type = string
  description = "value given to tag in asg"
}

variable "asg_tag_propagate_at_launch" {
    type = bool
    description = "value for propagation at launch for asg in tag"
}

variable "launch_template_id" {
    type = string
    description = "id of the launch template that will be used for the autoscaling group"
  
}