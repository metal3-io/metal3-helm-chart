<%!
    import os
%>
{{ $keystone_service_name := include "ironicStandalone.keystone.fullname" . }}
{{ range $section, $params := .Values.config }}
[{{ $section }}]
{{- if eq $section "DEFAULT" }}
{{- if $.Values.keystone.enabled }}
auth_strategy = keystone
{{- else if not $.Values.config.DEFAULT.auth_strategy }}
auth_strategy = noauth
{{- end }}
{{- if eq ($.Values.config.DEFAULT.auth_strategy | default "default") "http_basic" }}
http_basic_auth_user_file = /etc/ironic/auth/htpasswd
{{- end }}
{{- if $.Values.rabbitmq.enabled }}
transport_url = rabbit://{{ $.Values.rabbitmq.auth.username }}:${os.environ.get('RABBITMQ_PASSWORD','')}@{{ $.Release.Name }}-rabbitmq:{{ $.Values.rabbitmq.auth.nodePort }}
{{- end }}
{{- end }}
{{- if eq $section "api" }}
port = {{ $.Values.api.portInternal }}
{{- end }}
{{- if eq $section "keystone_authtoken" }}
{{- if $.Values.keystone.enabled }}
auth_type = password
www_authenticate_uri = http://{{ $keystone_service_name }}:{{ $.Values.keystone.portExternal }}
auth_url = http://{{ $keystone_service_name }}:{{ $.Values.keystone.portExternal }}
username = {{ $.Values.keystone.ironic_user }}
password = {{ $.Values.keystone.ironic_password }}
project_name = {{ $.Values.keystone.ironic_project_name }}
project_domain_name = default
user_domain_name = default
{{- end }}
{{- end }}
{{- if eq $section "conductor" }}
{{- if $.Values.api.ingress.enabled }}
{{- if or $.Values.api.ingress.tls  $.Values.api.ingress.extraTls}}
api_url = https://{{ $.Values.api.ingress.hostname }}/
{{ else }}
api_url = http://{{ $.Values.api.ingress.hostname }}/
{{- end }}
{{- else if $.Values.api.externalIPs }}
api_url = http://{{ $.Values.api.externalIPs | first }}:{{ $.Values.api.portExternal }}/
{{- else if $.Values.api.loadBalancerIP }}
api_url = http://{{ $.Values.api.loadBalancerIP }}:{{ $.Values.api.portExternal }}/
{{- end }}
{{- end }}
{{- if eq $section "database" }}
connection = mysql+pymysql://{{ template "ironicStandalone.database.username" $ }}:${os.environ.get('MARIADB_PASSWORD','')}@{{ template "ironicStandalone.database.host" $ }}/{{ template "ironicStandalone.database.name" $ }}?charset=utf8
{{- end }}
{{- if eq $section "deploy" }}
{{- if $.Values.httpboot.ingress.enabled }}
{{- if or $.Values.httpboot.ingress.tls  $.Values.httpboot.ingress.extraTls }}
http_url = https://{{ $.Values.httpboot.ingress.hostname }}/
{{ else }}
http_url = http://{{ $.Values.httpboot.ingress.hostname }}/
{{- end }}
{{- else }}
{{- if $.Values.httpboot.externalIPs }}
http_url = http://{{ $.Values.httpboot.externalIPs | first }}/
{{- else if $.Values.httpboot.loadBalancerIP }}
http_url = http://{{ $.Values.httpboot.loadBalancerIP }}/
{{- end }}
{{- end }}
{{- end }}
{{- if eq $section "pxe" }}
{{- if $.Values.tftp.public_ip }}
tftp_server = {{ $.Values.tftp.public_ip }}
{{- else if $.Values.tftp.externalIPs }}
tftp_server = {{ $.Values.tftp.externalIPs  | first }}
{{- end }}
{{- end }}
{{- range $key, $val := $params }}
{{ $key }} = {{ $val }}
{{- end }}
{{ end }}
