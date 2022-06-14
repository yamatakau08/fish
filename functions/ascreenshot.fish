# https://qiita.com/TNaruto/items/b2407f5668e15e42bedd
# pngf  : pngfile
# dpngf : android device side png file

function ascreenshot
    # list android devices
    adb devices -l

    read -P "select transport_id: " tid

    # get ro.product.model for specifying DSC path
    set tmodel (adb -t $tid shell "getprop ro.product.model" 2> /dev/null)
    set model  (string trim -c '' $tmodel) # important to strip ^M

    # check if model is supported
    set pngf screenshot.png

    switch $model
	case 'SOV35' 'moto g(30)'
	    set dpngf //sdcard/Download/$pngf # // on MSYS2 environment, but available on Darwin...
	case '*'
	    echo $model is not supported
	    return
    end

    if test -z $argv[-1]
	set lpngf (basename $pngf .png)_(date +%y%m%d_%H%M%S).png
    else
	set lpngf $argv[-1]
    end

    echo "screenshot to $lpngf ..."
    adb -t $tid shell screencap -p $dpngf
    adb -t $tid pull  $dpngf $lpngf
    adb -t $tid shell rm $dpngf # remove screenshot file in device

    # open the file
    switch (uname)
	case 'Darwin' 'CYGWIN*'
	    open  $lpngf
	case '*'
	    start $lpngf
    end
end
