function mylogcat
    set ruby_script ~/bin/ptools/mylogcat/mylogcat.rb
    switch (uname)
	case Darwin
	    ruby $ruby_script $argv
	case *
	    winpty ruby $ruby_script $argv
    end
end
