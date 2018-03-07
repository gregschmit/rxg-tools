#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 4 ]; then
        printf "Usage: ./create_ip_group_netaddress.sh name network_address policy priority\n" >&2
        exit 1
fi
name="$1"
address="$2"
policy="$3"
priority="$4"

# get address and policy id
address_id=`./get_object_id_by_param.sh addresses name ${address}`
if [ -z "${address_id}" ]; then
        printf "Error: no address found with name ${address}\n" >&2
        exit 1
fi
policy_id=`./get_object_id_by_param.sh policies name ${policy}`
if [ -z "${policy_id}" ]; then
        printf "Error: no policy found with name ${policy}\n" >&2
        exit 1
fi

# build header and payload
header="Content-Type: application/xml"
payload="<?xml version=1.0?>
<record>
  <name>${name}</name>
  <policy>
    <id>${policy_id}</id>
  </policy>
  <priority>${priority}</priority>
  <addresses>
    <address>
      <id>${address_id}</id>
    </address>
  </addresses>
</record>"

curl ${RXG_CURLOPTS} -X POST -H "${header}" -d "${payload}" "https://${RXG_FQDN}/admin/scaffolds/ip_groups/create.xml?api_key=${RXG_APIKEY}"
