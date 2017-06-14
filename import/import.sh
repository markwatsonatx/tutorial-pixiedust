#!/bin/bash
echo "$(date) - Trying to connect to Cloudant"
statusCode="$(curl -f -s -o /dev/null -w "%{http_code}" --head http://db/dsads)"
while [ $statusCode -ne "200" ]; do
    echo "$(date) - Status Code=$statusCode; retrying to connect to Cloudant"
    statusCode="$(curl -f -s -o /dev/null -w "%{http_code}" --head http://db/)"
    sleep 3
done
echo "$(date) - Trying to create database"
statusCode="$(curl -f -s -o /dev/null -w "%{http_code}" -X PUT http://admin:pass@db/sxswsessions)"
while [ $statusCode -ne "201" ] && [ $statusCode -ne "412" ]; do
    echo "$(date) - Status Code=$statusCode; retrying to create database"
    statusCode="$(curl -f -s -o /dev/null -w "%{http_code}" -X PUT http://admin:pass@db/sxswsessions)"
    sleep 3
done
echo "$(date) - Trying to import data"
statusCode="$(curl -f -s -o /dev/null -w "%{http_code}" -d @/usr/import/sxswsessions.json -H 'Content-Type: application/json' -X POST http://admin:pass@db/sxswsessions/_bulk_docs)"
while [ $statusCode -ne "201" ]; do
    echo "$(date) - Status Code=$statusCode; retrying to import data"
    statusCode="$(curl -f -s -o /dev/null -w "%{http_code}" -d @/usr/import/sxswsessions.json -H 'Content-Type: application/json' -X POST http://admin:pass@db/sxswsessions/_bulk_docs)"
    sleep 3
done
