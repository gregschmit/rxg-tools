#!/bin/sh

. ./_init.sh

# args
if [ $# -ne 5 ]; then
        printf "Usage: ./create_account.sh username first_name last_name email password\n" >&2
        exit 1
fi
login="$1"
first_name="$2"
last_name="$3"
email="$4"
password="$5"

# build header and payload
header="Content-Type: application/xml"
payload="<?xml version=1.0?>
<record>
  <login>${login}</login>
  <first_name>${first_name}</first_name>
  <last_name>${last_name}</last_name>
  <email>${email}</email>
  <password>${password}</password>
  <password_confirmation>${password}</password_confirmation>
</record>"

curl ${RXG_CURLOPTS} -X POST -H "${header}" -d "${payload}" "https://${RXG_FQDN}/admin/scaffolds/accounts/create.xml?api_key=${RXG_APIKEY}"
