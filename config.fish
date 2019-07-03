switch (uname -s)
    case 'MINGW64*'
        # MSYS2 MINGW64 shell lauhcer property working folder C:\msys64 is set as a directory when launch
	# change it to C:\yama
	# set -x HOME /c/yama

        set -x PATH /mingw64/bin $PATH ^ /dev/null
	set -x EDITOR vim

	# csv make
	set -x PATH /c/winbin/csvmake/ $PATH ^ /dev/null

	# for aws on Windows program
	set -x PATH /c/Program\ Files/Amazon/AWSCLI/bin/ $PATH ^ /dev/null

	# for jdk on Windows program
	set -x PATH /c/Program\ Files/Java/jdk-12.0.1/bin $PATH ^ /dev/null

	# for adb
	set -x PATH /c/winbin/Android/Sdk/platform-tools $PATH ^ /dev/null

	# for appium
	set -x ANDROID_HOME /winbin/Android/Sdk
	set -x JAVA_HOME /Program\ Files/Java/jdk-12.0.1
	set -x NO_PROXY localhost

    case 'MINGW32*'
        set -x PATH /mingw32/bin $PATH ^ /dev/null
	set DPREFIX /c
	set -x EDITOR vim
    case 'CYGWIN*'
	set DPREFIX /cygdrive/c
    case *
        set -x EDITOR vi
end

# load private.fish, e.g. proxy...
set PRIVATE_FISH_FILE $HOME/.config/fish/private.fish
if test -f $PRIVATE_FISH_FILE
   source $PRIVATE_FISH_FILE

   # cygwinでaws使うなら有効にしておいた方がよいかも... bashから引き継がれているように見える？
   # Windowsの環境変数で設定したのが引きつがれているので、上の設定だけでも動く
   # aws refer https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-http-proxy.html
   set -x HTTP_PROXY  $PROXY
   set -x HTTPS_PROXY $PROXY
end

# for Subversion
set -x SVN_EDITOR $EDITOR

# for less
set -x LESSHISTFILE $HOME/.history/.lesshst

# for PATH
# to suppress
# set: Warning: $PATH entry is not valid
# refer https://github.com/fish-shell/fish-shell/issues/4197#issuecomment-313870104
# use ^ /dev/null when set $PATH
# amazon web service
set -x PATH ~/.local/bin $PATH ^ /dev/null

# ~/bin for my bin, plantuml batch file
set -x PATH ~/bin $PATH ^ /dev/null
