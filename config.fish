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
source $HOME/.config/fish/private.fish

# cygwinでaws使うなら有効にしておいた方がよいかも... bashから引き継がれているように見える？
# Windowsの環境変数で設定したのが引きつがれているので、上の設定だけでも動く
# aws refer https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-http-proxy.html
set -x HTTP_PROXY  $PROXY
set -x HTTPS_PROXY $PROXY

# for crontab and so on
set -x EDITOR	vi
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
