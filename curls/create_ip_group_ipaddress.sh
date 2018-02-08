#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 4 ]; then
        printf "Usage: ./create_ip_group_ipaddress.sh name ip_address policy priority\n" >&2
        exit 1
fi
name="$1"
ip_address="$2"
policy="$3"
priority="$4"

# get policy id
policy_id=`./_get_object_id_from_name.sh policies ${policy}`
if [ -z "${policy_id}" ]; then
        printf "Error: no policy found with name ${policy}\n" >&2
        exit 1
fi

# get ip or build it
ip_id=`./_get_ip_id.sh ${ip_address}`
if [ -z "${ip_id}" ]; then
        ./create_ip.sh "${ip_address}"
        ip_id=`./_get_ip_id.sh ${ip_address}`
        if [ -z "${ip_id}" ]; then
                printf "Error: ip was not found\n" >&2
                exit 1
        fi
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
  <ips>
    <ip>
      <id>${ip_id}</id>
    </ip>
  </ips>
</record>"

curl ${RXG_CURLOPTS} -X POST -H "${header}" -d "${payload}" "https://${RXG_FQDN}/admin/scaffolds/ip_groups/create.xml?api_key=${RXG_APIKEY}"
