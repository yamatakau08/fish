# print version.txt of C platform
function dpversion
  set verf /system/etc/firmware/version.txt # verf: version file
  # set verf /contents/version.txt # this file WSPEAKER=0.00 on SB2
  switch (uname -s)
    case 'MINGW*'
      # https://efcl.info/2013/0520/res3282/
      # fish shell でコマンドの実行結果を変数に代入する方法
      set verf (string join '' '/' $verf)
    case '*'
  end

  # list android devices to use
  adb devices -l

  read -P "select transport_id: " tid

  # adb shell getprop 複数指定はできないので、個別で
  adb -t $tid shell echoprop
  echo $verf
  adb -t $tid shell cat $verf
end
