#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 2 ]; then
        printf "Usage: ./delete_object_by_param.sh scaffold param value\n" >&2
        exit 1
fi
scaffold="$1"
param="$2"
value="$3"

# get id from param value
object_id=`./get_object_id_by_param.sh "${scaffold}" "${param}" "${value}"`
if [ -z "${object_id}" ]; then
        printf "Error: object not found\n" >&2
        exit 1
fi

curl ${RXG_CURLOPTS} -X DELETE -H "Content-Type: application/xml" "https://${RXG_FQDN}/admin/scaffolds/${scaffold}/destroy/${object_id}.xml?api_key=${RXG_APIKEY}"
