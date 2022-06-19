#!/bin/sh -ex

url=$1
curl -X POST -H "Content-Type: text/csv" -d "@test.csv" $url
