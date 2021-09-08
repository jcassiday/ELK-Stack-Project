#!/bin/bash

# You could replace $1 for name of group ex sales and make sh script cron job

group=$(awk -F':' '/'$1'/{print $4}' /etc/group | tr ',' '\n')
  for names in ${group[@]}
  do
  echo $names
done
