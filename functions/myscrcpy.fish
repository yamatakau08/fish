## scrcpy
## official site https://github.com/Genymobile/scrcpy

# LG-G82M   INFO: Texture: 888x1920
# Moto g53J INFO: Texture: 720x1600

function myscrcpy
    argparse -x 's,t' h/help s/serial= t/transport_id= -- $argv
    or return

    if set -ql _flag_help
	set cmd_name (status current-command)
	echo "Usage: $cmd_name [-s|--serial SERIAL] [-t|--transport_id ID]"
	return 0
    end

    if set -ql _flag_serial
	set serial $_flag_serial
    else if set -ql _flag_transport_id
	set tid $_flag_transport_id
    else
	## list android devices
	adb devices -l

	# remolve read option '-l'
	while read tid --prompt-str="select transport_id: " \
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

    if not set -ql serial # not defined serial variable in the above
	## get ro.serialno
	# remove CR=\r=^M (*)
	# (*) dos adb command outputs appended CR=\r=^M
	set serial (adb -t $tid shell getprop ro.serialno | sed 's/\r//')
    end

    ## get ro.product.model
    # set model (adb -t $tid shell "getprop ro.product.model")
    # set model (string trim -c '' $model) # important to strip ^M

    # set model (string replace -a ' ' _ $model)
    # set model (string replace -r -a '[()]' '' $model) # to remove the braces. e.g. mogo g(30)
    # remove CR=\r=^M (*) , translate space to '-', remove '(' or ')'
    # (*) dos adb command outputs appended CR=\r=^M
    set model (adb -t $tid shell "getprop ro.product.model" | sed -e 's/\r//; s/  */-/g; s/[()]//g')

    ## check os type
    set xuname (uname)

    if string match --ignore-case --regex 'CYGWIN' $xuname
	set cmdscrcpy ~/OneDrive/archive/scrcpy-win64-v2.4/scrcpy-win64-v2.4/scrcpy.exe
	#set cmdscrcpy '/cygdrive/c/winbin/scrcpy-win64-v2.4/scrcpy.exe'
	set screen_record_dir 'c:\\yama\\OneDrive\\tmp\\scrcpy_record'
	set screen_record_dir '.'
	set screen_record_file $screen_record_dir/$model-(date +'%Y%m%d-%H%M%S').mp4
	echo $screen_record_file
    else if string match --ignore-case --regex 'Darwin' $xuname
	set cmdscrcpy /usr/local/bin/scrcpy
	set screen_record_dir ~/tmp/scrcpy_record
	set screen_record_dir '.'
	set screen_record_file $screen_record_dir/$model-(date +'%Y%m%d-%H%M%S').mp4
    else
	echo $xuname is not supported > /dev/stderr
	return 1
    end

    # need to make directory to store the screen copy file
    if not test -d $screen_record_dir
	mkdir $screen_record_dir
    end

    ## scrcpy execute
    $cmdscrcpy \
	--serial $serial \
	--video-codec=h264 \
	--max-size=1920 \
	--max-fps=60 \
	--keyboard=uhid \
	--show-touches \
	--record=$screen_record_file \
	--verbosity=verbose \
	--no-audio   # Disable audio forwarding.
    # --window-width 1000 --window-height 2500

end
