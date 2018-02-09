#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 2 ]; then
        printf "Usage: ./config_dataplane.sh local_interface local_vlan\n" >&2
        exit 1
fi
local_interface="$1"
local_vlan="$2"

# dict
name_prefix='vSZ-D'
local_ip='172.16.0.1'
mask='255.255.255.0'
mgmt_ip='172.16.0.2'
data_ip='172.16.0.3'
data_port_name='tunnel'
data_ports='23232,23233'

# build vlan and network address
. ./create_vlan.sh "${name_prefix}" ${local_vlan} ${local_interface}
. ./create_vlan_address.sh "LAN-${name_prefix}" "${name_prefix}" "${local_ip}" "${mask}" 1

# build mgmt group/policy
. ./create_policy.sh "${name_prefix}-mgmt"
. ./create_ip.sh ${mgmt_ip}
. ./create_ip_group_ipaddress.sh "${name_prefix}-mgmt" "${mgmt_ip}" "${name_prefix}-mgmt" 9

# build data group/policy
. ./create_policy.sh "${name_prefix}-data"
. ./create_ip.sh ${data_ip}
. ./create_ip_group_ipaddress.sh "${name_prefix}-data" "${data_ip}" "${name_prefix}-data" 9

# build port forward
. ./create_application_definition.sh "${data_port_name}" "${data_ports}"
. ./create_port_forward.sh "${name_prefix}-data" "${name_prefix}-data" "${data_port_name}"
