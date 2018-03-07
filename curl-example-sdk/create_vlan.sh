#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 3 ]; then
        printf "Usage: ./create_vlan.sh name vlan interface\n" >&2
        exit 1
fi
name="$1"
vlan="$2"
interface="$3"

# get ids
interface_id=`./get_object_id_by_param.sh interfaces name ${interface}`
if [ -z "${interface_id}" ]; then
        printf "Error: no interface found with name ${interface}\n" >&2
        exit 1
fi

# build header and payload
header="Content-Type: application/xml"
payload="<?xml version=1.0?>
<record>
  <name>${name}</name>
  <tag>${vlan}</tag>
  <mtu>1500</mtu>
  <interface>
    <id>${interface_id}</id>
  </interface>
</record>"

curl ${RXG_CURLOPTS} -X POST -H "${header}" -d "${payload}" "https://${RXG_FQDN}/admin/scaffolds/vlans/create.xml?api_key=${RXG_APIKEY}"
