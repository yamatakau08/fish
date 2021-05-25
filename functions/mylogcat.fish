function mylogcat
  set ruby_script ~/bin/platform/mylogcat.rb
  winpty ruby $ruby_script $argv
end
