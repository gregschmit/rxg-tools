#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 1 ]; then
        printf "Usage: ./create_ip.sh ip\n" >&2
        exit 1
fi
ip="$1"

# build header and payload
header="Content-Type: application/xml"
payload="<?xml version=1.0?>
<record>
  <ip>${ip}</ip>
</record>"

curl ${RXG_CURLOPTS} -X POST -H "${header}" -d "${payload}" "https://${RXG_FQDN}/admin/scaffolds/ips/create.xml?api_key=${RXG_APIKEY}"
