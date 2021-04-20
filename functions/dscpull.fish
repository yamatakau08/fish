# https://qiita.com/TNaruto/items/b2407f5668e15e42bedd
# //sdcard/DCIM/100ANDRO/DSC_0005.JPG adb_connector_repair.jpg

function dscpull
  set num_devices (adb devices -l | wc -l)
  set num_devices (math $num_devices - 2)

  switch (uname -s)
    case 'MINGW*'
     # SDCARD
     set sddscf //storage/0123-4567/DCIM/100ANDRO/$argv[1] # Xperia XZs
     set sddscf //storage/0123-4567/DCIM/Camera/$argv[1]   # Moto g30
     # internal
     set iddscf //sdcard/DCIM/100ANDRO/$argv[1] # Xperia XZs

    case '*'
     # SDCARD
     set dscmovf /storage/0123-4567/DCIM/100ANDRO/$argv[1]
     # internal
     set iddscf  /sdcard/DCIM/100ANDRO/$argv[1]
    end

  # list android devices to use
  adb devices -l

  read -P "select transport_id: " tid

  # check if the file is in external sdcard
  adb -t $tid shell ls $sddcsf &> /dev/null

  if test $status -eq 0
    adb -t $tid pull $sddscf $argv[2]
  else
    adb -t $tid pull $iddscf $argv[2]
  end
end
