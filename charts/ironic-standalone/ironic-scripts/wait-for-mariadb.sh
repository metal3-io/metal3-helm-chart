#!/bin/bash

while ! mysql -u "${DB_USER}" --password="${DB_PASS}" -h "${DB_HOST}" -e 'select 1;' "${DB_NAME}"
do
	sleep 1
	echo -n "."
done
