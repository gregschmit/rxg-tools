#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 1 ]; then
        exit 1
fi
login="$1"

data=`curl ${RXG_CURLOPTS} --silent "https://${RXG_FQDN}/admin/scaffolds/accounts/index.xml?api_key=${RXG_APIKEY}&login=${login}" | tr -d '\n\r' | sed -nf ./_xml_extract_id_int.sed`

printf "${data}"