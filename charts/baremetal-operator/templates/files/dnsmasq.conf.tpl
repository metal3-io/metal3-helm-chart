{{- define "dnsmasq.conf" }}

interface={{ .Values.ironic.configuration.provisioning_interface }}
bind-dynamic
log-dhcp
enable-tftp
tftp-root=/shared/tftpboot

# Disable listening for DNS
port=0

dhcp-range={{ .Values.dnsmasq.dhcp_range }}

# Disable default router(s) and DNS over provisioning network
dhcp-option=3
dhcp-option=6

{{- if eq .Values.ironic.configuration.ipv "4" }}

# IPv4 Configuration:
dhcp-match=ipxe,175
# Client is already running iPXE; move to next stage of chainloading
dhcp-boot=tag:ipxe,http://{{ .Values.ironic.configuration.provisioning_ip }}:{{ .Values.ironic.configuration.http_port }}/dualboot.ipxe

# Note: Need to test EFI booting
dhcp-match=set:efi,option:client-arch,7
dhcp-match=set:efi,option:client-arch,9
dhcp-match=set:efi,option:client-arch,11
# Client is PXE booting over EFI without iPXE ROM; send EFI version of iPXE chainloader
dhcp-boot=tag:efi,tag:!ipxe,ipxe.efi

# Client is running PXE over BIOS; send BIOS version of iPXE chainloader
dhcp-boot=/undionly.kpxe,{{ .Values.ironic.configuration.provisioning_ip }}

{{ else }}
# IPv6 Configuration:
enable-ra
ra-param={{ .Values.ironic.configuration.provisioning_interface }},10
dhcp-vendorclass=set:pxe6,enterprise:343,PXEClient
dhcp-userclass=set:ipxe6,iPXE
dhcp-option=tag:pxe6,option6:bootfile-url,tftp://{{ .Values.ironic.configuration.provisioning_ip }}/snponly.efi
dhcp-option=tag:ipxe6,option6:bootfile-url,http://{{ .Values.ironic.configuration.provisioning_ip }}:{{ .Values.ironic.configuration.http_port }}/dualboot.ipxe
{{- end }}

{{- range $iface := split "," .Values.dnsmasq.except_interface }}
except-interface={{- $iface }}
{{- end }}

{{- end }}

{{- if .Values.ironic.config_override.dnsmasq }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: dnsmasq-config
data:
  dnsmasq.conf: |
    {{- include "dnsmasq.conf" . | indent 4 }}
{{- end }}

