function adb
  switch (uname -s)
    case 'MINGW*' 'MSYS*'
      if test $argv[1] = "shell"
        winpty adb $argv
      else
        command adb $argv
      end
    case '*'
      command adb $argv
  end
end