function apullfile
  switch (uname -s)
    case 'MINGW*'
     set pullfile /$argv[1]
    case '*'
     set pullfile $argv[1]
  end

  echo $pullfile

  # list android devices to use
  adb devices -l

  read -P "select transport_id: " tid

  adb -t $tid pull $pullfile
end
