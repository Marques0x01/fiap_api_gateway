resource "aws_api_gateway_method" "order_unfinished_get" {
  rest_api_id   = aws_api_gateway_rest_api.api_gtw.id
  resource_id   = aws_api_gateway_resource.order_unfinished_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_resource" "order_unfinished_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw.id
  parent_id   = aws_api_gateway_resource.proxy_order.id
  path_part   = "unfinished"

  depends_on = [aws_api_gateway_rest_api.api_gtw, aws_api_gateway_resource.proxy_order]
}


resource "aws_api_gateway_integration" "lambda_order_unfinished" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw.id
  resource_id = aws_api_gateway_method.order_unfinished_get.resource_id
  http_method = aws_api_gateway_method.order_unfinished_get.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:us-east-2:lambda:path/2015-03-31/functions/${var.lambda_order_arn}/invocations"
}

