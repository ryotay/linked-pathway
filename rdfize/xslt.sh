#!/bin/sh

cat header.ttl
node xslt.js $1 $2 | sed -e "s/\//-/g"
