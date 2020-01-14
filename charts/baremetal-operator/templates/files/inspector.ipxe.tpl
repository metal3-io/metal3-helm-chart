{{- define "inspector.ipxe" }}
#!ipxe

:retry_boot
echo In inspector.ipxe
imgfree
# NOTE(dtantsur): keep inspection kernel params in [mdns]params in ironic-inspector-image
kernel --timeout 60000 http://{{ .Values.ironic.configuration.provisioning_ip }}:{{ .Values.ironic.configuration.http_port }}/images/ironic-python-agent.kernel ipa-inspection-callback-url=http://{{ .Values.ironic.configuration.provisioning_ip }}:5050/v1/continue ipa-inspection-collectors=default,extra-hardware,logs systemd.journald.forward_to_console=yes BOOTIF=${mac} ipa-debug=1 ipa-inspection-dhcp-all-interfaces=1 ipa-collect-lldp=1 initrd=ironic-python-agent.initramfs || goto retry_boot
initrd --timeout 60000 http://{{ .Values.ironic.configuration.provisioning_ip }}:{{ .Values.ironic.configuration.http_port }}/images/ironic-python-agent.initramfs || goto retry_boot
boot
{{- end }}

{{- if .Values.ironic.config_override.inspector_ipxe }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: inspector-ipxe-config
data:
  inspector.ipxe: |
    {{- include "inspector.ipxe" . | indent 4 }}
{{- end }}
