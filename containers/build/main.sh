#!/bin/sh

SRC='/work/resources/origin'
DEST='/work/public/shop_list'

cd ${SRC}
files=$(ls)

mkdir -p ${DEST}
yq -s -c '. | del(.[].other) | sort_by(.id)' $files > "${DEST}/origin.json"
