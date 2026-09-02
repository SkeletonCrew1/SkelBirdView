resource "aws_secretsmanager_secret" "web_server_1_ip" {
    name = var.web_server_1_private_ip_secret_name
    tags = {
        "jenkins:credentials:type" = "string"
    }
    recovery_window_in_days = 0
    region = var.secrets_region

}

resource "aws_secretsmanager_secret_version" "web_server_1_ip" {
    secret_string = var.web_server_1_private_ip
    secret_id = aws_secretsmanager_secret.web_server_1_ip.id
}

resource "aws_secretsmanager_secret" "web_server_2_ip" {
    name = var.web_server_2_private_ip_secret_name
    tags = {
        "jenkins:credentials:type" = "string"
    }
    recovery_window_in_days = 0
    region = var.secrets_region
    
}

resource "aws_secretsmanager_secret_version" "web_server_2_ip" {
    secret_string = var.web_server_2_private_ip
    secret_id = aws_secretsmanager_secret.web_server_2_ip.id
    
}

resource "aws_secretsmanager_secret" "database_ip" {
    name = var.database_private_ip_secret_name
    tags = {
        "jenkins:credentials:type" = "string"
    }
    recovery_window_in_days = 0
    region = var.secrets_region
    
}

resource "aws_secretsmanager_secret_version" "database_ip" {
    secret_string = var.database_private_ip
    secret_id = aws_secretsmanager_secret.database_ip.id
}

