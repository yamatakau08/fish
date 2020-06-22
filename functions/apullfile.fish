# https://qiita.com/TNaruto/items/b2407f5668e15e42bedd
function apullfile
    switch (uname -s)
	case 'MINGW*'
	    set dscmovf //storage/0123-4567/DCIM/100ANDRO/$argv[1]
	case '*'
	    set dscmovf /storage/0123-4567/DCIM/100ANDRO/$argv[1]
    end

    # list android devices to use
    adb devices -l

    read -P "select transport_id: " tid

    adb -t $tid pull $dscmovf
end
