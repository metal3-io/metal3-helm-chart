{{/*
Expand the name of the chart.
*/}}
{{- define "test-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "test-chart.fullname" -}}
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
{{- define "test-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "test-chart.labels" -}}
helm.sh/chart: {{ include "test-chart.chart" . }}
{{ include "test-chart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "test-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "test-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "test-chart.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "test-chart.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "cloud.conf" -}}
[Global]
auth-url="{{ required "missing OsAuthUrl" .Values.OsAuthUrl }}"
username="{{ required "missing Username" .Values.Username }}"
user-domain-id="{{ required "missing UserDomainId" .Values.UserDomainId }}"
password="{{ required "missing Password" .Values.Password }}"
tenant-id="{{ required "missing TenantId" .Values.TenantId }}"
project-domain-name="{{ required "missing ProjectDomainName" .Values.ProjectDomainName }}"
region="{{ required "missing Region" .Values.Region }}"
{{- if .Values.Cacert }}
ca-file="/etc/ssl/certs/rootcax1.crt"
{{- end }}
{{- end -}}


{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "ironicStandalone.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ironicStandalone.fullname" -}}
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
Create chart name and version as used by the chart label.
*/}}
{{- define "ironicStandalone.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a fully qualified Ironic httpboot name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "ironicStandalone.httpboot.fullname" -}}
{{- if .Values.httpboot.fullnameOverride -}}
{{- .Values.httpboot.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.httpboot.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.httpboot.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified Ironic conductor name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "ironicStandalone.conductor.fullname" -}}
{{- if .Values.conductor.fullnameOverride -}}
{{- .Values.conductor.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.conductor.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.conductor.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified Ironic api name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "ironicStandalone.api.fullname" -}}
{{- if .Values.api.fullnameOverride -}}
{{- .Values.api.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.api.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.api.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified Keystone name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "ironicStandalone.keystone.fullname" -}}
{{- if .Values.keystone.fullnameOverride -}}
{{- .Values.keystone.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.keystone.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.keystone.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified Ironic tftp name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "ironicStandalone.tftp.fullname" -}}
{{- if .Values.tftp.fullnameOverride -}}
{{- .Values.tftp.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.tftp.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.tftp.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified Ironic mgmt name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "ironicStandalone.mgmt.fullname" -}}
{{- if .Values.mgmt.fullnameOverride -}}
{{- .Values.mgmt.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.mgmt.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.mgmt.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "ironicStandalone.mariadb.fullname" -}}
{{- $name := default "mariadb" .Values.mariadb.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "ironicStandalone.database.host" -}}
  {{- if eq .Values.mariadb.enabled true -}}
    {{- template "ironicStandalone.mariadb.fullname" . }}
  {{- else -}}
    {{- .Values.externalDatabase.host -}}
  {{- end -}}
{{- end -}}

{{- define "ironicStandalone.database.port" -}}
  {{- if eq .Values.mariadb.enabled true -}}
    {{- printf "%s" "3306" -}}
  {{- else -}}
    {{- .Values.externalDatabase.port -}}
  {{- end -}}
{{- end -}}

{{- define "ironicStandalone.database.username" -}}
  {{- if eq .Values.mariadb.enabled true -}}
    {{- default "root" .Values.mariadb.auth.username -}}
  {{- else -}}
    {{- .Values.externalDatabase.user -}}
  {{- end -}}
{{- end -}}
{{- define "ironicStandalone.database.rawPassword" -}}
  {{- if eq .Values.mariadb.enabled true -}}
      {{- .Values.mariadb.auth.password -}}
  {{- else -}}
      {{- .Values.externalDatabase.password -}}
  {{- end -}}
{{- end -}}
{{- define "ironicStandalone.database.encryptedPassword" -}}
  {{- include "ironicStandalone.database.rawPassword" . | b64enc | quote -}}
{{- end -}}
{{- define "ironicStandalone.database.rawrootPassword" -}}
  {{- if eq .Values.mariadb.enabled true -}}
      {{- .Values.mariadb.auth.rootPassword -}}
  {{- else -}}
      {{- .Values.externalDatabase.rootPassword -}}
  {{- end -}}
{{- end -}}
{{- define "ironicStandalone.database.encryptedrootPassword" -}}
  {{- include "ironicStandalone.database.rawrootPassword" . | b64enc | quote -}}
{{- end -}}

{{- define "ironicStandalone.database.name" -}}
  {{- if eq .Values.mariadb.enabled true -}}
    {{- .Values.mariadb.auth.database -}}
  {{- else -}}
    {{- .Values.externalDatabase.name -}}
  {{- end -}}
{{- end -}}
{{- define "ironicStandalone.database.sslmode" -}}
  {{- if eq .Values.mariadb.enabled true -}}
    {{- printf "%s" "disable" -}}
  {{- else -}}
    {{- .Values.externalDatabase.sslmode -}}
  {{- end -}}
{{- end -}}