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