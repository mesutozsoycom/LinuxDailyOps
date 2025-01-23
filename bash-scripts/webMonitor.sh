#!/bin/bash
url="https://mesutozsoy.com.tr"
if curl -s --head $url | grep "200 OK" > /dev/null; then
echo "$url is up."
else
echo "$url is down."
fi