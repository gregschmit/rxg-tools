#!/bin/sh

. ./_init.sh

# get account properties
printf 'Enter the login username: '
read login
printf 'Enter the first name: '
read first_name
printf 'Enter the last name: '
read last_name
printf 'Enter the email address: '
read email
printf 'Enter the password: '
read password

./create_account.sh "${login}" "${first_name}" "${last_name}" "${email}" "${password}"