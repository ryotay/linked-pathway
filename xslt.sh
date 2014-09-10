#!/bin/sh

cat header.ttl
node xslt.js $1 $2 | /usr/bin/sed -e "s/\//-/g"
