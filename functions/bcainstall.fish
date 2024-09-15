# BCA install
function bcainstall
  set package_name "jp.co.sony.hes.home"

  set option $argv[1]
  set package_file $argv[2]

  if [ $option = "clean" ] || [ $option = "overwrite" ]
      pkginstall $option $package_name $package_file
  else
      echo "Usage: bcainstall clean|overwrite file.apk"
  end

end
