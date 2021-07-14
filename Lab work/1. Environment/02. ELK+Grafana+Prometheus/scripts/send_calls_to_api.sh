#!/bin/bash
possible_uris=("get" "uuid" "headers" "anything")
range=30
number=$((RANDOM % range))
number=$number+3
echo "----------------------------------"
echo "Running a total of: $number calls!"
echo "----------------------------------"

for ((run=1; run <= number; run++)); do
rand=$[$RANDOM % ${#possible_uris[@]}]
uri_to_call=${possible_uris[$rand]}
echo "$(date '+%Y-%m-%d %H:%M:%S') - Calling Request #$run"
sleep 2
/usr/local/bin/http GET :8000/httpbin/$uri_to_call
done
exit 0
