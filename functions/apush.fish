function apush
  switch (uname -s)
    case 'MINGW64_NT-*' 'MINGW32_NT-*'
      set download //sdcard/Download/
    case '*'
      set download /sdcard/Download/
    end

  # list android devices to use
  adb devices -l

  read -P "select transport_id: " tid

  adb -t $tid push $argv[1] $download
  adb -t $tid shell ls -l $download
end
