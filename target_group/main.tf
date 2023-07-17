
# Create an Instance target group
resource "aws_lb_target_group" "target_group" {
  name             = var.name
  target_type      = var.target_type
  vpc_id           = var.vpc_id
  port             = var.port
  protocol         = var.protocol
  protocol_version = var.protocol_version
  tags = {
    Environment  = var.tags.environment
    Name         = "${var.name}-tg"
    billing_unit = var.tags.billing_unit
    project_unit = var.tags.project_unit
    Date         = var.tags.Date
    Email        = var.tags.Email
  }

  deregistration_delay               = var.deregistration_delay
  connection_termination             = var.connection_termination
  lambda_multi_value_headers_enabled = var.lambda_multi_value_headers_enabled
  proxy_protocol_v2                  = var.proxy_protocol_v2
  preserve_client_ip                 = var.preserve_client_ip
  load_balancing_algorithm_type      = var.load_balancing_algorithm_type
  ip_address_type                    = var.ip_address_type
  slow_start                         = var.slow_start

  # Configure Health Check
  health_check {
    enabled             = var.healthcheck_enabled
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    interval            = var.interval
    timeout             = var.timeout_value
    path                = var.health_check_path
    port                = var.health_check_port
    matcher             = var.matcher_value
    protocol            = var.health_check_protocol
  }
}

