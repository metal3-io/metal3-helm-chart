{{- define "inspector-entrypoint"}}
#!/usr/bin/bash

CONFIG=/etc/ironic-inspector/inspector.conf

. /bin/ironic-common.sh

wait_for_interface_or_ip

# Remove log files from last deployment
rm -rf /shared/log/ironic-inspector

mkdir -p /shared/log/ironic-inspector

cp $CONFIG $CONFIG.orig

crudini --set $CONFIG ironic endpoint_override http://$IRONIC_URL_HOST:6385
crudini --set $CONFIG service_catalog endpoint_override http://$IRONIC_URL_HOST:5050

exec /usr/bin/ironic-inspector --config-file /etc/ironic-inspector/inspector-dist.conf \
	--config-file /etc/ironic-inspector/inspector.conf \
	--log-file /shared/log/ironic-inspector/ironic-inspector.log
{{- end }}

{{- if .Values.ironic.config_override.inspector }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: inspector-entrypoint
data:
  runironic-inspector.sh: |
    {{- include "inspector-entrypoint" . | indent 4 }}
{{- end }}
