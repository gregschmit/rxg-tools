#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 1 ]; then
        printf "Usage: ./list_scaffold.sh scaffold\n" >&2
        exit 1
fi
scaffold="$1"

curl ${RXG_CURLOPTS} "https://${RXG_FQDN}/admin/scaffolds/${scaffold}/index.xml?api_key=${RXG_APIKEY}"
