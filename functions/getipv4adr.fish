function getipv4adr
    switch (uname)
    case Darwin
    case Linux
        set ipv4info (ifconfig | grep -e 'inet ' | grep -v '127.0.0.1' | string trim -l | string split ' ')
	set ipv4adr  $ipv4info[2]
    case 'MINGW64_NT-*'
        # chcp.com 65001 : utf-8
        set ipv4info (/c/Windows/System32/chcp.com 65001 | ipconfig | grep -e 'IPv4' | string split ' ')
	set ipv4adr  $ipv4info[-1]
    case '*'
        echo "add 'uname' label in ~/.config/fish/functions/networkchk.fish"
    end

    echo $ipv4adr
end