# Music Center install
function tidalinstall
  # list android devices to use
  adb devices -l

  read -P "select transport_id: " tid

  echo "uninstalling com.aspiro.tidal"
  adb -t $tid uninstall com.aspiro.tidal
  adb -t $tid install $argv[1]
end
