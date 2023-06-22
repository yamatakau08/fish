function emacs
    set nw false
    ## check if "-nw" option is specified
    if test 0 -ne (count $argv)
	for i in (seq (count $argv))
	    #echo -n $argv[$i]
	    if test (string match -- "-nw" $argv[$i])
		set nw true
		break
	    end
	end
    end

    switch (uname -s)
	## Note on Windows Environment
	# https://ayatakesi.github.io/emacs/temp/html/Windows-Startup.html
	# After launch runemacs.exe on mintty, CAN     execute other commands on mintty
	# After launch emacs.exe    on mintty, CAN NOT execute other commands on mintty

	case 'CYGWIN*'
	    if $nw -eq true
		clear
		/cygdrive/c/winbin/emacs-30.0.50/bin/emacs.exe $argv
	    else
		/cygdrive/c/winbin/emacs-30.0.50/bin/runemacs.exe $argv &
	    end
	case Darwin
	    if $nw -eq true
		/Applications/Emacs.app/Contents/MacOS/Emacs $argv
	    else
		/Applications/Emacs.app/Contents/MacOS/Emacs $argv &
	    end
	case Linux
	    if $nw -eq true
		/usr/bin/emacs $argv
	    else
		/usr/bin/emacs $argv &
	    end
	case 'MINGW*' 'MSYS*'
	    #	/c/msys64/mingw64/bin/runemacs $argv # emacs self compiled somehow google-translate doesn't work
	    #	runemacs $argv                       # run each GUI emacs on mingw32/64, my a part of helm-anki-browse doesn't work on mingw32
	    if $nw -eq true
		/c/winbin/emacs-29.0.50-snapshot/bin/runemacs.exe $argv
	    else
		/c/winbin/emacs-29.0.50-snapshot/bin/runemacs.exe $argv &
	    end
	case '*'
	    echo "add 'uname' label in ~/.config/fish/functions/emacs.fish"
    end

end
