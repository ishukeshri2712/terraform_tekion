###########################
# Application Load Balancer
###########################
resource "aws_lb" "alb" {
  name                       = "${var.project-name}-alb"
  internal                   = var.is_internal
  load_balancer_type         = "application"
  enable_deletion_protection = var.deletion_protection
  security_groups            = var.sg
  subnets                    = var.subnets
  tags = {
    Environment    = var.tag-env
    Name           = var.tag-name
    bill_unit_name = var.tag-bill_unit_name
    project_unit   = var.tag-project_unit
    date           = var.tag-date
  }
}

##########################
# listener forward
##########################
resource "aws_lb_listener" "forward_listner" {
  load_balancer_arn = var.alb_arn
  port              = var.ln_forward_port
  protocol          = var.ln_forward_protocol
  default_action {
    type             = "forward"
    target_group_arn = var.tg-arn
  }
}
##########################
# listener redirect
##########################
resource "aws_lb_listener" "redirect_listener" {
  load_balancer_arn = var.alb_arn
  port              = var.listner_port
  protocol          = var.ln_protocol

  default_action {
    type = "redirect"

    redirect {
      port        = var.redirect_port
      protocol    = var.redirect_protocol
      status_code = var.redirect_status_code
    }
  }
}