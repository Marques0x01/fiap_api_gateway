api_gtw_name = "fiap-api-gtw"
api_gtw_description = "Fiap lanches API Gateway"
lambda_auth_arn = "arn:aws:lambda:us-east-2:381492057057:function:lambda_auth"
lambda_order_arn = "arn:aws:lambda:us-east-2:381492057057:function:fiap_pedidos_ms"
lambda_payment_arn = "arn:aws:lambda:us-east-2:381492057057:function:fiap_pagamentos_ms"
lambda_client_arn = "arn:aws:lambda:us-east-2:381492057057:function:lambda_clients"
lambda_kitchen_arn = "arn:aws:lambda:us-east-2:381492057057:function:lambda_kitchen"
stage = "prod"

resource_path = "fiap-lanches"
resource_path_order = "order"
resource_path_auth = "auth"
resource_path_payment = "payment"
resource_path_client = "client"
resource_path_kitchen = "kitchen"
