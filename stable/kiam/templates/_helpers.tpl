{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "kiam.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kiam.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified agent name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kiam.agent.fullname" -}}
{{- if .Values.agent.fullnameOverride -}}
{{- .Values.agent.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.agent.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.agent.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified server name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kiam.server.fullname" -}}
{{- if .Values.server.fullnameOverride -}}
{{- .Values.server.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.server.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.server.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kiam.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name of the agent service account to use.
*/}}
{{- define "kiam.serviceAccountName.agent" -}}
{{- if .Values.serviceAccounts.agent.create -}}
    {{ default (include "kiam.agent.fullname" .) .Values.serviceAccounts.agent.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.agent.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the server service account to use.
*/}}
{{- define "kiam.serviceAccountName.server" -}}
{{- if .Values.serviceAccounts.server.create -}}
    {{ default (include "kiam.server.fullname" .) .Values.serviceAccounts.server.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.server.name }}
{{- end -}}
{{- end -}}


{{/*
Define the name of the server secret that contains our tls files.
*/}}
{{- define "kiam.server.secretName" -}}
{{- if .Values.server.useProvidedTlsSecret -}}
{{- .Values.server.tlsSecretName -}}
{{- else -}}
{{- printf "%s-server" (include "kiam.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Define the name of the agent secret that contains our tls files.
*/}}
{{- define "kiam.agent.secretName" -}}
{{- if .Values.agent.useProvidedTlsSecret -}}
{{- .Values.agent.tlsSecretName -}}
{{- else -}}
{{- printf "%s-agent" (include "kiam.fullname" .) -}}
{{- end -}}
{{- end -}}
