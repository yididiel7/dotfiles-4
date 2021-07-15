test -z "$PS1" && return
test -d ~/bash_history/ || mkdir ~/bash_history/
test -d ~/clip_history/ || mkdir ~/clip_history/

export EDITOR=vim
alias vim=nvim

shopt -s checkwinsize
shopt -s cmdhist
shopt -s cdspell
shopt -s cdable_vars

complete -cf sudo
if test "$HOSTNAME" == "teefour"
then
	GREEN="\[$(tput setaf 2)\]"
	RESET="\[$(tput sgr0)\]"
	PS1="${GREEN}\[\e[1m\]\w\$\[\e[0m\] ${RESET}"
fi

umask 002

alias ll='ls -alh --group-directories-first --color=always'
alias ac="/usr/bin/vim ~/private/accounts"
alias suspend='sudo systemctl suspend'
alias grep='GREP_COLOR="1;33;40" LANG=C grep --exclude-dir=node_modules --color=auto'

export WEBC_CHECKOUT=/home/hendry/webc/webc
if test -d $WEBC_CHECKOUT
then
	c() {
		#sudo mount -t proc proc $WEBC_CHECKOUT/proc/
		#sudo mount -t sysfs sys $WEBC_CHECKOUT/sys/
		#sudo mount -o bind /dev $WEBC_CHECKOUT/dev/
		sudo chroot /home/hendry/webc/webc env -i GIT_AUTHOR_NAME='Kai Hendry' PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash
		#sudo umount $WEBC_CHECKOUT/proc/
		#sudo umount $WEBC_CHECKOUT/sys/
		#sudo umount $WEBC_CHECKOUT/dev/
	}
fi

# http://unix.stackexchange.com/a/18443/27433
shopt -s histappend
HISTCONTROL=ignoredups
PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"
export HISTFILESIZE=-1 HISTSIZE=-1
HISTFILE=~/bash_history/$(date +%Y-%m)

h() {
	grep -a $@ ~/bash_history/*
}

p() {
	curl -n -F 'f:1=<-' http://ix.io
}

bitrate () {
	iw wlan0 link | grep bitrate
}

vtime () {
	ffprobe -v quiet -print_format json -show_format "$1" | jq -r .format.tags.creation_time
}

export GIT_AUTHOR_NAME="Kai Hendry"
export GIT_COMMITTER_NAME="Kai Hendry"
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

if test -d "/usr/local/bin"
then
	PATH="/usr/local/bin:$PATH"
fi


if test -d "/home/hendry/.local/bin"
then
	PATH="/home/hendry/.local/bin:$PATH"
fi

cors() {
curl -v -o /dev/null $1 2>&1 | grep Allow
}

if test -d "$HOME/.local/bin"
then
	PATH="$HOME/.local/bin:$PATH"
fi

if test -d "$HOME/bin"
then
	PATH="$HOME/bin:$PATH"
fi

if test -d "/home/linuxbrew/.linuxbrew/bin/"
then
	PATH="$PATH:/home/linuxbrew/.linuxbrew/bin/"
fi

if test -d /home/hendry/google-cloud-sdk
then

# The next line updates PATH for the Google Cloud SDK.
source '/home/hendry/google-cloud-sdk/path.bash.inc'

# The next line enables bash completion for gcloud.
source '/home/hendry/google-cloud-sdk/completion.bash.inc'

export CLOUDSDK_PYTHON=python2
fi

test -f ~/.profile && source ~/.profile

test -d "$HOME/.node_modules/bin" && export PATH="$HOME/.node_modules/bin:$PATH"

alias g="cd /home/hendry/go/src/github.com/kaihendry"


webcup() {
	cd $WEBC_CHECKOUT
	git push
}

test -f /usr/bin/ruby && PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
test -d /home/hendry/tmp/flutter/bin && PATH="/home/hendry/tmp/flutter/bin:$PATH"
export CHROME_EXECUTABLE=/usr/bin/chromium
export ANDROID_SDK_ROOT=/opt/android-sdk

test -f /usr/bin/aws_completer && complete -C '/usr/bin/aws_completer' aws

# added by travis gem
[ -f /home/hendry/.travis/travis.sh ] && source /home/hendry/.travis/travis.sh

export PATH="/usr/local/sbin:$PATH"

r() {
	cd /home/hendry/recordmydesktop2.0/$(date +%Y-%m-%d)
}

test -f /etc/profile.d/autojump.bash && source /etc/profile.d/autojump.bash

export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
alias today='date -u +%Y-%m-%d'

millitime() {
        if test "$1"
        then
                # time described by arg
                echo $(($(date -d"$1" +%s%N)/1000000))
        else
                # now
                echo $(($(date +%s%N)/1000000))
        fi
}

alias vimconfig="$EDITOR ~/.config/nvim/init.vim"

stty -ixon -ixoff # disregard Ctrl-S \023 and Ctrl+Q \021 so that we can use them scrolling


set -o vi
bind -m vi-insert '\c-l':clear-screen
bind -m vi-insert '\c-e':end-of-line
bind -m vi-insert '\c-a':beginning-of-line
bind -m vi-insert '\c-h':backward-kill-word
bind -m vi-insert '\c-k':kill-line

sloc() {
	find . -not -path '*/\.*' -type f -print0 | wc -l --files0-from=- | sort -n
}

# eval "$(pyenv init -)"

vpn() {
	/usr/bin/gpclient
}


# >>> talisman >>>
# Below environment variables should not be modified unless you know what you are doing
export TALISMAN_HOME=/home/hendry/.talisman/bin
alias talisman=$TALISMAN_HOME/talisman_linux_amd64
export TALISMAN_INTERACTIVE=true
# <<< talisman <<<
