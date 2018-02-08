#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 1 ]; then
        printf "Usage: ./_get_account_id_from_login.sh login\n" >&2
        exit 1
fi
login="$1"

data=`curl ${RXG_CURLOPTS} --silent "https://${RXG_FQDN}/admin/scaffolds/accounts/index.xml?api_key=${RXG_APIKEY}&login=${login}" | tr -d '\n\r' | sed -nf ./_xml_extract_id_int.sed`

printf "${data}"
