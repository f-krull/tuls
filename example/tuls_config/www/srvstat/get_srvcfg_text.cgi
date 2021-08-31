#!/usr/bin/env bash

# decode percent encoding ("%3C" -> ",", ...)
decode_url() {
  echo "$1" | sed 's@+@ @g;s@%@\\x@g' | xargs -0 printf "%b"
}
# parse parameters
IFS='=&' PARAMS=($QUERY_STRING)
# each parameter gets stored in its own variable
for ((i=0; i<${#PARAMS[@]}; i+=2))
do
  declare -r PARAM_${PARAMS[i]}="$(decode_url "${PARAMS[i+1]}")"
done

printf "Content-Type: text/plain; charset=UTF-8\r\n\r\n"

if [[ ! "${PARAM_serviceid}" =~ ^[0-9A-Za-z_]*$ ]]; then
  echo "invalid service ID \"${PARAM_serviceid}\""
  exit 1
fi


cat ${TULS_BASEDIR}/services/${PARAM_serviceid}.service
