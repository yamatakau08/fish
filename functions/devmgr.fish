# open Windows device manager
function devmgr
  switch (uname)
      case 'CYGWIN*'
	  sudo /cygdrive/c/Windows/System32/mmc.exe devmgmt.msc
      case '*'
	  echo (uname) not supported!
  end
end
