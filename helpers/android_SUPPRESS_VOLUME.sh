# needs to be changed, depending on Android version
# more here: https://stackoverflow.com/questions/27391326/how-to-change-the-volume-using-adb-shell-service-call-audio
ANDROID_ID=0d3986620361b94c
watch -n1 adb -s $ANDROID_ID shell service call audio 3 i32 3 i32 0