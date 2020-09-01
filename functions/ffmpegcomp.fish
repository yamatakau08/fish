function ffmpegcomp
  switch (uname -s)
    case 'MINGW*'
     set ffmpeg /c/winbin/ffmpeg-20200816-5df9724-win64-static/bin/ffmpeg.exe
     $ffmpeg -i $argv[1] -crf 30 (basename $argv[1] .mp4)_comp.mp4
    case *
     echo "not supported!"
    end
end
