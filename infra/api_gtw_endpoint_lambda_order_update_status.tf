resource "aws_api_gateway_method" "order_update" {
  rest_api_id   = aws_api_gateway_rest_api.api_gtw.id
  resource_id   = aws_api_gateway_resource.proxy_order.id
  http_method   = "PUT"
  authorization = "NONE"

  request_parameters = {
    "method.request.header.Content-Type" = true
    "method.request.querystring.id"  = true
    "method.request.querystring.status"  = true
  }
}


resource "aws_api_gateway_integration" "lambda_order_put_status" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw.id
  resource_id = aws_api_gateway_method.order_update.resource_id
  http_method = aws_api_gateway_method.order_update.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:us-east-2:lambda:path/2015-03-31/functions/${var.lambda_order_arn}/invocations"
}
