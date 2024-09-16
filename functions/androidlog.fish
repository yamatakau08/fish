function androidlog
    argparse s/serial h/help -- $argv
    or return

    if set -ql _flag_help
	echo 'usage [-s|--serial] SERIAL'
	return 0
    end

    if set -ql _flag_serial
	set mode serial
	set serial $argv[1]

	set id $serial
	set option '-s'
    else
	adb devices -l

	read -P "select transport_id: " tid

	set id $tid
	set option '-t'
    end

    # check if target device has getprop
    if set output (adb $option $id shell "which getprop" 2>&1)
	if string match -r 'getprop' $output > /dev/null
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
