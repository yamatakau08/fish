#! /bin/bash

## list android devices to use
adb devices -l

echo -n "select transport_id: "
read tid

mp4f="//sdcard/Download/screenrecord.mp4"

trap 'func_trap ; exit' INT

function func_trap
{
    sleep 1
    adb -t $tid pull $mp4f
}

##
echo "start screenrecord ..."
adb -t $tid shell screenrecord $mp4f
