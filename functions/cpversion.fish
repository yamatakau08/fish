# print version.txt of C platform
function cpversion
  set verf /system/etc/firmware/version.txt # verf: version file
  # set verf /contents/version.txt # this file WSPEAKER=0.00 on SB2
  switch (uname -s)
    case 'MINGW64_NT-*'
      # https://efcl.info/2013/0520/res3282/
      # fish shell でコマンドの実行結果を変数に代入する方法
      set verf (string join '' '/' $verf)
    case '*'
  end

  # list android devices to use
  adb devices -l

  read -P "select transport_id: " tid

  adb -t $tid shell getprop ro.product.model
  adb -t $tid shell getprop ro.sony.buildtype
  adb -t $tid shell cat $verf
end
