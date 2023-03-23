resource "grafana_contact_point" "my_email_contact_point" {
  provider = grafana.alert_source
  name     = "de_cf_alerts contact_point"

  email {
    addresses               = ["guru.prasad@ivendi.com"]
    message                 = "{{ template "email.message" . }}"
    subject                 = "{{ template "email.subject" . }}"
    single_email            = false
    disable_resolve_message = false
  }
}

# resource "grafana_contact_point" "my_slack_contact_point" {
#     name = "Send to My Slack Channel"

#     slack {
#         url = <YOUR_SLACK_WEBHOOK_URL>
#         text = <<EOT
#                {{ len .Alerts.Firing }} alerts are firing!

#                   Alert summaries:
#                   {{ range .Alerts.Firing }}
#                   {{ template "Alert Instance Template" . }}
#                   {{ end }}
#                EOT
#     }
# }