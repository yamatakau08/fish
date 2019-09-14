# Music Center install
function mcinstall
  # list android devices to use
  adb devices -l

  read -P "select transport_id: " tid

  adb -t $tid uninstall com.sony.songpal
  adb -t $tid install $argv[1]
end
