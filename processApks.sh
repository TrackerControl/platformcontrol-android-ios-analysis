#!/bin/bash

trap "exit" SIGINT

mkdir -p ./android_log/zhar
mkdir -p ./android_log/mitm

while read p <&3
do
    echo $p
    timeout 80 ./processApk.sh "$p"
done 3<./data/android_files.txt
