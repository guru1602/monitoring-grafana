output "cloudwatch_uid" {
  value = grafana_data_source.cloudwatch.uid
  }

output "cloudwatch_dashboard_uid" {
  value = grafana_dashboard.metrics.uid
  }

output "folder_uid" {
  value = grafana_folder.test.uid
  }