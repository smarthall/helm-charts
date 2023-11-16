{{/*
Expand the name of the chart.
*/}}
{{- define "mealie.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mealie.fullname" -}}
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
{{- define "mealie.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mealie.labels" -}}
helm.sh/chart: {{ include "mealie.chart" . }}
{{ include "mealie.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mealie.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mealie.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mealie.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "mealie.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "mealie.apiContainer" -}}
- name: api
  securityContext:
  {{- toYaml .Values.securityContext | nindent 4 }}
  image: "{{ .Values.image.repository }}:{{ .Values.image.tagPrefixApi }}{{ .Values.image.tag | default .Chart.AppVersion }}"
  imagePullPolicy: {{ .Values.image.pullPolicy }}
  env:
  - name: BASE_URL
    value: "{{ if .Values.ingress.enabled }}https://{{ (index .Values.ingress.hosts 0).host }}{{ else }}http://localhost:8080{{ end }}"
  {{- range $key, $value := .Values.api.env }}
  - name: "{{ $key }}"
    value: "{{ $value }}"
  {{- end }}
  volumeMounts:
  - name: data
    mountPath: /app/data
  ports:
  - name: api
    containerPort: {{ .Values.api.service.port }}
    protocol: TCP
  livenessProbe:
    initialDelaySeconds: 60
    httpGet:
      path: /api/app/about
      port: api
  readinessProbe:
    initialDelaySeconds: 60
    httpGet:
      path: /api/app/about
      port: api
  resources:
  {{- toYaml .Values.resources | nindent 4 }}
{{- end }}

{{- define "mealie.frontendContainer" -}}
- name: frontend
  securityContext:
    {{- toYaml .Values.securityContext | nindent 4 }}
  image: "{{ .Values.image.repository }}:{{ .Values.image.tagPrefixFrontend }}{{ .Values.image.tag | default .Chart.AppVersion }}"
  imagePullPolicy: {{ .Values.image.pullPolicy }}
  env:
    - name: API_URL
      value: "http://{{ if and .Values.storage.enabled (eq .Values.storage.accessMode "ReadWriteMany") }}{{ include "mealie.fullname" . }}-api{{ else }}localhost{{ end }}:{{ .Values.api.service.port }}"
    {{- range $key, $value := .Values.frontend.env }}
    - name: "{{ $key }}"
      value: "{{ $value }}"
    {{- end }}
  volumeMounts:
    - name: data
      mountPath: /app/data
  ports:
    - name: frontend
      containerPort: {{ .Values.frontend.service.port }}
      protocol: TCP
  livenessProbe:
    initialDelaySeconds: 60
    httpGet:
      path: /
      port: frontend
  readinessProbe:
    initialDelaySeconds: 60
    httpGet:
      path: /
      port: frontend
  resources:
    {{- toYaml .Values.resources | nindent 4 }}
{{- end -}}
