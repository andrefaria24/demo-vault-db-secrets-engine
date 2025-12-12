pid_file = "./pidfile"

auto_auth {
  method "approle" {
    mount_path = "auth/approle"
    config = {
      role_id_file_path = "./role_id"
      secret_id_file_path = "./secret_id"
      remove_secret_id_file_after_reading = false
    }
  }
  sink "file" {
    config = {
      path = "./vault-token"
    }
  }
}

template {
  source      = "./mssql-creds.tpl"
  destination = "./db-connection-string.txt"
}

vault {
  address = "https://acfaria-hcp-vault-public-vault-600d9107.85bae10f.z1.hashicorp.cloud:8200"
}

listener "tcp" {
  address     = "127.0.0.1:8200"
  tls_disable = true
}

cache {
  use_auto_auth_token = true
  min_wait_time = "1s"
  max_wait_time = "5s"
}