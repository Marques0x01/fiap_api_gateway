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


resource "aws_iam_role" "cloudwatch_logs" {
  name               = "apigateway-cloudwatch-logs-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_api_gateway_account" "example" {
  cloudwatch_role_arn = aws_iam_role.cloudwatch_logs.arn
}



resource "aws_iam_policy" "cloudwatch_logs_policy" {
  name        = "apigateway-cloudwatch-logs-policy"
  description = "Policy for API Gateway to write logs to CloudWatch Logs"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "cloudwatch_logs_policy_attachment" {
  role       = aws_iam_role.cloudwatch_logs.name
  policy_arn = aws_iam_policy.cloudwatch_logs_policy.arn
}
