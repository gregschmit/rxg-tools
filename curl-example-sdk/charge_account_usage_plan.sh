#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 2 ]; then
        printf "Usage: ./charge_account_usage_plan.sh account usage_plan\n" >&2
        exit 1
fi
account="$1"
usage_plan="$2"

# get ids
account_id=`./get_object_id_by_param.sh accounts login ${account}`
if [ -z "${account_id}" ]; then
        printf "Error: no account found with name ${account}\n" >&2
        exit 1
fi
usage_plan_id=`./get_object_id_by_param.sh usage_plans name ${usage_plan}`
if [ -z "${usage_plan_id}" ]; then
        printf "Error: no usage plan found with name ${usage_plan}\n" >&2
        exit 1
fi

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
