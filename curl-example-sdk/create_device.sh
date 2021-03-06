#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 3 ]; then
        printf "Usage: ./create_device.sh name mac account_id\n" >&2
        exit 1
fi
name="$1"
mac="$2"
account_id="$3"

# build header, payload
header="Content-Type: application/xml"
payload="<?xml version=1.0?>
<record>
  <name>${name}</name>
  <mac>${mac}</mac>
  <account>
    <id>${account_id}</id>
  </account>
</record>"

curl ${RXG_CURLOPTS} -X POST -H "${header}" -d "${payload}" "https://${RXG_FQDN}/admin/scaffolds/devices/create.xml?api_key=${RXG_APIKEY}"
