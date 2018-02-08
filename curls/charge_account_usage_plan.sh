#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 2 ]; then
        printf "Usage: ./charge_account_usage_plan.sh account_id usage_plan_id\n"
        exit 1
fi
account_id="$1"
usage_plan_id="$2"

# build header and payload
header="Content-Type: application/xml"
payload="<?xml version=1.0?>
<record>
  <usage-plan>
    <id>${usage_plan_id}</id>
  </usage-plan>
  <do-bill-and-apply-usage-plan>1</do-bill-and-apply-usage-plan>
</record>"

curl ${RXG_CURLOPTS} -X POST -H "${header}" -d "${payload}" "https://${RXG_FQDN}/admin/scaffolds/accounts/update/${account_id}.xml?api_key=${RXG_APIKEY}"