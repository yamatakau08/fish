function androidlog
    argparse -x 's,t' h/help s/serial= t/transport_id= -- $argv
    or return

    if set -ql _flag_help
	echo 'usage [-s|--serial] SERIAL'
	return 0
    end

    if set -ql _flag_serial
	set serial $argv[1]

	set id $serial
	set option '-s'
    else if set -ql _flag_transport_id # tentative
	set transport_id $argv[1]

	set id $transport_id
	set option '-t'
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

	set id $tid
	set option '-t'
    end

    # check if target device has getprop
    if set output (adb $option $id shell "which getprop" 2>&1)
	if string match --regex 'getprop' $output > /dev/null
	    set model (adb $option $id shell "getprop ro.product.model" | sed 's/\r//; s/  */-/g; s/[()]//g')
	    set logcmd logcat
	else
	    set model "BISYAMON"
	    set logcmd hagocat
	end

	set timestamp (date "+%Y%m%d_%H%M%S")
	echo $model $logcmd $timestamp

	adb $option $id shell $logcmd | tee $model"_"$timestamp"_"$logcmd".log"
    else
	echo $output >&2
    end

end
