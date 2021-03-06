#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 1 ]; then
        printf "Usage: ./filter_devices_by_account_id.sh account_id\n" >&2
        exit 1
fi
account_id="$1"

curl ${RXG_CURLOPTS} "https://${RXG_FQDN}/admin/scaffolds/devices/index.xml?api_key=${RXG_APIKEY}&account_id=${account_id}"
