#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 0 ]; then
        printf "Usage: ./list_login_sessions.sh\n"
        exit 1
fi

curl ${RXG_CURLOPTS} "https://${RXG_FQDN}/admin/scaffolds/login_sessions/index.xml?api_key=${RXG_APIKEY}"
