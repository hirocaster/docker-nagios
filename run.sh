#!/bin/sh

set -e

RUN_DIR=$(cd $(dirname $0) && pwd)

docker run -d --name nagios-base -p 0.0.0.0:8080:80 nagios

cat <<EOF
1. Show admin page.
  access to nagios (http://localhost:8080/nagios3/)
EOF
