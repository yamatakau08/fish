switch (uname)
    case 'CYGWIN*'
	# for adb platform tool
	# Since inherit Windows PATH environment, no need to set
	#set -x PATH /cygdrive/c/Users/0000910700/AppData/Local/Android/Sdk/platform-tools $PATH 2> /dev/null

	set -x NO_PROXY localhost # for anki,anki-connect

	## abbr
	# for onedrive
	abbr --add onedrive cd "'/cygdrive/c/Users/0000910700/OneDrive - $onedrive_company'"
	abbr --add mpv /usr/local/Cellar/mpv/0.39.0_1/bin/mpv

    case 'MINGW64*'
        # on MSYS2 msys2.exe mingw32/64.exe
        # to set default directory to your home directory
	# at property dialog, set working folder "C:\yama" instead of "C:\msys64"
	# set -x HOME /c/yama # this doesn't effect

        set -x PATH /mingw64/bin $PATH 2> /dev/null

	set -x EDITOR vim
	alias vi='vim'

	# csv make
	set -x PATH /c/winbin/csvmake/ $PATH 2> /dev/null

	# for aws on Windows program
	set -x PATH /c/Program\ Files/Amazon/AWSCLI/bin/ $PATH 2> /dev/null

	# for adb
	set -x PATH /c/winbin/Android/Sdk/platform-tools $PATH 2> /dev/null

	# jdk on Windows program
	set -x PATH /c/Program\ Files/Java/jdk-12.0.1/bin $PATH 2> /dev/null

	## for appium
	set -x NO_PROXY localhost
	#  for appium CLI on ruby
	# if set C:\winbin\Android\Sdk\Platform-tools in environment path on dos,
	# you will get UnknownError: An unknown server-side error occurred while processing the command. Original error: Could not find 'adb.exe' in ["c:\\c\\winbin\\Android\\Sdk\\platform-tools\\adb.exe" ...
	# appium GUI works normally
	set -x ANDROID_HOME /c/winbin/Android/Sdk
	set -x JAVA_HOME    /c/Program\ Files/Java/jdk-12.0.1

	# to display prompt when execute bash from fish
	set -x MSYS2_PS1 '\h:\W \u\$ '

	# for Pandoc
	set -x PATH /c/Program\ Files/Pandoc $PATH 2> /dev/null

    case 'MINGW32*'
        # set -x PATH /mingw32/bin /mingw64/bin $PATH 2> /dev/null # add /mingw64/bin for ag.
	# when add /mingw64/bin for silver search ag from emacs helm-ag
	# ruby gem sqlite3 puts out error the following
        # Ignoring sqlite3-1.4.2 because its extensions are not built. Try: gem pristine sqlite3 --version 1.4.2
	# read_data.rb: stack level too deep (SystemStackError)
	# It's not good idea to add /mingw64/bin inspite on mingw32 envrironment
	set -x PATH /mingw64/bin $PATH 2> /dev/null # when add /mingw64/bin, ruby gem sqlite3 doesn't work

	set -x EDITOR vim
	alias vi='vim'

	# for aws on Windows program
	set -x PATH /c/Program\ Files/Amazon/AWSCLI/bin/ $PATH 2> /dev/null

	# for adb
	set -x PATH /c/winbin/Android/Sdk/platform-tools $PATH 2> /dev/null

	# to suppress warning when execute gem install sqlite3 --platform ruby
	set -x PATH /c/yama/.gem/ruby/2.6.0/bin $PATH 2> /dev/null

    case 'MSYS*'
	# for adb
	set -x PATH /c/winbin/Android/Sdk/platform-tools $PATH 2> /dev/null
	set -x PATH /c/msys64/mingw32/bin $PATH 2> /dev/null # when add /mingw32/bin, silver search ag

    case 'Darwin*' # on mac
        set -x EDITOR vi

	### for appium
	# for adb
	set -x ANDROID_HOME ~/Library/Android/sdk
	set -x PATH $ANDROID_HOME/platform-tools $PATH 2> /dev/null
	set -x PATH $ANDROID_HOME/tools $PATH 2> /dev/null

	# for java
	#set -x JAVA_HOME /System/Library/Frameworks/JavaVM.framework/Versions/A/Commands
	#set -x JAVA_HOME /usr/libexec/java_home
	#set -x PATH $JAVA_HOME $PATH 2> /dev/null


	# to supress openssl error message when brew upgrade ruby-build on Mac
	set -x PATH /usr/local/opt/openssl/bin $PATH 2> /dev/null

	# for ruby bundler ...
	#set -x PATH $HOME/.gem/ruby/2.3.0/bin $PATH 2> /dev/null
	# rbenv
	rbenv init - | source

	# for opencv4nodejs
	set -x NODE_PATH (npm root -g)

	# for PATH
	# to suppress
	# set: Warning: $PATH entry is not valid
	# refer https://github.com/fish-shell/fish-shell/issues/4197#issuecomment-313870104
	# use 2> /dev/null when set $PATH
	# amazon web service
	set -x PATH ~/.local/bin $PATH 2> /dev/null

	## for brew doctor
	set -x PATH /usr/local/sbin $PATH 2> /dev/null
    case 'Linux'
        set -x EDITOR vim
	alias vi='vim'
