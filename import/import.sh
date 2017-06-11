#!/bin/bash
statusCode="$(curl -s -o /dev/null -w "%{http_code}" --head http://db/dsads)"
while [ $statusCode -ne "200" ]; do
    echo "$(date) - Trying to connect to Cloudant"
    statusCode="$(curl -s -o /dev/null -w "%{http_code}" --head http://db/)"
	sleep 1
done
curl -X PUT http://admin:pass@db/sxswsessions
curl -d @/usr/import/sxswsessions.json -H "Content-Type: application/json" -X POST http://admin:pass@db/sxswsessions/_bulk_docs
