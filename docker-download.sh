#!/bin/sh

[[ -z "$url" ]] && [[ -f "/app/url.txt" ]] && url=$(tail -n1 url.txt)
[[ -z "$url" ]] && [[ -f "./url.txt" ]] && url=$(tail -n1 url.txt)

echo $url
CONTAINER=$(awk -F ' ' '/container_name/ {print $NF}' docker-compose.yml)

if whoami | grep -q "docker"; then
    python /app/hlsproxy.py "$url" -o /app/docker-output
else
    docker exec --user "docker" -it $CONTAINER python /app/hlsproxy.py "$url" -o /app/docker-output
fi
