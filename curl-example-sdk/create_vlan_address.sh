#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 5 ]; then
        printf "Usage: ./create_vlan_address.sh name vlan_interface ip netmask autoincrement\n" >&2
        exit 1
fi
name="$1"
vlan="$2"
ip="$3"
netmask="$4"
autoincrement="$5"

# get ids
vlan_id=`./get_object_id_by_param.sh vlans name "${vlan}"`
if [ -z "${vlan_id}" ]; then
        printf "Error: no vlan interface found with name ${vlan}\n" >&2
        exit 1
fi

# build header and payload
header="Content-Type: application/xml"
payload="<?xml version=1.0?>
<record>
  <name>${name}</name>
  <primary>true</primary>
  <vlan>
    <id>${vlan_id}</id>
  </vlan>
  <ip>${ip}</ip>
  <subnet>${netmask}</subnet>
  <span>1</span>
  <autoincrement>${autoincrement}</autoincrement>
</record>"

curl ${RXG_CURLOPTS} -X POST -H "${header}" -d "${payload}" "https://${RXG_FQDN}/admin/scaffolds/addresses/create.xml?api_key=${RXG_APIKEY}"
