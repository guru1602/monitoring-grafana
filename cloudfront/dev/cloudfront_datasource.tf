provider "grafana" {
  alias = "data_source"
  url  = var.grafana_url
  auth = var.grafana_api_key
}

resource "grafana_data_source" "cloudwatch" {
  provider = grafana.data_source  
  type = "cloudwatch"
  name = "CloudWatch-Dev"
  
  json_data {
    default_region = var.region
    auth_type      = "keys"
  }

  secure_json_data {
    access_key = var.access_key_grafana
    secret_key = var.secret_key_grafana
  }
}

# terraform import grafana_data_source.cloudwatch Uf8VBRO4k 