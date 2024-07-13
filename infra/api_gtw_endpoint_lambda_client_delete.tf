resource "aws_api_gateway_method" "client_delete" {
  rest_api_id   = aws_api_gateway_rest_api.api_gtw.id
  resource_id   = aws_api_gateway_resource.proxy_client.id
  http_method   = "DELETE"
  authorization = "NONE"

  request_parameters = {
    "method.request.header.Content-Type" = true
    "method.request.querystring.id"  = true
  }
}


resource "aws_api_gateway_integration" "lambda_client_delete" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw.id
  resource_id = aws_api_gateway_method.client_delete.resource_id
  http_method = aws_api_gateway_method.client_delete.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:us-east-2:lambda:path/2015-03-31/functions/${var.lambda_client_arn}/invocations"
}

