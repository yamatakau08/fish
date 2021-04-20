# https://qiita.com/TNaruto/items/b2407f5668e15e42bedd
function ascreenrecord
  switch (uname -s)
    case 'MINGW*' 'MSYS*'
      set mp4f //sdcard/Download/screenrecord.mp4
    case '*'
      set mp4f  /sdcard/Download/screenrecord.mp4
    end

  # list android devices to use
  adb devices -l

  read -P "select transport_id: " tid

  echo "start screenrecord ..."
  adb -t $tid shell screenrecord $mp4f
  adb -t $tid pull  $mp4f $argv[1] # if $argv[1] is not specified, file name is pulled as is
  adb -t $tid shell rm $mp4f

end
