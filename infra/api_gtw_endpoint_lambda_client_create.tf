resource "aws_api_gateway_method" "client_create_post" {
  rest_api_id   = aws_api_gateway_rest_api.api_gtw.id
  resource_id   = aws_api_gateway_resource.proxy_client.id
  http_method   = "POST"
  authorization = "NONE"

  request_models = {
    "application/json" = aws_api_gateway_model.body_send_client.name
  }

  request_parameters = {
    "method.request.header.Content-Type" = true
  }

  depends_on = [aws_api_gateway_model.body_send_client]
}


resource "aws_api_gateway_integration" "lambda_client_create" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw.id
  resource_id = aws_api_gateway_method.client_create_post.resource_id
  http_method = aws_api_gateway_method.client_create_post.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:us-east-2:lambda:path/2015-03-31/functions/${var.lambda_client_arn}/invocations"
}




resource "aws_api_gateway_model" "body_send_client" {
  rest_api_id  = aws_api_gateway_rest_api.api_gtw.id
  name         = "BodySendClient"
  description  = "Model to send client"
  content_type = "application/json"

  schema = jsonencode({
    "type"     = "object",
    "required" = ["name", "cpf", "address", "phone"],
    "properties" = {
      "name"    = { type = "string" },
      "cpf"    = { type = "string" },
      "address" = { type = "string" },
      "phone"   = { type = "string" }
    }
  })
}
