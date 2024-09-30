function myteraterm
    argparse comport= speed= model= -- $argv
    or return

    if set -ql _flag_speed
	set speed $_flag_speed
    end

    if set -ql _flag_model
	set model $_flag_model
	set window_title $_flag_model
    end

    ## windows position x,y fixed
    set window_position_x 280
    set window_position_y 20

    ## script dir
    set script_dir (dirname (status filename))

    ## comport
    # > ruby ./comport.rb
    # Select * From Win32_PnPEntity
    # "USB Serial Port (COM55)"
    # "LGE Mobile USB Serial Port (COM53)"
    #
    # 'USB Serial Port' # benten, cg1eg1 ifcon, ws
    # 'Silicon Labs Quad CP2108 USB to UART Bridge: Interface 0' # ebisu
    #set comport (ruby $script_dir/comport.rb | grep 'USB Serial Port' | sed -E 's/.*\(COM(.*)\).*/\1/')
    #set comport (ruby $script_dir/comport.rb | sed -n -e '/^"USB Serial Port/{s/^.*COM//; s/).*$//p}')
    set comport (ruby $script_dir/comport.rb | sed -n '/^"USB Serial Port/{s/.*COM\(.*\)).*/\1/p}')

    ## setup file
    set setup_file_dir (cygpath --dos $script_dir)
    set setup_file "$setup_file_dir/TERATERM.INI"

    ## LOG FILE
    set log_dir (cygpath --dos --absolute .) # need --absolute t
    ##set log_file "$log_dir\\serial_console_$(date +"%Y%m%d_%H%M%S").log"
    set log_file (printf "%s\\\%s_serial_console_%s.log" $log_dir $model $(date +"%Y%m%d_%H%M%S"))

    ## TeraTerm program
    # both path styles are ok.
    set teraterm '/cygdrive/C/Program Files (x86)\teraterm\ttermpro.exe'
    set teraterm 'C:/Program Files (x86)\teraterm\ttermpro.exe'

    echo "teraterm: $teraterm"
    echo "setup_file: $setup_file"
    echo "window_title: $window_title"
    echo "window_position: x $window_position_x , y: $window_position_y"
    echo "comport $comport[1]"
    echo "comport $comport[2]"
    echo "baud/speed: $speed"
    echo "Log to $log_file"

    ## TeraTerm execution
    # refer https://teratermproject.github.io/manual/4/ja/commandline/teraterm.html
    # /W="hoge" shows "hoge VT"  in Windows Title Text, can't understand the reason why.
    $teraterm \
	/C="$comport" \
	/F="$setup_file" \
	/L="$log_file" \
	/SPEED="$speed" \
	/W="$window_title" \
	/X="$window_position_x" \
	/Y="$window_position_y" &

end
