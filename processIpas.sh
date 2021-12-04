#!/bin/bash

trap "exit" SIGINT

echo "Make sure to kill itunesstored!"

mkdir -p ./ios_log/zhar/
mkdir -p ./ios_log/mitm/
mkdir -p ./ios_log/classes/

while read p <&3
do
    echo $p
    timeout 250 ./processIpa.sh "$p"
done 3<./data/ios_files.txt
