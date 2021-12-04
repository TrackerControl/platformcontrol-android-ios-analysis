#!/bin/bash

mkdir -p ios_log/zhar_done/
mkdir -p ios_log/har/

for f in ios_log/zhar/*.zhar; do
    f="${f%.*}"
    mv $f.zhar $f.zz
    pigz -k -d -z $f.zz
    
    mv $f $f.json
    mv $f.json ios_log/har/

    mv $f.zz $f.zhar
    mv $f.zhar ios_log/zhar_done/
done

# repeat for hidden files
for f in ios_log/zhar/.*.zhar; do
    f="${f%.*}"
    mv $f.zhar $f.zz
    pigz -k -d -z $f.zz
    
    mv $f $f.json
    mv $f.json ios_log/har/

    mv $f.zz $f.zhar
    mv $f.zhar ios_log/zhar_done/
done
