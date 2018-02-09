#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 3 ]; then
        printf "Usage: ./get_object_id_by_param.sh scaffold param value\n" >&2
        exit 1
fi
scaffold="$1"
param=`printf "$2" | sed -nf ./_url_encode.sed`
value=`printf "$3" | sed -nf ./_url_encode.sed`

data=`curl ${RXG_CURLOPTS} --silent "https://${RXG_FQDN}/admin/scaffolds/${scaffold}/index.xml?api_key=${RXG_APIKEY}&${param}=${value}" | tr -d '\n\r' | sed -nf ./_xml_extract_id_int.sed`

printf "${data}"
