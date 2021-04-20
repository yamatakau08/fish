# https://qiita.com/TNaruto/items/b2407f5668e15e42bedd
function ascreenshot
  switch (uname -s)
    case 'MINGW*' 'MSYS*'
      set pngf //sdcard/Download/screenshot.png
    case '*'
      set pngf /sdcard/Download/screenshot.png
    end

  # list android devices to use
  adb devices -l

  read -P "select transport_id: " tid

  echo $pngf
  adb -t $tid shell screencap -p $pngf
  adb -t $tid pull  $pngf $argv[1] # if $argv[1] is not specified, png file name is pulled is xml
  adb -t $tid shell rm $pngf # remove screen shot file in device
end
