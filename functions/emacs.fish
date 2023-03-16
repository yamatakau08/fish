function emacs
    switch (uname -s)
	case 'CYGWIN*'
	    #/cygdrive/c/winbin/emacs-29.0.50-snapshot/bin/runemacs.exe $argv &
	    #/cygdrive/c/winbin/emacs-28.0.91/bin/runemacs.exe $argv &
	    #/cygdrive/c/winbin/emacs-28.1.90/bin/runemacs.exe $argv &
	    /cygdrive/c/winbin/emacs-29.0.60/bin/runemacs.exe $argv &
	case Darwin
	    /Applications/Emacs.app/Contents/MacOS/Emacs $argv &
	case Linux
	    #       /usr/local/bin/emacs $argv & # if '&' exists, "emacs -nw" launch as backgroud, it's not good
	    /usr/bin/emacs $argv &
	case 'MINGW*' 'MSYS*'
	    # https://ayatakesi.github.io/emacs/temp/html/Windows-Startup.html
	    # After launch runemacs.exe on mintty, CAN     execute other commands on mintty
	    # After launch emacs.exe    on mintty, CAN NOT execute other commands on mintty
	    #	/c/msys64/mingw64/bin/runemacs           $argv # emacs self compiled somehow google-translate doesn't work
	    #	/c/winbin/emacs-26.2-x86_64/bin/runemacs $argv # use gnu ftp binary
	    #	/c/winbin/emacs-26.3-x86_64/bin/runemacs $argv # use gnu ftp binary
	    #	runemacs $argv # run each GUI emacs on mingw32/64, my a part of helm-anki-browse doesn't work on mingw32
	    #	/c/winbin/emacs-28.0.50-snapshot-2020-07-05-x86_64/bin/runemacs.exe $argv
	    #   /c/winbin/emacs-28.0.50/x86_64/bin/runemacs.exe $argv
	    /c/winbin/emacs-29.0.50-snapshot/bin/runemacs.exe $argv
	case '*'
	    echo "add 'uname' label in ~/.config/fish/functions/emacs.fish"
    end
end
