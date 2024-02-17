resource "aws_api_gateway_method" "auth_confirm_user_post" {
  rest_api_id   = aws_api_gateway_rest_api.api_gtw.id
  resource_id   = aws_api_gateway_resource.auth_confirm_user_resource.id
  http_method   = "POST"
  authorization = "NONE"

  request_models = {
    "application/json" = aws_api_gateway_model.body_confirm_user.name
  }

  request_parameters = {
    "method.request.header.Content-Type" = true
  }

  depends_on = [aws_api_gateway_model.body_confirm_user]
}

resource "aws_api_gateway_resource" "auth_confirm_user_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw.id
  parent_id   = aws_api_gateway_resource.proxy.id
  path_part   = "user-confirmation"

  depends_on = [aws_api_gateway_rest_api.api_gtw, aws_api_gateway_resource.proxy]
}

resource "aws_api_gateway_integration" "lambda_confirm_integration" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw.id
  resource_id = aws_api_gateway_method.auth_confirm_user_post.resource_id
  http_method = aws_api_gateway_method.auth_confirm_user_post.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/${var.lambda_auth_arn}/invocations"

}


resource "aws_api_gateway_model" "body_confirm_user" {
  rest_api_id  = aws_api_gateway_rest_api.api_gtw.id
  name         = "BodyConfirmUser"
  description  = "Model to confirm user in cognito"
  content_type = "application/json"

  schema = jsonencode({
    "type"     = "object",
    "required" = ["cpf", "code"],
    "properties" = {
      "cpf"  = { type = "string" },
      "code" = { type = "string" }
    }
  })
}
