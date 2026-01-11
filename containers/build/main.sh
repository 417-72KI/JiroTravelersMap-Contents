#!/bin/sh

SRC='/work/resources/origin'
DEST='/work/public/shop_list'

cd ${SRC}

ERROR=0
for file in *.yml; do
    shop_id=$(yq -src '.[].id' "$file")
    shop_name=$(yq -src '.[].name' "$file")
    filename="$(printf "%02d" $shop_id)-$shop_name"
    if [ "$filename" != "$(basename $file .yml)" ]; then
        echo "\e[31m[ERROR] $file: filename is not match with id and name\e[m"
        echo "\e[31m        id: $shop_id\e[m"
        echo "\e[31m        name: $shop_name\e[m"
        ERROR=$((ERROR+1))
    fi
done

if [ $ERROR -gt 0 ]; then
    echo "\e[31m[ERROR] There are $ERROR error(s) in source.\e[m"
    exit $ERROR
fi

files=$(ls)

mkdir -p ${DEST}
yq -s -c '. | del(.[].other) | sort_by(.id)' $files > "${DEST}/origin.json"
echo "{\"last_update\": \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"}" | jq -rc . > "${DEST}/last_update.json"
