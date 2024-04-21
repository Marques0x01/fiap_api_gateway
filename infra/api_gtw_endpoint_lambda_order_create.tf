resource "aws_api_gateway_method" "order_create_post" {
  rest_api_id   = aws_api_gateway_rest_api.api_gtw.id
  resource_id   = aws_api_gateway_resource.proxy_order.id
  http_method   = "POST"
  authorization = "NONE"

  request_models = {
    "application/json" = aws_api_gateway_model.body_save_order.name
  }

  request_parameters = {
    "method.request.header.Content-Type" = true
  }

  depends_on = [aws_api_gateway_model.body_save_order]
}


resource "aws_api_gateway_integration" "lambda_order_create" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw.id
  resource_id = aws_api_gateway_method.order_create_post.resource_id
  http_method = aws_api_gateway_method.order_create_post.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/${var.lambda_order_arn}/invocations"
}




resource "aws_api_gateway_model" "body_save_order" {
  rest_api_id  = aws_api_gateway_rest_api.api_gtw.id
  name         = "BodySaveOrder"
  description  = "Model to create order"
  content_type = "application/json"

  schema = jsonencode({
    "type"     = "object",
    "required" = ["value", "clientCpf", "productsIds"],
    "properties" = {
      "value"       = { type = "number" },
      "clientCpf"   = { type = "string" }
      "productsIds" = { type = "array" }
    }
  })
}
