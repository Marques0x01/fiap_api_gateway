variable "api_gtw_name" {
  description = "Api gateway name"
  type        = string
}

variable "api_gtw_description" {
  description = "Api gateway description"
  type        = string
}

variable "resource_path" {
  description = "Resource path name"
  type        = string
}

variable "resource_path_auth" {
  description = "Resource path name"
  type        = string
}

variable "resource_path_kitchen" {
  description = "Resource path name"
  type        = string
}

variable "resource_path_client" {
  description = "Resource path name"
  type        = string
}

variable "resource_path_order" {
  description = "Resource path name"
  type        = string
}

variable "resource_path_payment" {
  description = "Resource path name"
  type        = string
}

variable "lambda_auth_arn" {
  description = "Lambda auth arn"
  type        = string
}

variable "lambda_order_arn" {
  description = "Lambda order arn"
  type        = string
}

variable "lambda_client_arn" {
  description = "Lambda client arn"
  type        = string
}

variable "lambda_kitchen_arn" {
  description = "Lambda kitchen arn"
  type        = string
}


variable "lambda_payment_arn" {
  description = "Lambda payment arn"
  type        = string
}

variable "stage" {
  description = "Stage name"
  type        = string
  default     = "prod"
}
