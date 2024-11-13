# apk pkg install
# package_file apk file

function pkginstall
    argparse \
	h/help \
	clean \
	'tid=!_validate_int --min 1' \
	-- $argv
    or return

    set cmd_name (status current-function)

    if set -ql _flag_help
	set cmd_name (status current-command)
	echo "Usage: $cmd_name [--tid id] [--clean] apk_file"
	return 0
    end

    if set -ql _flag_tid
	set tid $_flag_tid
    else
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
    end

    set apk_file $argv[1]

    if set -ql _flag_clean
	echo "$cmd_name clean install $apk_file on transport_id: $tid ..."
	adb -t $tid install $apk_file
    else
	echo "$cmd_name overwrite install $apk_file on transport_id: $tid ..."
	adb -t $tid install -r $apk_file
    end

end
