# apk pkg install
# package_name "com.sony.songpal"
# package_file apk file

function pkginstall

  set package_name $argv[1] # com.hoge
  set package_file $argv[2] # apk file name to be installed

  echo $package_name
  echo $package_file

  # list android devices to use
  adb devices -l

  read -P "select transport_id: " tid

  echo "uninstalling... $package_name"
  adb -t $tid uninstall $package_name 2> /dev/null

  echo "installing... $package_name"
  adb -t $tid install $package_file
end
