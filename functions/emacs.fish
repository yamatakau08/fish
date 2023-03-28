function emacs
    set nw false
    ## check if "-nw" option is specified
    for i in (seq (count $argv))
	#echo -n $argv[$i]
	if test (string match -- "-nw" $argv[$i])
	    set nw true
	    break
	end
    end

    switch (uname -s)
	## Note on Windows Environment
	# https://ayatakesi.github.io/emacs/temp/html/Windows-Startup.html
	# After launch runemacs.exe on mintty, CAN     execute other commands on mintty
	# After launch emacs.exe    on mintty, CAN NOT execute other commands on mintty

	case 'CYGWIN*'
	    if test $nw
		/cygdrive/c/winbin/emacs-29.0.60/bin/emacs.exe $argv
	    else
		/cygdrive/c/winbin/emacs-29.0.60/bin/runemacs.exe $argv &
	    end
	case Darwin
	    if test $nw
		/Applications/Emacs.app/Contents/MacOS/Emacs $argv
	    else
		/Applications/Emacs.app/Contents/MacOS/Emacs $argv &
	    end
	case Linux
	    if test $nw
		/usr/bin/emacs $argv
	    else
		/usr/bin/emacs $argv &
	    end
	case 'MINGW*' 'MSYS*'
	    #	/c/msys64/mingw64/bin/runemacs $argv # emacs self compiled somehow google-translate doesn't work
	    #	runemacs $argv                       # run each GUI emacs on mingw32/64, my a part of helm-anki-browse doesn't work on mingw32
	    if test $nw
		/c/winbin/emacs-29.0.50-snapshot/bin/runemacs.exe $argv
	    else
		/c/winbin/emacs-29.0.50-snapshot/bin/runemacs.exe $argv &
	    end
	case '*'
	    echo "add 'uname' label in ~/.config/fish/functions/emacs.fish"
    end

end
