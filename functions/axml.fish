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
  # if above passed,
  # "UI hierchary dumped to: /sdcard/xml" is displayed

  adb -t $tid pull  $xmlf $argv[1] # if $argv[1] is not specified, xml file name is pulled is xml

  # if the above passed,
  # "//sdcard/xml: 1 file pulled. 0.X MB/s (XXXX bytes in 0.00Xs)" is displayed

  adb -t $tid shell rm $xmlf
end
