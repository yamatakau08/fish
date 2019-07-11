function excel
    switch (uname)
    case 'MINGW64_NT-*'
         /c/Program\ Files\ \(x86\)/Microsoft\ Office/Office14/EXCEL.EXE &
    case 'CYGWIN_NT-*' # 6.1,6.3
    	 set file (cygpath -w $argv)
	 command /cygdrive/c/Program\ Files\ \(x86\)/Microsoft\ Office/Office14/EXCEL.EXE $file &
    case Darwin
    	 /Applications/Numbers.app/Contents/MacOS/Numbers $argv &
    end
end