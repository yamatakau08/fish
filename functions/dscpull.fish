# This script pulls dsc or mp4 file which are taken by device

function dscpull
  # list android devices to get the dsc file
  adb devices -l

  read -P "select transport_id: " tid

  # get ro.product.model for specifying DSC path
  set model (adb -t $tid shell "getprop ro.product.model" 2> /dev/null)

  switch $model
    case 'SOV35*' # Xperia XZs
      set sddscf //storage/0123-4567/DCIM/100ANDRO/$argv[1]
      set iddscf //sdcard/DCIM/100ANDRO/$argv[1]
    case 'moto g(30)*'
      set sddscf //storage/0123-4567/DCIM/Camera/$argv[1]
      set iddscf //sdcard/DCIM/100ANDRO/$argv[1] # since I use only external sd card,not yet checked
    case '*'
      echo "$model is not supported!"
      return
  end

  # check if the file is in external sdcard
  adb -t $tid shell ls $sddcsf 2> /dev/null

  if test $status -eq 0
    set dscf $sddscf
  else
    set dscf $iddscf
  end

  adb -t $tid pull $dscf $argv[2]

end
