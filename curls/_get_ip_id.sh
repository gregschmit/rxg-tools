#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 1 ]; then
        printf "Usage: ./_get_ip_id.sh ip\n" >&2
        exit 1
fi
ip="$1"

data=`curl ${RXG_CURLOPTS} --silent "https://${RXG_FQDN}/admin/scaffolds/ips/index.xml?api_key=${RXG_APIKEY}&ip=${ip}" | tr -d '\n\r' | sed -nf ./_xml_extract_id_int.sed`

printf "${data}"
