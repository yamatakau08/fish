# Open Windows System Property
function sysprop
  switch (uname)
    case 'CYGWIN*'
	sudo /cygdrive/c/Windows/System32/SystemPropertiesAdvanced.exe
    case '*'
	echo (uname) not supported!
  end
end

