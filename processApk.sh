#!/bin/bash

trap "exit" INT

TEST_TIME=20
f=$1
echo $f

apk=$(basename -- "$f")
appId="${apk%.*}"

killwait ()
{
  (sleep 1; kill $1) &
  wait $1
}

if [ ! -f ./android_log/$appId.chls ]; then
    log=./android_log.txt

    mitmdump -p 8889 -w ./android_log/mitm/$appId.mitm -s ./helpers/har_dump.py --set hardump=./android_log/zhar/$appId.zhar &
    PID=$!
    sleep 2

    pkill adb

    adb shell input keyevent KEYCODE_HOME
    adb shell am start -a android.intent.action.MAIN -c android.intent.category.HOME
    echo "-----installing $appId / $bundleId "
    echo "-----installing $appId / $bundleId " >> $log
    adb install -g $f # grant all permissions

    if (( $? != 0 )); then
        echo "-----failure installing $appId" >> $log
    else
        sleep 2
        echo "-----starting $appId" >> $log
        adb shell monkey -p $appId 1
        sleep $TEST_TIME
        echo "-----uninstalling testing $appId" >> $log

        adb uninstall $appId
        sleep 10
    fi

    killwait $PID

    echo "-----end testing $appId" >> $log
else
    echo "skipping $appId"
fi

