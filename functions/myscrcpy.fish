## scrcpy
## official site https://github.com/Genymobile/scrcpy

# LG-G82M   INFO: Texture: 888x1920
# Moto g53J INFO: Texture: 720x1600

function myscrcpy

    ## list android devices
    adb devices -l

    read -P "select transport_id: " tid

    ## get ro.serialno
    set serialno (adb -t $tid shell "getprop ro.serialno" 2> /dev/null)
    set serialno (string trim -c '' $serialno) # important to strip ^M

    ## get ro.product.model
    set model (adb -t $tid shell "getprop ro.product.model" 2> /dev/null)
    set model (string trim -c '' $model) # important to strip ^M

    # https://unix.stackexchange.com/questions/317330/check-a-range-with-switch-case-in-fish-shell
    if string match --ignore-case --regex 'command not found*' $serialno > /dev/null
	echo "scrcpy: tid $tid is not supported!"
	return
    end

    ## check os type
    set xuname (uname) > /dev/null

    if string match --ignore-case --regex 'CYGWIN' $xuname
	set cmdscrcpy ~/OneDrive/archive/scrcpy-win64-v2.4/scrcpy-win64-v2.4/scrcpy.exe
	set screen_record_dir c:\\yama\\OneDrive\\tmp\\scrcpy_record
	set screen_record_file $screen_record_dir/$model-(date +'%Y%m%d-%H%M%S').mp4
    else if string match --ignore-case --regex 'Darwin' $xuname
	set cmdscrcpy /usr/local/bin/scrcpy
	set screen_record_dir ~/tmp/scrcpy_record
	set screen_record_file $screen_record_dir/$model-(date +'%Y%m%d-%H%M%S').mp4
    else
	return
    end

    # need make directory to store
    if not test -d $screen_record_dir
	mkdir $screen_record_dir
    end

    $cmdscrcpy --serial $serialno --video-codec=h264 --max-size=1920 --max-fps=60 --keyboard=uhid --show-touches --record=$screen_record_file --verbosity=verbose
    # --no-audio
    # --window-width 1000 --window-height 2500

end
