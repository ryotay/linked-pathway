#!/bin/sh

cat header.ttl
sed -e "s/celldesigner/cd/g" $2 > temp.xml
node xslt.js $1 temp.xml | sed -e "s/\//-/g"
rm temp.xml
