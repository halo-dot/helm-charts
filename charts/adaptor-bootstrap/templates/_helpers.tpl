{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "bootstrap.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "bootstrap.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "bootstrap.selectorLabels" -}}
app.kubernetes.io/name: {{ include "bootstrap.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "bootstrap.labels" -}}
helm.sh/chart: {{ include "bootstrap.chart" . }}
{{ include "bootstrap.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Helper for acquirer details
*/}}
{{- define "bootstrap.acquirerDetails" -}}
name: {{ .Values.acquirerDetails.name }}
alias: {{ .Values.acquirerDetails.alias }}
jwtIssuerName: {{ .Values.acquirerDetails.jwtIssuerName }}
defaultTerminalCurrencyCode: {{ .Values.acquirerDetails.defaultTerminalCurrencyCode }}
passThrough: {{ .Values.acquirerDetails.passThrough | quote }}
{{- end -}}

{{/*
Helper for payment processor details
*/}}
{{- define "bootstrap.paymentProcessorDetails" -}}
name: {{ .Values.paymentProcessorDetails.name }}
url: {{ .Values.paymentProcessorDetails.url }}
jweExpiry: {{ .Values.paymentProcessorDetails.jweExpiry | quote }}
jweEncryption: {{ .Values.paymentProcessorDetails.jweEncryption | quote }}
{{- end -}}