#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 5 ]; then
        printf "Usage: ./create_vlan_address.sh name vlan_id ip netmask autoincrement\n" >&2
        exit 1
fi
name="$1"
vlan_id="$2"
ip="$3"
netmask="$4"
autoincrement="$5"

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
