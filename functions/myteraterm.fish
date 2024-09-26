##
# window_title option is not specified
# seed 921600

function myteraterm
    argparse window_title= speed= model= -- $argv
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

    set script_dir (dirname (status filename))

    ## comport
    #set $comport (ruby $script_dir/comport.rb | grep 'USB Serial Port' | sed -E 's/.*\(COM(.*)\).*/\1/')

    ## setup file
    set setup_file "$script_dir/TERATERM.INI"
    echo $setup_file

    ## LOG FILE
    #set log_dir (cygpath -d -a .)
    set log_dir '/tmp'
    set log_file "$log_dir\\$model_serial_console_$(date +"%Y%m%d_%H%M%S").log"
    echo $log_file

    return

end

function xteraterm
    argparse setup_file= win_pos_x= win_pos_y= comport= baud= window_title= log_file= -- $argv
    return 0

    set teraterm "hoge"
# "${TERATERM}" /F="${SETUP_FILE}" /X="${WINDOW_POSITION_X}" /Y="${WINDOW_POSITION_Y}" /C="${COMPORT}" /BAUD="${SPEED}" /W="${WINDOW_TITLE}" /L="${LOG_FILE}" &

end


# #! /bin/sh

# SCRIPT_DIR=`dirname $0`

# # This script launch Tera Term with the serial port which is bind actual com port.
# # But sometimes mapping may be wrong.
# # In that case, change the com port assigned with device manager.

# if [ -z "$1" ]; then
#     WINDOW_TITLE="Serial Console MTK"
# else
#     MODEL=$1
#     WINDOW_TITLE="Serial Console ${MODEL} MTK"
# fi

# ## SPEED
# SPEED="921600"

# ## COMPORT
# COMPORT=`ruby $SCRIPT_DIR/comport.rb | grep 'USB Serial Port' | sed -E 's/.*\(COM(.*)\).*/\1/'`

# ## TERATERM needs SETUP_FILE must be full path
# SETUP_FILE=`cygpath -d -a $SCRIPT_DIR/TERATERM.INI`

# ## LOG FILE
# echo "CG1EG1.SH $PWD"
# LOG_DIR=`cygpath -d -a .`
# LOG_FILE="$LOG_DIR\\${MODEL}_serial_console_$(date +"%Y%m%d_%H%M%S").log"

# ## WINDOW POSITION
# WINDOW_POSITION_X=280
# WINDOW_POSITION_Y=20

# # both are ok
# TERATERM='/cygdrive/C/Program Files (x86)\teraterm\ttermpro.exe'
# TERATERM='C:/Program Files (x86)\teraterm\ttermpro.exe'

# echo $TERATERM
# echo $SETUP_FILE
# echo $WINDOW_TITLE
# echo $WINDOW_POSITION_X $WINDOW_POSITION_Y
# echo $COMPORT
# echo $SPEED
# echo "Log to $LOG_FILE"

# "${TERATERM}" /F="${SETUP_FILE}" /X="${WINDOW_POSITION_X}" /Y="${WINDOW_POSITION_Y}" /C="${COMPORT}" /BAUD="${SPEED}" /W="${WINDOW_TITLE}" /L="${LOG_FILE}" &
