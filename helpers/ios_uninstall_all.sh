#!/bin/bash

ideviceinstaller -l | cut -d, -f1 | tail -n +2 | while read -r line ; do    
    if [ "$line" == "science.xnu.undecimus" ]; then
       continue
    fi

    ideviceinstaller -U $line
done
