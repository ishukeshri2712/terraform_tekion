 
# Required Arguments
variable "name" {
  description = "A maximum of 32 alphanumeric characters including hyphens are allowed, but the name must not begin or end with a hyphen."
  type        = string
}

variable "target_type" {
  type        = string
  description = "A target type should be one of the following - instances | ip | lambda | alb"
}

variable "tags" {
  type = object({
    environment  = string
    billing_unit = string
    project_unit = string
    Date         = string
    Email        = string
  })
}

# Required when target_type != "lambda"
variable "port" {
  type    = string
}

variable "protocol" {
  type        = string
  description = "Protocol to use for routing traffic to the targets. Should be one of GENEVE, HTTP, HTTPS, TCP, TCP_UDP, TLS, or UDP. "
}

variable "protocol_version" {
  type        = string
  description = "Only applicable when protocol is HTTP or HTTPS"
}

variable "vpc_id" {
  description = "Specify the VPC id with the instances that you want to include in the target group"
  type        = string
}

# Health check configuring variables
variable "health_check_port" {
  type        = string
  description = "The port the load balancer uses when performing health checks on targets. Default is traffic-port."
}

variable "healthcheck_enabled" {
  type    = bool
  default = null
}

variable "healthy_threshold" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy."
  type        = string
}

variable "unhealthy_threshold" {
  description = "The number of consecutive health check failures required before considering a target unhealthy."
  type        = string
}

variable "interval" {
  description = "The approximate amount of time between health checks of an individual target"
  type        = string
}

variable "timeout_value" {
  description = "The amount of time, in seconds, during which no response means a failed health check."
  type        = string
}

variable "matcher_value" {
  description = "The HTTP codes to use when checking for a successful response from a target. You can specify multiple values (for example, '200,202') or a range of values (for example, '200-299')."
  type        = string
}

variable "health_check_path" {
  type    = string 
}

variable "health_check_protocol" {
  type    = string
}

# Optional Arguments

variable "connection_termination" {
  type        = bool
  description = "(Optional) Whether to terminate connections at the end of the deregistration timeout on Network Load Balancers."
}

variable "deregistration_delay" {
  type        = string
  description = "(Optional) Amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds. The default value is 300 seconds."
}

variable "lambda_multi_value_headers_enabled" {
  type        = bool
  description = "Whether the request and response headers exchanged between the load balancer and the Lambda function include arrays of values or strings. Only applies when target_type is lambda."
}

variable "slow_start" {
  type        = number
  description = "Amount time for targets to warm up before the load balancer sends them a full share of requests. The range is 30-900 seconds or 0 to disable."
}

variable "proxy_protocol_v2" {
  type        = bool
  description = "Whether to enable support for proxy protocol v2 on Network Load Balancers."
}

variable "load_balancing_algorithm_type" {
  type        = string
  description = "Determines how the load balancer selects targets when routing requests. Only applicable for Application Load Balancer Target Groups. The value is round_robin or least_outstanding_requests."
}

variable "preserve_client_ip" {
  type        = string 
  description = "Whether client IP preservation is enabled."
}

variable "ip_address_type" {
  type        = string
  description = "The type of IP addresses used by the target group, only supported when target type is set to ip. Possible values are ipv4 or ipv6."
}


