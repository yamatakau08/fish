# show platform model firmware information echoprop,version.txt and ip address
function dpversion

  adb devices -l

  set deviceidprefix 0123456789 # AC/...: 0123456789, AE: 0123456789ABCDEF
  set numdevices (adb devices -l | string replace '' '\n' $devices | grep $deviceidprefix | wc -l)

  if test "$numdevices" -eq 1
      set deviceinfo (adb devices -l | string replace '' '\n' $devices | grep $deviceidprefix | string split ':')
      set tid (string trim -c '\n' $deviceinfo[-1])
  else if test "$numdevices" -ge 2
      read -P "select transport_id: " tid
  else
      echo "No avilable devices"
      return
  end

  # adb shell getprop 複数指定はできないので、個別で
  adb -t $tid shell echoprop

  # SeedsCloud prod/staging
  adb -t $tid shell "nvp zr 096 4"
  # zr:  read, zr: write
  # 096: zone(address)
  # 04: read counts
  # "00 00 00 00" prod
  # "00 00 00 01" qa

  echo "00: prod 01: qa"
  echo

  ## version.txt
  set verf /system/etc/firmware/version.txt # verf: version file
  # set verf /contents/version.txt # this file WSPEAKER=0.00 on SB2
  switch (uname -s)
      case 'MINGW*'
	  # https://efcl.info/2013/0520/res3282/
	  # fish shell でコマンドの実行結果を変数に代入する方法
	  set verf (string join '' '/' $verf)
      case '*'
  end
  echo $verf
  adb -t $tid shell cat $verf

  echo

  ## ip address
  adb -t $tid shell ip -f inet -oneline address show

end
