#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 1 ]; then
        exit 1
fi
name="$1"

name_safe=`echo "${name}" | sed -nf ./_url_encode.sed`
data=`curl ${RXG_CURLOPTS} --silent "https://${RXG_FQDN}/admin/scaffolds/interfaces/index.xml?api_key=${RXG_APIKEY}&name=${name_safe}" | tr -d '\n\r' | sed -nf ./_xml_extract_id_int.sed`

printf "${data}"