function emacs
switch (uname -s)
    case 'CYGWIN_NT-*' # 6.1,6.3
	command /cygdrive/c/winbin/emacs-26.1-x86_64/bin/emacs.exe $argv & # deps version
    case Darwin
	/Applications/Emacs.app/Contents/MacOS/Emacs $argv &
    case Linux
#       /usr/local/bin/emacs $argv & # if '&' exists, "emacs -nw" launch as backgroud, it's not good
	/usr/local/bin/emacs $argv
    case 'MINGW*'
# https://ayatakesi.github.io/emacs/temp/html/Windows-Startup.html
# runemacs.exe CAN     execute other commands on mintty
# emacs.exe    CAN NOT execute other commands on mintty
#	/c/msys64/mingw64/bin/runemacs           $argv # emacs self compiled somehow google-translate doesn't work
#	/c/winbin/emacs-26.2-x86_64/bin/runemacs $argv # use gnu ftp binary
#	/c/winbin/emacs-26.3-x86_64/bin/runemacs $argv # use gnu ftp binary
	/mingw64/bin/runemacs $argv # use gnu ftp binary
    case '*'
	echo "add 'uname' label in ~/.config/fish/functions/emacs.fish"
    end
end
