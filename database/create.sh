#!/bin/bash
source database/config.sh

if $(docker inspect -f '{{.State.Status}}' "$CONTAINER" | grep -q "running"); then
    echo ""$CONTAINER" is already running."
else
    echo "starting "$CONTAINER""
    docker start "$CONTAINER" &>/dev/null
fi

docker exec -i "$CONTAINER" psql -U postgres -c "CREATE DATABASE \"$DB_NAME\"" > /dev/null 2>&1
if [ $? -eq 1 ]; then
    echo "database "$DB_NAME" already exists"
else
    echo "database "$DB_NAME" created!"
fi
