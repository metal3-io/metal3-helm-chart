{{- define "inspector.conf" }}
[DEFAULT]
auth_strategy = noauth
debug = true
transport_url = fake://
use_stderr = true
listen_address = ::
[database]
connection = sqlite:///var/lib/ironic-inspector/ironic-inspector.db
[discovery]
enroll_node_driver = ipmi
[ironic]
auth_type = none
endpoint_override = http://{{ .Values.ironic.configuration.provisioning_ip }}:6385
[processing]
always_store_ramdisk_logs = true
node_not_found_hook = enroll
permit_active_introspection = true
power_off = false
processing_hooks = $default_processing_hooks,extra_hardware,lldp_basic
ramdisk_logs_dir = /shared/log/ironic-inspector/ramdisk
store_data = database
[pxe_filter]
driver = noop
[service_catalog]
auth_type = none
endpoint_override = http://{{ .Values.ironic.configuration.provisioning_ip }}:5050
{{- end }}

{{- if .Values.ironic.config_override.inspector }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: inspector-config
data:
  inspector.conf: |
    {{- include "inspector.conf" . | indent 4 }}
{{- end }}
