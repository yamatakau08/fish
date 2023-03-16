#! /bin/bash

## list android devices to use
adb devices -l

echo -n "select transport_id: "
read tid

case $(uname) in
    "MSYS*" | "MINGW*" )
	dmp4f="//sdcard/Download/screenrecord.mp4"
	;;
    *)
	dmp4f="/sdcard/Download/screenrecord.mp4"
	;;
esac

## ${mp4f##*.}
## https://stackoverflow.com/a/3298229
lmpf4="$(basename $dmp4f .mp4)_$(date +%y%m%d_%H%M%S).${dmp4f##*.}"

trap 'func_trap ; exit' INT

function func_trap
{
    sleep 1
    adb -t $tid pull $dmp4f $lmpf4
}

## once delete dmp4, because if dmp4 exists, screenrecord fails
adb -t $tid shell rm -f $dmp4f # -f suppress error message if $dmp4f doesn't exist

##
echo "start screenrecord to $lmpf4"
adb -t $tid shell screenrecord $dmp4f # --time-limit TIME exists, maximum is 180
echo "pulling $lmpf4"
adb -t $tid pull $dmp4f $lmpf4
