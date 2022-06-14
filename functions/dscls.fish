# This script list files on dsc folder in Android device

function dscls
  # list android devices to get the dsc file
  adb devices -l

  read -P "select transport_id: " tid

  # get ro.product.model for specifying DSC path
  set model (adb -t $tid shell "getprop ro.product.model" 2> /dev/null)

  switch $model
    case 'SOV35*' # Xperia XZs
      set sddscf //storage/0123-4567/DCIM/100ANDRO
      set iddscf //sdcard/DCIM/100ANDRO
    case 'moto g(30)*'
      set sddscf //storage/0123-4567/DCIM/Camera
      set iddscf //sdcard/DCIM/100ANDRO
    case '*'
      echo "$model is not supported!"
      return
  end

  # check if the file is in external sdcard
  adb -t $tid shell ls $sddcsf 1> /dev/null

  if test $status -eq 0
    set dscf $sddscf
  else
    set dscf $iddscf
  end

  adb -t $tid shell "ls -l $dscf"

end
