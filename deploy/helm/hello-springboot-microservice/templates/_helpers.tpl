{{/* Expand the name of the chart. */}}
{{- define "helm_chart_name_version" -}}
{{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end }}
