#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 2 ]; then
        printf "Usage: ./create_application_definition.sh name ports\n" >&2
        exit 1
fi
name="$1"
ports="$2"

# build header and payload
header="Content-Type: application/xml"
payload="<?xml version=1.0?>
<record>
  <name>${name}</name>
  <protocol>tcp udp</protocol>
  <destination_ports>${ports}</destination_ports>
</record>"

curl ${RXG_CURLOPTS} -X POST -H "${header}" -d "${payload}" "https://${RXG_FQDN}/admin/scaffolds/net_apps/create.xml?api_key=${RXG_APIKEY}"
