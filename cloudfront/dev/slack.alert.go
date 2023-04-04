{{ define "slack.message_alert" }}
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
{{end}}  /* end of if */
Lables:
{{- range .Labels.SortedPairs }}
• {{ .Name }}= `{{ .Value }}` {{ end }} has value(s) {{- range $k, $v := .Values }} {{ $k }}={{ $v }}{{ end }}

{{ if gt (len .Annotations) 0 }}
   Go to dashboard: {{ .DashboardURL }}
{{ end }}

{{ end -}}  /* end of slack.message_alert template */

{{ define "slack.message" }}
There are {{ len .Alerts.Firing }} firing alert(s), and {{ len .Alerts.Resolved }} resolved alert(s)

{{ if .Alerts.Firing -}}
🚨 Firing alerts:{{- range .Alerts.Firing }}
- {{ template "slack.message_alert" . }}{{- end }}
{{- end }} 

{{ if .Alerts.Resolved -}}
✅ Resolved alerts:{{- range .Alerts.Resolved }}
- {{ template "slack.message_alert" . }}{{- end }}
{{- end }}

{{ end }}  /* end of slack.message template */

/* ----------------------
{{ define "slack.message_alert" -}}
{{ range . }}
{{ if len .Values -}}
Values:
{{- range $refID, $value := .Values -}}
    - {{ $refID }} = {{ $value }}
{{ end -}}
{{ end -}}
{{ if len .Labels.SortedPairs }}
Labels:
{{ range .Labels.SortedPairs -}}
    - {{ .Name }} = {{ .Value }}
{{ end -}}
{{ end -}}
{{ if len .Annotations.SortedPairs }}
Annotations:
{{ range .Annotations.SortedPairs -}}
    - {{ .Name }} = {{ .Value }}
{{ end -}}
{{ end -}}
{{ end -}} 
{{ end -}} 

{{ define "slack_template" }}
{{ if gt (len .Alerts.Firing) 0 }}
🚨 FIRING!!!
{{- template "alertas" .Alerts.Firing -}}
{{ end -}}
{{ if gt (len .Alerts.Resolved) 0 }}
✅ RESOLVED!
{{- template "alertas" .Alerts.Resolved -}}
{{ end -}}
<a href="192.168.0.11:3000">Dashboard</a>
{{ end }}
*/