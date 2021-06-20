# https://qiita.com/TNaruto/items/b2407f5668e15e42bedd
# pngf  : pngfile
# dpngf : android device side png file

function ascreenshot
  # list android devices
  adb devices -l

  read -P "select transport_id: " tid

  # get ro.product.model for specifying DSC path
  set tmodel (adb -t $tid shell "getprop ro.product.model" 2> /dev/null)
  set model (string trim -c '' $tmodel) # important to strip ^M

  # check if model is supported
  set pngf screenshot.png

  switch $model
    case 'SOV35' 'moto g(30)'
      set dpngf //sdcard/Download/$pngf
    case '*'
      echo $model is not supported
      return
  end

  echo "screenshot $pngf ..."
  adb -t $tid shell screencap -p $dpngf
  adb -t $tid pull  $dpngf $argv[-1] # if the local file name is not specified, local file name is $pngf
  adb -t $tid shell rm $dpngf # remove screenshot file in device

  # view the file pulled
  if test -z $argv[-1]
    start $pngf
  else
    start $argv[-1]
  end
end
