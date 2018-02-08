#!/bin/sh

. ./_init.sh

# get account properties
printf 'Enter the account ID: '
read account_id
printf 'Enter the first name: '
read first_name
printf 'Enter the last name: '
read last_name
printf 'Enter the address (line 1): '
read address1
printf 'Enter the city: '
read city
printf 'Enter the state: '
read state
printf 'Enter the ZIP code: '
read zip
printf 'Enter the phone: '
read phone
printf 'Enter the credit card number: '
read cc_number
printf 'Enter the 2 digit expiration month (e.g.: 03): '
read cc_expiration_month
printf 'Enter the 4 digit expiration year: '
read cc_expiration_year

./create_payment_method.sh "${account_id}" "${first_name}" "${last_name}" "${address1}" "${city}" "${state}" "${zip}" "${phone}" "${cc_number}" "${cc_expiration_month}" "${cc_expiration_year}"