#!/bin/sh
echo hi
WEBDIR=/Users/scogland1/twistd

cd $WEBDIR
/usr/local/bin/twistd -n -d $WEBDIR web -p 8080 

