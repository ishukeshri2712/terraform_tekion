variable "lambda_function_name" {
  description = "lambda function name"
  type        = string
}
variable "runtime" {
  description = "specifies the runtime environment for the Lambda function"
  type        = string
}
variable "zip_file_path" {
  description = "specifies the name of the ZIP file that contains the Lambda function"
  type        = string
}
variable "file_name" {
  description = "file name inside the zip folder"
  type        = string
}
variable "python_function_name" {
  description = "function name to access in the file "
  type        = string
}
variable "iam_role_arn" {
  description = "arn for the iam role"
  type        = string
}
variable "environment" {
  description = "type of the environment"
  type        = string
}

variable "iam_role_name" {
  description = "name of the IAM role"
  type        = string
}
variable "assume_role_policy" {
  description = "it creates a role and allow the service to access aws "
  type        = string
}
variable "environment" {
  description = "type of the environment"
  type        = string
}

variable "policy_name" {
  type        = string
  description = "name of the policy"
}
variable "policy" {
  type        = string
  description = "the statements and actions for the policy"
}
variable "environment" {
  description = "type of the environment"
  type        = string
}

variable "policy_arn" {
  type        = string
  description = "arn for the policy"
}
variable "iam_role_name" {
  type        = string
  description = "name of the iam rule"
}
variable "environment" {
  description = "type of the environment"
  type        = string
}