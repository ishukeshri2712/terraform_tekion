
resource "aws_launch_template" "alt" {
  name = var.alt_name
  description = var.launch_template_description
  image_id = var.image_id
  instance_type = var.instance_type
  key_name = aws_key_pair.demo.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  block_device_mappings {
    
    device_name = var.device_name

    ebs {
        volume_size = var.volume_size
        volume_type = var.volume_type
    }
  }
  tag_specifications {
    resource_type = var.tag_specifications_resource_type

    tags = {
      Name = var.tag_specifications_name
    }
  }

}
resource "aws_autoscaling_group" "asg" {
    name = var.asg_name
    vpc_zone_identifier = var.subnet_ids
    target_group_arns = var.target_group
    health_check_type = var.health_check_type
    health_check_grace_period = var.health_check_grace_period
    desired_capacity_type = var.desired_capacity_type
    desired_capacity = var.desired_capacity
    min_size = var.min_size
    max_size = var.max_size
    
    mixed_instances_policy {
      instances_distribution {
        on_demand_allocation_strategy = var.on_demand_allocation_strategy
        on_demand_percentage_above_base_capacity = var.on_demand_percentage_above_base_capacity
        spot_allocation_strategy = var.spot_allocation_strategy
      }
      launch_template {
        launch_template_specification {
          launch_template_id = var.launch_template_id
          version = var.launch_template_version
        }
      }
    }

    tag {
        key = var.asg_tag_key
        value = var.asg_tag_value
        propagate_at_launch = var.asg_tag_propagate_at_launch
    }
}
resource "aws_autoscaling_policy" "aap" {
    name = var.aws_autoscaling_policy_name
    autoscaling_group_name = var.autoscaling_group_name
    policy_type            = var.policy_type
    target_tracking_configuration {
      predefined_metric_specification {
        predefined_metric_type = var.predefined_metric_type
      }
      
      target_value = var.target_value
      disable_scale_in = var.disable_scale_in
  }
}


resource "aws_key_pair" "demo" {
    key_name = var.key_name
    public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
    algorithm = var.algorithm
    rsa_bits  = var.rsa_bits
}
resource "local_file" "key-file" {
    content  = tls_private_key.rsa.private_key_pem
    filename = var.private_key_filename
}