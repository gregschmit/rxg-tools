#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 3 ]; then
        printf "Usage: ./create_port_forward.sh name policy application\n" >&2
        exit 1
fi
name="$1"
policy="$2"
app="$3"

# get ids
policy_id=`./get_object_id_by_param.sh policies name ${policy}`
if [ -z "${policy_id}" ]; then
        printf "Error: no policy found with name ${policy}\n" >&2
        exit 1
fi
app_id=`./get_object_id_by_param.sh net_apps name ${app}`
if [ -z "${app_id}" ]; then
        printf "Error: no application definition found with name ${app}\n" >&2
        exit 1
fi

# build header and payload
header="Content-Type: application/xml"
payload="<?xml version=1.0?>
<record>
  <name>${name}</name>
  <policy_mode>first</policy_mode>
  <direction>inbound</direction>
  <policy>
    <id>${policy_id}</id>
  </policy>
  <net_apps>
    <net_app>
      <id>${app_id}</id>
    </net_app>
  </net_apps>
</record>"

curl ${RXG_CURLOPTS} -X POST -H "${header}" -d "${payload}" "https://${RXG_FQDN}/admin/scaffolds/net_app_inbound_forwards/create.xml?api_key=${RXG_APIKEY}"
