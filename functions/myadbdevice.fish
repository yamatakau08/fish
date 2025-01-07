function myadbdevice
    set device_serials (adb devices -l | sed -n '2,$ s/^\([^ ]\+\) \+.*/\1/p')

    for serial in $device_serials
	echo $serial
	adb -s $serial root
	adb -s $serial shell getprop ro.build.fingerprint
	adb -s $serial shell cat /mnt/vendor/persist/$company/product_config/Header.json
	echo
	#adb -s $serial shell cat /proc/cmdline | sed -e s's/\r//' -e 's/ /\n/g'
	adb -s $serial shell cat /proc/cmdline | sed -e 's/ /\n/g'
	echo
	echo
    end
end
