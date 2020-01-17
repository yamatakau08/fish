switch (uname)
    case 'MINGW64*'
        # MSYS2 MINGW64 shell lauhcer property working folder C:\msys64 is set as a directory when launch
	# change it to C:\yama
	# set -x HOME /c/yama # this doesn't effect

        set -x PATH /mingw64/bin $PATH ^ /dev/null

	set -x EDITOR vim
	alias vi='vim'

	# csv make
	set -x PATH /c/winbin/csvmake/ $PATH ^ /dev/null

	# for aws on Windows program
	set -x PATH /c/Program\ Files/Amazon/AWSCLI/bin/ $PATH ^ /dev/null

	# for adb
	set -x PATH /c/winbin/Android/Sdk/platform-tools $PATH ^ /dev/null

	# jdk on Windows program
	set -x PATH /c/Program\ Files/Java/jdk-12.0.1/bin $PATH ^ /dev/null

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
    case 'MINGW32*'
        set -x PATH /mingw32/bin $PATH ^ /dev/null
	set DPREFIX /c

	set -x EDITOR vim
	alias vi='vim'

	# for adb
	set -x PATH /c/winbin/Android/Sdk/platform-tools $PATH ^ /dev/null

	# to suppress warning when execute gem install sqlite3 --platform ruby
	set -x PATH /c/yama/.gem/ruby/2.6.0/bin $PATH ^ /dev/null
    case 'Darwin*' # on mac
        set -x EDITOR vi

	### for appium
	# for adb
	set -x ANDROID_HOME ~/Library/Android/sdk
	set -x PATH $ANDROID_HOME/platform-tools $PATH ^ /dev/null
	set -x PATH $ANDROID_HOME/tools $PATH ^ /dev/null

	# for java
	#set -x JAVA_HOME /System/Library/Frameworks/JavaVM.framework/Versions/A/Commands
	#set -x JAVA_HOME /usr/libexec/java_home
	#set -x PATH $JAVA_HOME $PATH ^ /dev/null


	# to supress openssl error message when brew upgrade ruby-build on Mac
	set -x PATH /usr/local/opt/openssl/bin $PATH ^ /dev/null

	# for ruby bundler ...
	#set -x PATH $HOME/.gem/ruby/2.3.0/bin $PATH ^ /dev/null
	# rbenv
	rbenv init - | source

	# for opencv4nodejs
	set -x NODE_PATH (npm root -g)

	# for PATH
	# to suppress
	# set: Warning: $PATH entry is not valid
	# refer https://github.com/fish-shell/fish-shell/issues/4197#issuecomment-313870104
	# use ^ /dev/null when set $PATH
	# amazon web service
	set -x PATH ~/.local/bin $PATH ^ /dev/null

	## for brew doctor
	set -x PATH /usr/local/sbin $PATH ^ /dev/null
    case 'Linux'
        set -x EDITOR vi
end

# load private.fish, e.g. proxy...
set PRIVATE_FISH_FILE $HOME/.config/fish/private.fish
if test -f $PRIVATE_FISH_FILE
   source $PRIVATE_FISH_FILE
end

string match '192.*' (getipv4adr) # later need to add ^ /dev/null
if test $status -eq 0 # private network
    ## for git, remove section [http] [https] in ~/.gitconfig
    #  need ^ /dev/null in case of [http] [https] section is none.
    git config --global --remove-section http  ^ /dev/null
    git config --global --remove-section https ^ /dev/null
else # company network
    ## cygwinでaws使うなら有効にしておいた方がよいかも... bashから引き継がれているように見える？
    # Windowsの環境変数で設定したのが引きつがれているので、上の設定だけでも動く
    # aws refer https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-http-proxy.html
    set -x HTTP_PROXY  $PROXY
    set -x HTTPS_PROXY $PROXY

    ## for wget, wget use enviroment variable with small character, not big one
    # https://qiita.com/nutti/items/4ed09d3d61ccad49069b
    set -x http_proxy  $PROXY
    set -x https_proxy $PROXY
    set -x ftp_proxy   $PROXY

    ## for git, set proxy setting [http] [https] in ~/.gitconfig
    git config --global http.proxy  $PROXY
    git config --global https.proxy $PROXY
end

# for Subversion
set -x SVN_EDITOR $EDITOR

# for less
set -x LESSHISTFILE $HOME/.history/.lesshst

# ~/bin for my bin, plantuml batch file
set -x PATH ~/bin $PATH ^ /dev/null
