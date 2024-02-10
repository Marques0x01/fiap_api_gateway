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

variable "lambda_auth_arn" {
  description = "Lambda auth arn"
  type        = string
}

variable "stage" {
  description = "Stage name"
  type        = string
  default     = "prod"
}
