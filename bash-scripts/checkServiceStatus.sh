#!/bin/bash
service_name="httpd"
if systemctl is-active --quiet $service_name; then
echo "$service_name is running."
else
echo "$service_name is not running."
fi