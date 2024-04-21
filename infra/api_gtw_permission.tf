resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvokeLambda"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_auth_arn
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${aws_api_gateway_rest_api.api_gtw.execution_arn}/*/*"
  depends_on = [ aws_api_gateway_rest_api.api_gtw ]
}


resource "aws_lambda_permission" "apigw_order" {
  statement_id  = "AllowAPIGatewayInvokeLambda"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_order_arn
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${aws_api_gateway_rest_api.api_gtw.execution_arn}/*/*"
  depends_on = [ aws_api_gateway_rest_api.api_gtw ]
}


