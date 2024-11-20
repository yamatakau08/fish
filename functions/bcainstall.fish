# BCA install
function bcainstall
    argparse \
	h/help \
	c/clean \
	# 'apk=!string match -r \'.+.apk\' "$_flag_value"' \
	# leave PACKAGE file check to adb install
	'apk=' \
	-- $argv
    or return

    set -l cmd_name (status current-function)

    if set -ql _flag_help
	echo "Usage: $cmd_name [-c|--clean] --apk PACKAGE"
	return 0
    end

    if not set -ql _flag_apk
	echo "Usage: $cmd_name [-c|--clean] --apk PACKAGE"
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

    if test -z $tid # when C-c, C-d is inputted
	return 1
    end

    if set -ql _flag_clean
	set package_name "jp.co.sony.hes.home"
	echo "uninstalling $package_name on transport_id: $tid ..."
	adb -t $tid uninstall $package_name 2> /dev/null
	echo "$cmd_name clean install $_flag_apk on transport_id: $tid ..."
	pkginstall --tid $tid --clean $_flag_apk
    else
	echo "$cmd_name overwrite install $_flag_apk on transport_id: $tid ..."
	#adb -t $tid install -r $_flag_apk
	pkginstall --tid $tid $_flag_apk
    end

end
