{{- define "ironic-entrypoint"}}
#!/usr/bin/bash

. /bin/configure-ironic.sh

ironic-dbsync --config-file /etc/ironic/ironic.conf upgrade

# Remove log files from last deployment
rm -rf /shared/log/ironic

mkdir -p /shared/log/ironic

/usr/bin/ironic-conductor &
/usr/bin/ironic-api &

/bin/runhealthcheck "ironic" &>/dev/null &

sleep infinity
{{- end }}

{{- if .Values.ironic.config_override.ironic }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: ironic-entrypoint
data:
  runironic.sh: |
    {{- include "ironic-entrypoint" . | indent 4 }}
{{- end }}
