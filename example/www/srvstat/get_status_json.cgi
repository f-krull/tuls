#!/usr/bin/env bash

printf "Content-Type: application/json\r\n\r\n"

printf "[\n"

declare BASEDIR; BASEDIR="$( cd "${DOCUMENT_ROOT}/../.." && pwd )"

stat="$( $BASEDIR/bin/status )"

c=0
while read name status status_code started finished _; do
  [ $c -eq 1 ] && printf ","
  printf "{ "
  printf '"name": "%s"' $name
  printf ', "status": "%s"' $status
  printf ', "status_code": "%s"' $status_code
  printf ', "started": "%s"' $started
  printf ', "finished": "%s"' $finished
  printf " }\n"
  c=1
done < <(echo "$stat" | tail -n +2)

printf "]\n"
