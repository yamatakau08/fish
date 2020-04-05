function getipv4adr
    switch (uname)
    case Darwin
        set ipv4info (ifconfig | grep -e 'inet ' | grep -v '127.0.0.1' | string trim -l | string split ' ')
	set ipv4adrs  $ipv4info[2]
    case Linux
        # /sbin/ifconfig should be full path, because ssh login from other machine happen ifconfig command not found.
        set ipv4info (/sbin/ifconfig | grep -e 'inet ' | grep -v '127.0.0.1' | string trim -l | string split ' ')
	set ipv4adrs  $ipv4info[2]
    case 'MINGW*'
        # chcp.com 65001 : utf-8
        set ipv4info (/c/Windows/System32/chcp.com 65001 | ipconfig | grep -e 'IPv4' | string split ' ')
	set ipv4adr  $ipv4info[-1]
	# During network is connecting Cisco Any Connect, イーサネット アダプター イーサネット2 IP first octet is 137
	set ipv4adrs (/c/Windows/System32/chcp.com 65001 | ipconfig | grep -e 'IPv4' | string match -r '\d+\.\d+\.\d+\.\d+')
    case '*'
        echo "add 'uname' label in ~/.config/fish/functions/networkchk.fish"
	return 1
    end

    echo $ipv4adrs
    # supported by slack
    # Since it's difficult to make regexp to get ip address except first octet 192.
    # echo (string match -r '(?>\d+)(?<!192)\.\d+\.\d+\.\d+' $ipv4adrs)

    for ipv4adr in (string split ' ' $ipv4adrs)
	set foctet (string split . $ipv4adr)
	# echo $foctet[1] # for debug
	if test "$foctet[1]" != "192"
	    return 0  # for "Match exec" in ~/.ssh/config in case of company network
	end
    end

    # my private network
    return 1

end