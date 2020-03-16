#!/bin/sh

SRC='/work/resources/origin'
DEST='/work/public/shop_list'

cd ${SRC}
files=$(ls)

mkdir -p ${DEST}
yq -s -c '.' $files > "${DEST}/origin.json"