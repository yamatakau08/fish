function androidlog
    argparse s/serialno -- $argv

    set timestamp (date "+%Y%m%d_%H%M%S")

    if set -ql _flag_serialno
	set sno $argv[1]
	adb -s $sno shell getprop ro.product.mode

	set tmodel (adb -s $sno shell "getprop ro.product.model" 2> /dev/null)
	set model  (string trim -c '' $tmodel) # important to strip ^M

	echo $model

	return

	adb -s $sno shell logcat | tee "android_"$timestamp"_logcat.log"
    else
	adb devices -l

	read -P "select transport_id: " tid

	set model (adb -t $tid shell "getprop ro.product.model" 2> /dev/null)

	string match -r "command not found" $model # for BISYAMON

	if test $status -eq 0 # match "command not found"
	    set model "BISYAMON"
	    adb -t $tid shell hagocat | tee $model"_android_"$timestamp"_logcat.log"
	else
	    set model (string trim -c '' $model) # important to strip ^M

	    set model (string replace -a ' ' _ $model)
	    set model (string replace -r -a '[()]' '' $model) # to remove the braces. e.g. mogo g(30)

	    adb -t $tid shell logcat | tee $model"_android_"$timestamp"_logcat.log"
	end
    end
end
