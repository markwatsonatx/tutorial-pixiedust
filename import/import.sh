#!/bin/bash
statusCode="$(curl -s -o /dev/null -w "%{http_code}" --head http://db/dsads)"
while [ $statusCode -ne "200" ]; do
    echo "$(date) - Trying to connect to Cloudant"
    statusCode="$(curl -s -o /dev/null -w "%{http_code}" --head http://db/)"
	sleep 3
done
statusCode="$(curl -X PUT http://admin:pass@db/sxswsessions)"
while [ $statusCode -ne "200" ]; do
    echo "$(date) - Trying to create database"
    statusCode="$(curl -X PUT http://admin:pass@db/sxswsessions)"
        sleep 3
done
curl -d @/usr/import/sxswsessions.json -H "Content-Type: application/json" -X POST http://admin:pass@db/sxswsessions/_bulk_docs
