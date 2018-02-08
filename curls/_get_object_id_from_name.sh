#!/bin/sh

. ./_init.sh

# args (scaffold name)
if [ $# -ne 2 ]; then
        printf "Usage: ./_get_object_id_from_name.sh scaffold name\n" >&2
        exit 1
fi
scaffold="$1"
name=`printf "$2" | sed -nf ./_url_encode.sed`

data=`curl ${RXG_CURLOPTS} --silent "https://${RXG_FQDN}/admin/scaffolds/${scaffold}/index.xml?api_key=${RXG_APIKEY}&name=${name}" | tr -d '\n\r' | sed -nf ./_xml_extract_id_int.sed`

printf "${data}"
