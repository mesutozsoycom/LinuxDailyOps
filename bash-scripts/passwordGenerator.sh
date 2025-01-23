#!/bin/bash
length=${1:-12}
password=$(tr -dc 'A-Za-z0-9!@#$%^&*()_+=' < /dev/urandom | head -c $length)
echo "Generated Password: $password"