resource "grafana_message_template" "alert_severity_template" {
  provider = grafana.alert_source
  name     = "_alert_severity"
  template = <<EOT
              {{ define "__alert_severity" -}}
                {{- if eq .CommonLabels.severity "critical" -}} 
                *Severity:* `Critical`
                {{- else if eq .CommonLabels.severity "warning" -}}
                *Severity:* `Warning`
                {{- else if eq .CommonLabels.severity "info" -}}
                *Severity:* `Info`
                {{- else -}}
                *Severity:* :question: {{ .CommonLabels.severity }}
                {{- end }}
              {{- end }}
            EOT  
}

resource "grafana_message_template" "color_template" {
  provider = grafana.alert_source
  name     = "slack_color"
  template = <<EOT
              {{ define "slack.color" -}}
                 {{ if eq .Status "firing" -}}
                    {{ if eq .CommonLabels.severity "warning" -}}
                        warning
                    {{- else if eq .CommonLabels.severity "critical" -}}
                        danger
                    {{- else -}}
                       #439FE0
                    {{- end -}}
                 {{ else -}}
                    good
                 {{- end }}
              {{- end }}
            EOT  
}

resource "grafana_message_template" "text_template" {
  provider = grafana.alert_source
  name     = "slack_text"
  template = <<EOT
                {{- define "email.message_alert" -}}
              
                  {{ if gt (len .Annotations) 0 }}
                  *Description*: {{ .Annotations.description }}
                  {{ end }}
                  
                  {{if eq ( .Labels.DistributionId ) "E1NLI73TEX07Q1"}} 
                     Name of distribution - iv_dev_bucket: {{ .Labels.DistributionId }} 
                  {{else if eq ( .Labels.DistributionId ) "E3UH6XMCST6DAO"}}
                      Name of distribution - shared_dev_cf: {{ .Labels.DistributionId }} 
                  {{else if eq ( .Labels.DistributionId ) "E32C2A880GX1GS"}}
                      Name of distribution - shared_de_test_cf: {{ .Labels.DistributionId }} 
                  {{else}}
                      No name set for distribution: {{ .Labels.DistributionId }} 
                  {{end}}
                  Lables:
                  {{- range .Labels.SortedPairs }}
                  • {{ .Name }}= `{{ .Value }}` {{ end }} has value(s) {{- range $k, $v := .Values }} {{ $k }}={{ $v }}{{ end }}
                  
                  {{ if gt (len .Annotations) 0 }}
                     Go to dashboard: {{ .DashboardURL }}
                  {{ end }}
                  
                  {{ end -}}
                  
                  {{ define "email.message" }}
                  There are {{ len .Alerts.Firing }} firing alert(s), and {{ len .Alerts.Resolved }} resolved alert(s)
                  
                  {{ if .Alerts.Firing -}}
                  🚨 Firing alerts:
                  {{- range .Alerts.Firing }}
                  - {{ template "email.message_alert" . }}
                  {{- end }}
                  {{- end }}
                  
                  {{ if .Alerts.Resolved -}}
                  ✅ Resolved alerts:
                  {{- range .Alerts.Resolved }}
                  - {{ template "email.message_alert" . }}
                  {{- end }}
                  {{- end }}
              
              {{ end }}              
            EOT  
}

resource "grafana_message_template" "title_template" {
  provider = grafana.alert_source
  name     = "slack_title"
  template = <<EOT
              {{ define "email.subject" }}
                {{ len .Alerts.Firing }} firing alert(s), {{ len .Alerts.Resolved }} resolved alert(s)
              {{ end }}
            EOT  
}

# resource "grafana_message_template" "titlelink_template" {
#   provider = grafana.alert_source
#   name     = "_alert_title_link"
#   template = <<EOT
#               {{ define "URL" }}https://ivendi.grafana.net/alerting/list?queryString=alertname%3D{{ .CommonLabels.alertname }}{{ end }}
#             EOT  
# }