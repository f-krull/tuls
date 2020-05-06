#!/usr/bin/env bash

set -Eeou pipefail

declare  BASEDIR; BASEDIR="$( cd "$( dirname $0 )" && pwd )"
readonly BASEDIR

# check arg
cmd=$1
[[ "${cmd}" =~ ^(daily|weekly|monthly)$ ]] || { printf "error: invalid argument (\"${cmd}\")" >&2; exit 1; }

# run backup
nice -n +5 ionice -c Idle ${BASEDIR}/rsnapshot/bin/rsnapshot -c <(cat ${BASEDIR}/base.conf ${BASEDIR}/user.conf) ${cmd} || true

# fix directory permissions
snapshot_root="$( awk '$1=="snapshot_root"{print $2}' ${BASEDIR}/user.conf )"
chmod -R u+w "${snapshot_root}"


echo "ok - ${cmd} backup complete"
