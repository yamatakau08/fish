function mylogcat
    set ruby_script ~/bin/ptools/mylogcat/mylogcat.rb
    switch (uname)
	case 'Darwin' 'CYGWIN*'
	    ruby $ruby_script $argv
	case 'MSYS*'
	    winpty ruby $ruby_script $argv
    end
end
