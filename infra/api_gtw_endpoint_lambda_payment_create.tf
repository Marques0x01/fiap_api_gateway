resource "aws_api_gateway_method" "payment_create_post" {
  rest_api_id   = aws_api_gateway_rest_api.api_gtw.id
  resource_id   = aws_api_gateway_resource.proxy_payment.id
  http_method   = "POST"
  authorization = "NONE"

  request_models = {
    "application/json" = aws_api_gateway_model.body_send_payment.name
  }

  request_parameters = {
    "method.request.header.Content-Type" = true
  }

  depends_on = [aws_api_gateway_model.body_send_payment]
}


resource "aws_api_gateway_integration" "lambda_payment_create" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw.id
  resource_id = aws_api_gateway_method.payment_create_post.resource_id
  http_method = aws_api_gateway_method.payment_create_post.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:us-east-2:lambda:path/2015-03-31/functions/${var.lambda_payment_arn}/invocations"
}




resource "aws_api_gateway_model" "body_send_payment" {
  rest_api_id  = aws_api_gateway_rest_api.api_gtw.id
  name         = "BodySendPayment"
  description  = "Model to send payment"
  content_type = "application/json"

  schema = jsonencode({
    "type"     = "object",
    "required" = ["id_cliente", "id_pedido", "tipo_pagamento", "valor_pagamento"],
    "properties" = {
      "id_cliente"        = { type = "string" },
      "id_pedido"         = { type = "string" },
      "tipo_pagamento"    = { type = "string" },
      "valor_pagamento"   = { type = "string" }
    }
  })
}
