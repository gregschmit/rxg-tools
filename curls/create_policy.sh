#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 1 ]; then
        printf "Usage: ./create_policy.sh name\n"
        exit 1
fi
name="$1"

# build header and payload
header="Content-Type: application/xml"
payload="<?xml version=1.0?>
<record>
  <name>${name}</name>
</record>"

curl ${RXG_CURLOPTS} -X POST -H "${header}" -d "${payload}" "https://${RXG_FQDN}/admin/scaffolds/policies/create.xml?api_key=${RXG_APIKEY}"
