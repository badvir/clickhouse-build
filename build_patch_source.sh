#!/bin/bash


for file in ../../../../clickhouse_src_patch/*.patch
do
	echo ""
	echo "patch file: $file"
	error=$(patch -p1 < "$file")
	if [ $? -ne 0 ]
	then
		echo "fail: $error"
		exit 1
	else
		echo "success"
	fi
done

exit 0