end

# once load private.fish, e.g. proxy...
set PRIVATE_FISH_FILE $HOME/.config/fish/private.fish
if test -f $PRIVATE_FISH_FILE
   source $PRIVATE_FISH_FILE
else
   echo "no private fish!"
end

string match '192.*' (getipv4adr) # later need to add 2> /dev/null
if test $status -eq 0 # private network
    # unexport environment which is set the above
    set --unexport HTTP_PROXY
    set --unexport HTTPS_PROXY

    ## for git, remove section [http] [https] in ~/.gitconfig
    #  need 2> /dev/null in case of [http] [https] section is none.
    git config --global --remove-section http  2> /dev/null
    git config --global --remove-section https 2> /dev/null

else # company network
    ## cygwinでaws使うなら有効にしておいた方がよいかも... bashから引き継がれているように見える？
    # Windowsの環境変数で設定したのが引きつがれているので、上の設定だけでも動く
    # aws refer https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-http-proxy.html
    #set -x HTTP_PROXY  $PROXY
    ## comment HTTPS_PROXY
    # curl backend of use-package use this environment variable,
    # (url-retrieve-synchronously "https://orgmode.org/elpa/archive-contents") take much time to finish
    # set -x HTTPS_PROXY $PROXY

    ## for wget, wget use enviroment variable with small character, not big one
    # https://qiita.com/nutti/items/4ed09d3d61ccad49069b
    #set -x http_proxy  $PROXY
    # set -x https_proxy $PROXY # see HTTPS_PROXY comment is above.
    #set -x ftp_proxy   $PROXY

    ## for git, set proxy setting [http] [https] in ~/.gitconfig
    #git config --global http.proxy  $PROXY
    #git config --global https.proxy $PROXY
end

# for Subversion
set -x SVN_EDITOR $EDITOR

# for less
set -x LESSHISTFILE $HOME/.history/.lesshst

# for hunspell
set -x DICPATH $HOME/.emacs.d/myspell

# ~/bin for my bin, plantuml batch file
set -x PATH ~/bin $PATH 2> /dev/null
# ~/.config/fish/functions for ascreenrecord.sh
set -x PATH ~/.config/fish/functions $PATH 2> /dev/null

# for "Match exec" in ~/.ssh/config
# refer https://unix.stackexchange.com/a/565266
set -x SHELL (type -p fish)

alias cls='clear'
alias ls='ls -alF'

# color
set -g fish_color_command white

## Since Msys 3.2.0-340.x86_64 can't handle the home directory field in /etc/passwd, move home directory explicitly.
## but comment out the following, because `fish hoge.fish` doesn't work and no longer use Msys environment
#cd $HOME

alias cg1console="myteraterm --speed 921600 --model CG1"
alias bluefinconsole="myteraterm --speed 115200 --model bulefin1.1"

## Python numpy on Cygwin
fish_add_path /lib/lapack # effect
#set -x HTTP_PROXY  "http://"$PROXY_SERVER":"$PROXY_PORT
#set -x HTTPS_PROXY "http://"$PROXY_SERVER":"$PROXY_PORT

# for Mac Ports
set -x PATH /opt/local/bin $PATH 2> /dev/null
# for Python opencv(34)
set -x PYTHONPATH /opt/local/lib/opencv4
