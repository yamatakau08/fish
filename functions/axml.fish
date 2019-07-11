function axml
  switch (uname -s)
    case 'MINGW64_NT-*'
      set xmlf //sdcard/xml
    case '*'
      set xmlf /sdcard/xml
  end

  # list android devices to use
  adb devices -l

  read -P "select transport_id: " tid

  adb -t $tid shell uiautomator dump $xmlf
  adb -t $tid pull  $xmlf $argv[1] # if $argv[1] is not specified, xml file name is pulled is xml
  adb -t $tid shell rm $xmlf

end
