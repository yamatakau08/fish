function mp4pull
  switch (uname -s)
    case 'MINGW*'
     set mp4f //storage/0123-4567/DCIM/100ANDRO/$argv[1]
    case '*'
     set mp4f /storage/0123-4567/DCIM/100ANDRO/$argv[1]
    end

  # list android devices to use
  adb devices -l

  read -P "select transport_id: " tid

  adb -t $tid pull $mp4f $argv[2]
end
