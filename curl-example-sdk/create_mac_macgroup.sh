#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 2 ]; then
        printf "Usage: ./create_mac_macgroup.sh mac macgroup_id\n" >&2
        exit 1
fi
mac="$1"
macgroup_id="$2"

# build header and payload
header="Content-Type: application/xml"
payload="<?xml version=1.0?>
<record>
  <mac>${mac}</mac>
  <mac-groups>
    <mac-group>
      <id>${macgroup_id}</id>
    </mac-group>
  </mac-groups>
</record>"

curl ${RXG_CURLOPTS} -X POST -H "${header}" -d "${payload}" "https://${RXG_FQDN}/admin/scaffolds/macs/create.xml?api_key=${RXG_APIKEY}"
