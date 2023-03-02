# This script gets the android device's logcat log
function androidlog
  # list android devices
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

  set timestamp (date "+%Y%m%d_%H%M%S")
  adb -t $tid shell logcat | tee "android_"$timestamp"_logcat.log"
end
