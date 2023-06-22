function androidlog
    argparse s/serialno -- $argv

    set timestamp (date "+%Y%m%d_%H%M%S")

    if set -ql _flag_serialno
	set sno $argv[1]
	adb -s $sno shell logcat | tee "android_"$timestamp"_logcat.log"
    else
	adb devices -l

	read -P "select transport_id: " tid

	adb -t $tid shell logcat | tee "android_"$timestamp"_logcat.log"
    end
end
