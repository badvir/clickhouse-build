#!/bin/bash


cd artifacts

echo "--------------------------------------------------------"
if [ "$(ls | grep .secui.)" ]; then
	echo "rpm name is valid"
else
	echo "rpm name is invalid !!!!!"
	exit 1
fi


CLICKHOUSE_CLIENT_FILE=$(ls | grep clickhouse-client)
CLICKHOUSE_SERVER_FILE=$(ls | grep clickhouse-server | grep -v common)

echo "--------------------------------------------------------"
echo "check gid(600)"

if [ "$(rpm -q --scripts $CLICKHOUSE_CLIENT_FILE | grep "groupadd -g 600")" ]; then
	echo "$CLICKHOUSE_CLIENT_FILE is valid"
else
	echo "$CLICKHOUSE_CLIENT_FILE is invalid !!!!!"
	exit 1 
fi

if [ "$(rpm -q --scripts $CLICKHOUSE_SERVER_FILE | grep "groupadd -g 600")" ]; then
        echo "$CLICKHOUSE_SERVER_FILE is valid"
else
        echo "$CLICKHOUSE_SERVER_FILE is invalid !!!!!"
        exit 1
fi

echo "--------------------------------------------------------"
echo ""


echo "--------------------------------------------------------"
echo "check rpm dependency - shadow-utils"

if [ "$(rpm -qR $CLICKHOUSE_CLIENT_FILE | grep "shadow-utils")" ]; then
        echo "$CLICKHOUSE_CLIENT_FILE is valid"
else
        echo "$CLICKHOUSE_CLIENT_FILE is invalid !!!!!"
        exit 1
fi

if [ "$(rpm -qR $CLICKHOUSE_SERVER_FILE | grep "shadow-utils")" ]; then
        echo "$CLICKHOUSE_SERVER_FILE is valid"
else
        echo "$CLICKHOUSE_SERVER_FILE is invalid !!!!!"
        exit 1
fi

echo "--------------------------------------------------------"
echo ""
