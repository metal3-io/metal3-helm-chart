{{- define "ironic.conf" }}
[DEFAULT]
auth_strategy = noauth
my_ip = {{ .Values.ironic.configuration.provisioning_ip }}
debug = true
default_boot_interface = ipxe
default_deploy_interface = direct
default_inspect_interface = inspector
default_network_interface = noop
enabled_boot_interfaces = pxe,ipxe,fake,redfish-virtual-media
enabled_deploy_interfaces = direct,fake
enabled_hardware_types = ipmi,idrac,irmc,fake-hardware,redfish
enabled_inspect_interfaces = inspector,idrac,irmc,fake,redfish
enabled_management_interfaces = ipmitool,idrac,irmc,fake,redfish,idrac-redfish
enabled_power_interfaces = ipmitool,idrac,irmc,fake,redfish,idrac-redfish
enabled_raid_interfaces = no-raid,irmc,agent,fake
enabled_vendor_interfaces = ipmitool,no-vendor,idrac,fake
rpc_transport = json-rpc
use_stderr = true
[agent]
deploy_logs_collect = always
deploy_logs_local_path = /shared/log/ironic/deploy
[api]
host_ip = ::
api_workers = {{ .Values.ironic.configuration.api_workers }}
[conductor]
automated_clean = {{ .Values.ironic.configuration.automated_clean }}
send_sensor_data = true
send_sensor_data_interval = 160
api_url = http://{{ .Values.ironic.configuration.provisioning_ip }}:6385
bootloader = http://{{ .Values.ironic.configuration.provisioning_ip }}:{{ .Values.ironic.configuration.http_port }}/uefi_esp.img
[database]
connection = mysql+pymysql://ironic:{{- .Values.ironic.configuration.mariadb_password }}@localhost/ironic?charset=utf8
[deploy]
default_boot_option = local
erase_devices_metadata_priority = 10
erase_devices_priority = 0
http_root = /shared/html/
http_url = http://{{ .Values.ironic.configuration.provisioning_ip }}:{{ .Values.ironic.configuration.http_port }}
fast_track = {{ .Values.ironic.configuration.fast_track }}
[dhcp]
dhcp_provider = none
[inspector]
endpoint_override = http://{{ .Values.ironic.configuration.provisioning_ip }}:5050
[oslo_messaging_notifications]
driver = prometheus_exporter
location = /shared/ironic_prometheus_exporter
transport_url = fake://
[pxe]
images_path = /shared/html/tmp
instance_master_path = /shared/html/master_images
ipxe_enabled = true
pxe_config_template = $pybasedir/drivers/modules/ipxe_config.template
tftp_master_path = /shared/tftpboot
tftp_root = /shared/tftpboot
uefi_pxe_config_template = $pybasedir/drivers/modules/ipxe_config.template
[redfish]
use_swift = false
{{- end }}

{{- if .Values.ironic.config_override.ironic }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: ironic-config
data:
  ironic.conf: |
    {{- include "ironic.conf" . | indent 4 }}
{{- end }}
