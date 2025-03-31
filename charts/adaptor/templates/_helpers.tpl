{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "adaptor.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "adaptor.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "adaptor.selectorLabels" -}}
app.kubernetes.io/name: {{ include "adaptor.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}


{{/*
Common labels
*/}}
{{- define "adaptor.labels" -}}
helm.sh/chart: {{ include "adaptor.chart" . }}
{{ include "adaptor.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Generate the full name of the resource.
*/}}
{{- define "adaptor.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Generate the name of the ServiceAccount.
*/}}
{{- define "adaptor.serviceAccountName" -}}
{{- printf "%s-%s" .Release.Name "serviceaccount" | trunc 63 | trimSuffix "-" -}}
{{- end -}}