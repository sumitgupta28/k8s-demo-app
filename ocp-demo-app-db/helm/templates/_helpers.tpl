{{/*
Expand the name of the chart.
*/}}
{{- define "ocp-demo-app-db.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ocp-demo-app-db.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ocp-demo-app-db.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ocp-demo-app-db.labels" -}}
helm.sh/chart: {{ include "ocp-demo-app-db.chart" . }}
{{ include "ocp-demo-app-db.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ocp-demo-app-db.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ocp-demo-app-db.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ocp-demo-app-db.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ocp-demo-app-db.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Create the name of the postgresql secret to use
*/}}
{{- define "ocp-demo-app-db.postgresql.secret" -}}
{{- printf "%s-%s" .Release.Name .Values.postgresql.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Create the name of the Service Name to use
*/}}
{{- define "ocp-demo-app-db.postgresql.service" -}}
{{- printf "%s-%s" .Release.Name .Values.postgresql.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}
