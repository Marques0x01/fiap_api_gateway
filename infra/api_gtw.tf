resource "aws_api_gateway_rest_api" "api_gtw" {
  name        = var.api_gtw_name
  description = var.api_gtw_description
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw.id
  parent_id   = aws_api_gateway_rest_api.api_gtw.root_resource_id
  path_part   = var.resource_path
}


resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    aws_api_gateway_integration.lambda_post, aws_api_gateway_integration.lambda_get
  ]

  rest_api_id = aws_api_gateway_rest_api.api_gtw.id
  stage_name  = var.stage
}


