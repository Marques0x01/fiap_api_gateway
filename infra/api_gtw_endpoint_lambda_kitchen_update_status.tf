resource "aws_api_gateway_method" "kitchen_update" {
  rest_api_id   = aws_api_gateway_rest_api.api_gtw.id
  resource_id   = aws_api_gateway_resource.proxy_order.id
  http_method   = "PUT"
  authorization = "NONE"

  request_models = {
    "application/json" = aws_api_gateway_model.body_update_kitchen.name
  }

  request_parameters = {
    "method.request.header.Content-Type" = true
  }
}


resource "aws_api_gateway_integration" "lambda_kitchen_put" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw.id
  resource_id = aws_api_gateway_method.kitchen_update.resource_id
  http_method = aws_api_gateway_method.kitchen_update.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:us-east-2:lambda:path/2015-03-31/functions/${var.lambda_order_arn}/invocations"
}

resource "aws_api_gateway_model" "body_update_kitchen" {
  rest_api_id  = aws_api_gateway_rest_api.api_gtw.id
  name         = "BodyUpdateKitchen"
  description  = "Model to update in kitchen"
  content_type = "application/json"

  schema = jsonencode({
    "type"     = "object",
    "required" = ["id", "status"],
    "properties" = {
      "id"        = { type = "string" },
      "status"    = { type = "string" },
      "client_id" = { type = "string" }
    }
  })
}

