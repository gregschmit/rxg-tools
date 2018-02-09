#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 11 ]; then
        printf "Usage: ./create_payment_method.sh account first_name last_name address1 city state zip phone cc_number cc_expiration_month cc_expiration_year\n" >&2
        exit 1
fi
account="$1"
first_name="$2"
last_name="$3"
address1="$4"
city="$5"
state="$6"
zip="$7"
country="US"
phone="$8"
cc_number="$9"
cc_expiration_month="${10}"
cc_expiration_year="${11}"

# get ids
account_id=`./get_object_id_by_param.sh accounts login ${account}`
if [ -z "${account_id}" ]; then
        printf "Error: no account found with name ${account}\n" >&2
        exit 1
fi

# build header and payload
header="Content-Type: application/xml"
payload="<?xml version=1.0?>
<record>
  <active>true</active>
  <account>
    <id>${account_id}</id>
  </account>
  <first_name>${first_name}</first_name>
  <last_name>${last_name}</last_name>
  <address1>${address1}</address1>
  <city>${city}</city>
  <state>${state}</state>
  <zip>${zip}</zip>
  <country>${country}</country>
  <phone>${phone}</phone>
  <cc_number>${cc_number}</cc_number>
  <cc_expiration_month>${cc_expiration_month}</cc_expiration_month>
  <cc_expiration_year>${cc_expiration_year}</cc_expiration_year>
</record>"

curl ${RXG_CURLOPTS} -X POST -H "${header}" -d "${payload}" "https://${RXG_FQDN}/admin/scaffolds/payment_methods/create.xml?api_key=${RXG_APIKEY}"
