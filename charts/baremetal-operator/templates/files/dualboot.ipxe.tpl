{{- define "dualboot.ipxe" }}
#!ipxe

# NOTE(lucasagomes): Loop over all network devices and boot from
# the first one capable of booting. For more information see:
# https://bugs.launchpad.net/ironic/+bug/1504482
set netid:int32 -1
:loop
inc netid
isset ${net${netid}/mac} || chain pxelinux.cfg/${mac:hexhyp} || goto inspector
echo Attempting to boot from MAC ${net${netid}/mac:hexhyp}
chain pxelinux.cfg/${net${netid}/mac:hexhyp} || goto loop

# If no networks configured to boot then introspect first valid one
:inspector
chain inspector.ipxe || goto loop_done

:loop_done
echo PXE boot failed! No configuration found for any of the present NICs
echo and could not find inspector.ipxe to use as fallback.
echo Press any key to reboot...
prompt --timeout 180
reboot
{{- end }}

{{- if .Values.ironic.config_override.dualboot_ipxe }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: dualboot-ipxe-config
data:
  dualboot.ipxe: |
    {{- include "dualboot.ipxe" . | indent 4 }}
{{- end }}