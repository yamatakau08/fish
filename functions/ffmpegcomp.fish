# Since cygwin doesn't have ffmpeg package, use windows native ffmpeg.exe
function ffmpegcomp
  switch (uname -s)
    case 'MINGW*'
      set ffmpeg "//c/winbin/ffmpeg-master-latest-win64-gpl-shared/bin/ffmpeg.exe"
    case 'CYGWIN_NT*'
      set ffmpeg "/cygdrive/c/winbin/ffmpeg-master-latest-win64-gpl-shared/bin/ffmpeg.exe"
    case '*'
      echo "not supported!"
      exit
    end

    $ffmpeg -i $argv[1] -crf 30 (basename $argv[1] .mp4)_comp.mp4
end
