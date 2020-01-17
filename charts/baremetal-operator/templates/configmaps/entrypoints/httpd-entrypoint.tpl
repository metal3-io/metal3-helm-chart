{{- define "httpd-entrypoint"}}
#!/usr/bin/bash

. /bin/ironic-common.sh

HTTP_PORT=${HTTP_PORT:-"80"}

wait_for_interface_or_ip

mkdir -p /shared/html
chmod 0777 /shared/html

# Copy files to shared mount
cp /tmp/inspector.ipxe /shared/html/inspector.ipxe
cp /tmp/dualboot.ipxe /shared/html/dualboot.ipxe
cp /tmp/uefi_esp.img /shared/html/uefi_esp.img

if [ -f /cfg/inspector.ipxe ]; then
    cp -f /cfg/inspector.ipxe /shared/html/inspector.ipxe
else
    # Use configured values
    sed -i -e s/IRONIC_IP/${IRONIC_URL_HOST}/g -e s/HTTP_PORT/${HTTP_PORT}/g /shared/html/inspector.ipxe
fi
if [ -f /cfg/httpd.conf ]; then
    cp -f /cfg/httpd.conf /etc/httpd/conf/httpd.conf
else
    sed -i 's/^Listen .*$/Listen [::]:'"$HTTP_PORT"'/' /etc/httpd/conf/httpd.conf
    sed -i -e 's|\(^[[:space:]]*\)\(DocumentRoot\)\(.*\)|\1\2 "/shared/html"|' \
        -e 's|<Directory "/var/www/html">|<Directory "/shared/html">|' \
        -e 's|<Directory "/var/www">|<Directory "/shared">|' /etc/httpd/conf/httpd.conf
    # Log to std out/err
    sed -i -e 's%^ \+CustomLog.*%    CustomLog /dev/stderr combined%g' /etc/httpd/conf/httpd.conf
    sed -i -e 's%^ErrorLog.*%ErrorLog /dev/stderr%g' /etc/httpd/conf/httpd.conf
fi

/bin/runhealthcheck "httpd" "$HTTP_PORT" &>/dev/null &
exec /usr/sbin/httpd -DFOREGROUND

{{- end }}

{{- if .Values.ironic.config_override.httpd }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: httpd-entrypoint
data:
  runhttpd.sh: |
    {{- include "httpd-entrypoint" . | indent 4 }}
{{- end }}
