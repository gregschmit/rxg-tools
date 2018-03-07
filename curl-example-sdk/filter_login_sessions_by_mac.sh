#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 1 ]; then
        printf "Usage: ./filter_login_sessions_by_mac.sh mac\n" >&2
        exit 1
fi
mac="$1"

curl ${RXG_CURLOPTS} "https://${RXG_FQDN}/admin/scaffolds/login_sessions/index.xml?api_key=${RXG_APIKEY}&mac=${mac}"
