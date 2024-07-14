resource "aws_api_gateway_method" "client_by_id" {
  rest_api_id   = aws_api_gateway_rest_api.api_gtw.id
  resource_id   = aws_api_gateway_resource.client_by_id.id
  http_method   = "GET"
  authorization = "NONE"

  request_parameters = {
    "method.request.querystring.id" = true
  }
}

resource "aws_api_gateway_resource" "client_by_id" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw.id
  parent_id   = aws_api_gateway_resource.proxy_client.id
  path_part   = "client_id"

  depends_on = [aws_api_gateway_rest_api.api_gtw, aws_api_gateway_resource.proxy_order]
}


resource "aws_api_gateway_integration" "client_by_id" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw.id
  resource_id = aws_api_gateway_method.client_by_id.resource_id
  http_method = aws_api_gateway_method.client_by_id.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:us-east-2:lambda:path/2015-03-31/functions/${var.lambda_client_arn}/invocations"
}

