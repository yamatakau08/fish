## scrcpy
## official site https://github.com/Genymobile/scrcpy

# LG-G82M   INFO: Texture: 888x1920
# Moto g53J INFO: Texture: 720x1600

function myscrcpy

    ## list android devices
    adb devices -l

    read -P "select transport_id: " tid

    ## get ro.serialno
    set serial_no (adb devices -l | grep -i "transport_id:$tid")
    set serial_no (string split ' ' $serial_no)
    set serial_no $serial_no[1]

    ## get ro.product.model
    set model (adb -t $tid shell "getprop ro.product.model")
    set model (string trim -c '' $model) # important to strip ^M

    ## check os type
    set xuname (uname)

    if string match --ignore-case --regex 'CYGWIN' $xuname
	set cmdscrcpy ~/OneDrive/archive/scrcpy-win64-v2.4/scrcpy-win64-v2.4/scrcpy.exe
	set screen_record_dir c:\\yama\\OneDrive\\tmp\\scrcpy_record
	set screen_record_file $screen_record_dir/$model-(date +'%Y%m%d-%H%M%S').mp4
    else if string match --ignore-case --regex 'Darwin' $xuname
	set cmdscrcpy /usr/local/bin/scrcpy
	set screen_record_dir ~/tmp/scrcpy_record
	set screen_record_file $screen_record_dir/$model-(date +'%Y%m%d-%H%M%S').mp4
    else
	echo $xuname is not supported > /dev/stderr
	return
    end

    # need to make directory to store the screen copy file
    if not test -d $screen_record_dir
	mkdir $screen_record_dir
    end

    ## scrcpy execute
    $cmdscrcpy --serial $serial_no --video-codec=h264 --max-size=1920 --max-fps=60 --keyboard=uhid --show-touches --record=$screen_record_file --verbosity=verbose
    # --no-audio
    # --window-width 1000 --window-height 2500

end
