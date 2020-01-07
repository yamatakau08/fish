function getipv4adr
    switch (uname -s)
    case Darwin
        set ipv4info (ifconfig | grep -e 'inet ' | grep -v '127.0.0.1' | string split ' ')
	set ipv4adr  $ipv4info[2]
    case Linux
    case 'MINGW64_NT-*'
    case '*'
        echo "add 'uname' label in ~/.config/fish/functions/networkchk.fish"
    end

    echo $ipv4adr
end