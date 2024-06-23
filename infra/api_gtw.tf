resource "aws_api_gateway_rest_api" "api_gtw" {
  name        = var.api_gtw_name
  description = var.api_gtw_description
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw.id
  parent_id   = aws_api_gateway_rest_api.api_gtw.root_resource_id
  path_part   = var.resource_path
}

resource "aws_api_gateway_resource" "proxy_auth" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw.id
  parent_id   = aws_api_gateway_resource.proxy.id
  path_part   = var.resource_path_auth

  depends_on = [aws_api_gateway_resource.proxy]
}

resource "aws_api_gateway_resource" "proxy_order" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw.id
  parent_id   = aws_api_gateway_resource.proxy.id
  path_part   = var.resource_path_order

  depends_on = [aws_api_gateway_resource.proxy]
}

resource "aws_api_gateway_resource" "proxy_payment" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw.id
  parent_id   = aws_api_gateway_resource.proxy.id
  path_part   = var.resource_path_payment

  depends_on = [aws_api_gateway_resource.proxy]
}

resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    aws_api_gateway_integration.lambda_post,
    aws_api_gateway_integration.lambda_get,
    aws_api_gateway_integration.lambda_confirm_integration,
    aws_api_gateway_integration.lambda_order_unfinished,
    aws_api_gateway_integration.lambda_order_get_by_status,
    aws_api_gateway_integration.lambda_order_create,
    aws_api_gateway_integration.lambda_order_put_status,
    aws_api_gateway_integration.lambda_payment_create
  ]

  rest_api_id = aws_api_gateway_rest_api.api_gtw.id
  stage_name  = var.stage
}








# resource "aws_api_gateway_method_settings" "logs" {
#   rest_api_id = "${aws_api_gateway_rest_api.api_gtw.id}"
#   stage_name  = "prod"
#   method_path = "*/*"
#   settings {
#     logging_level = "INFO"
#     data_trace_enabled = true
#     metrics_enabled = true
#   }
# }
