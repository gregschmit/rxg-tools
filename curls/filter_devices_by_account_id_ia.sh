#!/bin/sh

. ./_init.sh

printf 'Enter the account ID to filter by: '
read account_id

./filter_devices_by_accound_id.sh ${account_id}
