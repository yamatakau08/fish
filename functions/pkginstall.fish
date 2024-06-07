# apk pkg install
# package_name "com.sony.songpal"
# package_file apk file

function pkginstall

  set option       $argv[1] # com.hoge
  set package_name $argv[2] # com.hoge
  set package_file $argv[3] # apk file name to be installed

  echo $package_name
  echo $package_file

  # list android devices to use
  adb devices -l

  read -P "select transport_id: " tid

  if test $option = "clean"
      echo "uninstalling... $package_name"
      adb -t $tid uninstall $package_name 2> /dev/null
  end

  if test $option = "clean"
      echo "$option installing... $package_name"
      adb -t $tid install $package_file
  else if test $option = "overwrite"
      echo "$option installing... $package_name"
      adb -t $tid install -r $package_file
  else
      echo "$option is not appropriate!"
  end

end
