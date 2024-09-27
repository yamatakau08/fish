function myteraterm
    argparse window_title= speed= model= window_positon_x= window_position_y= comport= -- $argv
    or return

    if set -ql _flag_window_title
	set window_title $_flag_window_title
    end

    if set -ql _flag_speed
	set speed $_flag_speed
    end

    if set -ql _flag_model
	set model $_flag_model
    end

    if set -ql _flag_window_position_x
	set window_position_x $_flag_window_position_x
    else
	set window_position_x 280
    end

    if set -ql _flag_window_position_y
	set window_position_y $_flag_window_position_y
    else
	set window_position_y 20
    end

    ## script dir
    set script_dir (dirname (status filename))

    ## comport
    # > ruby ./comport.rb
    # Select * From Win32_PnPEntity
    # "USB Serial Port (COM55)"
    # "LGE Mobile USB Serial Port (COM53)"
    #set comport (ruby $script_dir/comport.rb | grep 'USB Serial Port' | sed -E 's/.*\(COM(.*)\).*/\1/')
    #set comport (ruby $script_dir/comport.rb | sed -n -e '/^"USB Serial Port/{s/^.*COM//; s/).*$//p}')
    set comport (ruby $script_dir/comport.rb | sed -n '/^"USB Serial Port/{s/.*COM\(.*\)).*/\1/p}')

    ## setup file
    set setup_file_dir (cygpath --dos $script_dir)
    set setup_file "$setup_file_dir/TERATERM.INI"

    ## LOG FILE
    set log_dir (cygpath --dos --absolute .) # need --absolute t
    set log_file "$log_dir\\serial_console_$(date +"%Y%m%d_%H%M%S").log"

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
    echo "model: $model"
    echo "Log to $log_file"

    ## TeraTerm execution
    $teraterm \
	/F="$setup_file" \
	/X="$window_position_x" \
	/Y="$window_position_y" \
	/C="$comport" \
	/BAUD="$speed" \
	/W="$window_title" \
	/L="$log_file" &

end
