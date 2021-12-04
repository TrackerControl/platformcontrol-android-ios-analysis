#!/bin/bash

trap "exit" SIGINT

mkdir -p ios_log_unique
base="./ios_log_unique"

for f in $base/*.txt; do
    awk '!seen[$0]++' $f > $f.txt.uniq
done

cat ios_log_unique/*.txt.uniq |sort |uniq -cd | sort -nr > mostCommonClasses.txt

