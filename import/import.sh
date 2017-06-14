#!/bin/bash
echo "$(date) - Trying to connect to Cloudant"
statusCode="$(curl -f -s -o /dev/null -w "%{http_code}" --head http://db/dsads)"
while [ $statusCode -ne "200" ]; do
    echo "$(date) - Retrying to connect to Cloudant"
    statusCode="$(curl -f -s -o /dev/null -w "%{http_code}" --head http://db/)"
    sleep 3
done
echo "$(date) - Trying to create database""
statusCode="$(curl -f -X PUT http://admin:pass@db/sxswsessions)"
while [ $statusCode -ne "200" ]; do
    echo "$(date) - Retrying to create database"
    statusCode="$(curl -f -X PUT http://admin:pass@db/sxswsessions)"
    sleep 3
done
echo "$(date) - Trying to import data"
statusCode="$(curl -f -d @/usr/import/sxswsessions.json -H "Content-Type: application/json" -X POST http://admin:pass@db/sxswsessions/_bulk_docs)"
while [ $statusCode -ne "200" ]; do
    echo "$(date) - Retrying to import data"
    statusCode="$(curl -f -d @/usr/import/sxswsessions.json -H "Content-Type: application/json" -X POST http://admin:pass@db/sxswsessions/_bulk_docs)"
    sleep 3
done
