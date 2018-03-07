#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 1 ]; then
        printf "Usage: ./create_application_definition.sh name\n" >&2
        exit 1
fi
name="$1"

# get id from name
app_def_id=`./_get_object_id_by_param.sh net_apps name "${name}"`
if [ -z "${app_def_id}" ]; then
        printf "Error: application definition not found\n" >&2
        exit 1
fi

curl ${RXG_CURLOPTS} -X DELETE -H "Content-Type: application/xml" "https://${RXG_FQDN}/admin/scaffolds/net_apps/destroy/${app_def_id}.xml?api_key=${RXG_APIKEY}"
