{{- define "init-bootstrap"}}
#!/usr/bin/env bash
set -xe

mkdir -p /shared/{tftpboot,html/{images,pxelinux.cfg},log/{dnsmasq,httpd,ironic,ironic-inspector/ramdisk,mariadb}/}

# Copy files to shared mount
#cp /usr/lib/ipxe/undionly.kpxe /usr/lib/ipxe/ipxe.efi /shared/tftpboot
#cp /tmp/inspector.ipxe /shared/html/inspector.ipxe
#cp /tmp/dualboot.ipxe /shared/html/dualboot.ipxe

# Remove log files from last deployment
rm -rf /shared/log/httpd/*
rm -rf /shared/log/ironic/*
rm -rf /shared/log/ironic-inspector/*

pushd /shared/html/images
  declare -A ARTS
  {{- range $key, $val := .Values.init_bootstrap.provisioning_files }}
  ARTS[{{ $key | quote}}]={{ $val | quote }}
  {{- end}}

  for art in "${!ARTS[@]}"; do
    if [ ! -f ${art} ] ; then
        STATUSCODE=$(curl --silent --insecure --location --output ${art} --write-out "%{http_code}" ${ARTS[${art}]} )

        if test $STATUSCODE -ne 200; then
          echo "Failed to load ${ARTS[${art}]}"
          exit 1
        fi
        if [[ ! "${art}" =~ \.tar$ ]] && [[ ! "${art}" =~ \.md5sum$ ]] && [[ ! "${!ARTS[@]}" =~ "${art}.md5sum" ]] ; then
           md5sum "${art}" | awk '{print $1}' > "${art}.md5sum"
        fi
        if [[ "${art}" =~ \.tar$ ]]; then
          tar -xf "${art}"
        fi
    fi
  done
popd
chmod -R 0777 /shared/html

touch /shared/init_finished
{{- end }}

{{- if .Values.init_bootstrap.enabled }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: init-bootstrap
data:
  init-bootstrap: |
    {{- include "init-bootstrap" . | indent 4 }}
{{- end }}
