# This script list files on dsc folder in Android device

function dscls
  # list android devices to get the dsc file
  adb devices -l

  read -P "select transport_id: " tid

  # get ro.product.model for specifying DSC path
  set xmodel (adb -t $tid shell "getprop ro.product.model" 2> /dev/null)
  set model (string trim -c '' $xmodel)

  switch $model
    case 'SOV35' # Xperia XZs
      set sddscf //storage/0123-4567/DCIM/100ANDRO
      set iddscf //sdcard/DCIM/100ANDRO
    case 'moto g(30)' 'moto g53j 5G'
      set sddscf //storage/0123-4567/DCIM/Camera
      set iddscf //sdcard/DCIM/100ANDRO
    case '*'
      echo "$model is not supported!, add case condition!"
      return
  end

  # add screeshot directory
  set screenf //storage/emulated/0/Pictures/Screenshots

  # check if the file is in external sdcard
  adb -t $tid shell ls $sddcsf 1> /dev/null

  if test $status -eq 0
    set dscf $sddscf $screenf
  else
    set dscf $iddscf $screenf
  end

  adb -t $tid shell "ls -l $dscf"

end
