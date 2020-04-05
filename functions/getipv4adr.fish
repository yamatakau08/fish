function getipv4adr
    switch (uname)
    case Darwin
        set ipv4info (ifconfig | grep -e 'inet ' | grep -v '127.0.0.1' | string trim -l | string split ' ')
	set ipv4adr  $ipv4info[2]
    case Linux
        # /sbin/ifconfig should be full path, because ssh login from other machine happen ifconfig command not found.
        set ipv4info (/sbin/ifconfig | grep -e 'inet ' | grep -v '127.0.0.1' | string trim -l | string split ' ')
	set ipv4adr  $ipv4info[2]
    case 'MINGW*'
        # chcp.com 65001 : utf-8
        set ipv4info (/c/Windows/System32/chcp.com 65001 | ipconfig | grep -e 'IPv4' | string split ' ')
	set ipv4adr  $ipv4info[-1]
    case '*'
        echo "add 'uname' label in ~/.config/fish/functions/networkchk.fish"
    end

    echo $ipv4adr

    # first octet
    set foctet (string split . $ipv4adr)
    # echo $foctet[1]

    # for Match exec in ~/.ssh/config
    if test "$foctet[1]" = "192"
        # echo "private"
        return 1
    else
        # echo "non private"
        return 0 # for executing "Match exec in ~/.ssh/config"
    end

end