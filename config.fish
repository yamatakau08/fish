switch (uname -s)
    case 'MINGW64*'
        set -x PATH /mingw64/bin $PATH ^ /dev/null
	set DPREFIX /c
    case 'MINGW32*'
        set -x PATH /mingw32/bin $PATH ^ /dev/null
	set DPREFIX /c
    case 'CYGWIN*'
	set DPREFIX /cygdrive/c
    case *
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

# for crontab and so on
#set -x EDITOR	vi
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

# csv make
set -x PATH $DPREFIX/winbin/csvmake/ $PATH ^ /dev/null

# ~/bin for my bin, plantuml batch file
set -x PATH ~/bin $PATH ^ /dev/null

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