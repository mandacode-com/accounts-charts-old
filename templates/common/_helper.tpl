{{- define "app.name" }}
{{- if .Values.nameOverride }}
{{- .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else -}}
accounts
{{- end -}}
{{- end }}

{{- define "app.fullname" }}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else -}}
{{- include "app.name" . }}-{{ .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end -}}
{{- end }}

{{- define "app.namespace" }}
{{- if .Values.namespaceOverride }}
{{- .Values.namespaceOverride | trunc 63 | trimSuffix "-" }}
{{- else -}}
{{- .Release.Namespace | trunc 63 | trimSuffix "-" }}
{{- end -}}
{{- end }}


{{- define "app.labels" -}}
{{ include "app.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "app.selectorLabels" -}}
{{- $name := include "app.name" . }}
{{- $fullname := include "app.fullname" . }}
app.kubernetes.io/name: {{ $name }}
app.kubernetes.io/instance: {{ $fullname }}
{{- end }}

{{- define "app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- include "app.fullname" . }}
{{- else -}}
{{- .Values.serviceAccount.name | default (include "app.fullname" .) }}
{{- end -}}
{{- end }}
