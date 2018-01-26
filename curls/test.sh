#!/bin/sh

. ./_init.sh
. ./_devinit.sh

opts='-k'
account_id='428'

curl ${opts} "https://${RXG_FQDN}/admin/scaffolds/devices/index.xml?api_key=${RXG_APIKEY}&account_id=${account_id}"
