# BCA install
function bcainstall
    argparse h/help clean apk= -- $argv
    or return

    set cmd_name (status current-command)

    if set -ql _flag_help
	echo "Usage: $cmd_name [-c|--clean] apk"
	return 0
    end

    if set -ql _flag_apk
	set apk $_flag_apk
    else
	echo "Usage: $name [-c|--clean] apk"
	return 0
    end

    set output (adb devices -l | tee /dev/tty | sed 's/\r//')

    # check the number of the adb devices found
    # if device is not found, need to return
    if ! string match --regex 'transport' $output > /dev/null
	echo "adb devices not found"
	return 0
    end

    while read -l tid --prompt-str="select transport_id: " \
	or return 1

	if string match --regex '^[1-9]\d*' $tid > /dev/null # tid is digit
	    break
	else
	    continue
	end
    end

    set id $tid

    if set -ql _flag_clean
	set package_name "jp.co.sony.hes.home"
	echo "uninstalling... $package_name"
	adb -t $tid uninstall $package_name 2> /dev/null
	echo "clean install"
	adb -t $tid install $apk
    else
	echo "overwrite"
	adb -t $tid install -r $apk
    end

end
