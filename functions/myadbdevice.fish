function myadbdevice
    set device_serials (adb devices -l | sed -n '2,$ s/^\([^ ]\+\) \+.*/\1/p')

    for serial in $device_serials
	echo "(adb) device serial no:" $serial

	set -l device_id (string sub --start -12 $serial)
	#set -l device_id (string sub --start -12 $serial | sed 's/../&:/g; s/:$//')
	echo "device id:" $device_id

	adb -s $serial root > /dev/null

	adb -s $serial shell getprop ro.build.fingerprint

	set -l cmdline_file /proc/cmdline
	set -l output (adb -s $serial shell ls $cmdline_file | sed 's/\r//')
	if string match $output $cmdline_file > /dev/null
	    adb -s $serial shell cat /proc/cmdline | sed -e 's/ /\n/g'
	end

	set -l header_json_file /mnt/vendor/persist/$company/product_config/Header.json
	set -l output (adb -s $serial shell ls $header_json_file | sed 's/\r//') # remove CRLF of adb output
	if string match $output $header_json_file > /dev/null
	    adb -s $serial shell cat $header_json_file
	end

	echo
    end
end
