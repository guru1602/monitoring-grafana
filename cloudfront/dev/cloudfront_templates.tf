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
                 {{ define "slack.text" -}}
                 {{ template "__alert_severity" . }}
                 {{- if (index .Alerts 0).Annotations.summary }}
                 {{- "\n" -}}
                 *Summary:* {{ (index .Alerts 0).Annotations.summary }}
                 {{- end -}}
                 {{ range .Alerts }}
                    {{- if .Annotations.description }}
                    {{- "\n" -}}
                    *Description:* {{ .Annotations.description }}
                    {{- end -}}
                    {{- if .Annotations.message }}
                    {{- "\n" -}}
                    *Message:* {{ .Annotations.message }}
                    {{- end -}}
                    {{- "\n" -}}
                    *Details:*
                      {{ range .Labels.SortedPairs }} • {{ .Name }}: `{{ .Value }}`
                      {{ end }}
                 {{- end }}
               {{- end }}
            EOT  
}

resource "grafana_message_template" "title_template" {
  provider = grafana.alert_source
  name     = "slack_title"
  template = <<EOT
              {{ define "slack.title" -}}
                 [{{ .Status | toUpper -}}
                  {{ if eq .Status "firing" }}:{{ .Alerts.Firing | len }}{{- end -}}
                 ] {{ .CommonLabels.alertname }}
              {{- end }}
            EOT  
}

# resource "grafana_message_template" "titlelink_template" {
#   provider = grafana.alert_source
#   name     = "_alert_title_link"
#   template = <<EOT
#               {{ define "URL" }}https://ivendi.grafana.net/alerting/list?queryString=alertname%3D{{ .CommonLabels.alertname }}{{ end }}
#             EOT  
# }