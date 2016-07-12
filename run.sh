#!/bin/sh

set -e

RUN_DIR=$(cd $(dirname $0) && pwd)

docker run -d --name nagios-manager -p 0.0.0.0:8080:80 hirocaster/nagios-manager

RUN_OPTION="--link nagios-manager:manager"
docker run -d --name nagios-remote ${RUN_OPTION} -p 0.0.0.0:8081:80 hirocaster/nagios-remote

cat <<EOF
1. Show admin page.
  access to nagios (http://localhost:8080/nagios3/)
EOF
