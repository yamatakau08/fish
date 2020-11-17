function adb
  switch (uname -s)
    case 'MINGW*' 'MSYS*'
      if contains "shell" $argv
        winpty adb $argv
      else
        command adb $argv
      end
    case '*'
      command adb $argv
  end
end