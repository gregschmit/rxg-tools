#!/bin/sh

# stuff used by all scripts in this directory
RXG_FQDN='rxg.domain.com'
RXG_APIKEY='w2O...NGg'
# add -k to RXG_CURLOPTS if the target has a self-signed certificate
RXG_CURLOPTS=''

# echo commands to the terminal as they are executed
set -x

# export environment
export RXG_FQDN
export RXG_APIKEY
export RXG_CURLOPTS
