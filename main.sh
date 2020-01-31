#!/bin/sh

cd /work/resources/origin
files=$(ls)

mkdir -p /work/output/shop_list
yq -s -c '.' $files > /work/output/shop_list/origin.json
