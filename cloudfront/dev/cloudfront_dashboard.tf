provider "grafana" {
  alias = "dashboard_source"
  url  = var.grafana_url
  auth = var.grafana_api_key
}


resource "grafana_folder" "test" {
  provider = grafana.dashboard_source

  title = "dev-cloudfront"
}

# resource "grafana_dashboard" "metrics" {
#    provider = grafana.dashboard_source

#    config_json = file("cloudfront_distribution.json")
#    folder      = grafana_folder.test.id
#  }
