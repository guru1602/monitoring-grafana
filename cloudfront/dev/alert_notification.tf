resource "grafana_notification_policy" "my_policy" {
    provider      = grafana.alert_source
    group_by      = ["cloudfront_alert"]
    contact_point = grafana_contact_point.my_email_contact_point.name

    policy {
        matcher {
            label = "namespace"
            match = "="
            value = "dev cloudfront"
        }
        matcher {
            label = "alertname"
            match = "="
            value = "5xxErrorRate"
        }
        group_by = ["cloudfront_alert"]
        contact_point = grafana_contact_point.my_email_contact_point.name
        # mute_timings = [grafana_mute_timing.my_mute_timing.name]
    }
}