#!/bin/sh

docker stop $(docker ps -a | awk '/nagios/ { print $1 }')
docker rm $(docker ps -a -q)
