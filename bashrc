# bash configuration file
#
# REQUIRES:
#       git, vim, tput
#       fzf (https://github.com/junegunn/fzf)
#       bcc (https://github.com/iovisor/bcc)

MANPATH=/usr/share/bcc/man:$MANPATH
PATH=/usr/share/bcc/tools:$PATH
HISTSIZE=10000
HISEFILESIZE=10000
HISTCONTROL=erasedups

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Set a custom prompt with colors :)
BLUE="\[$(tput setaf 99)\]"
RED="\[$(tput setaf 196)\]"
WHITE="\[$(tput setaf 15)\]"
PURPLE="\[$(tput setaf 201)\]"
CYAN="\[$(tput setaf 87)\]"
YELLOW="\[$(tput setaf 226)\]"

export PS1="\u:${YELLOW}\w${CYAN}\$("parse_git_branch")${WHITE}$ "

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

##### SHORTCUTS & ALIASES #####

alias sourceb="source ~/.bashrc"
alias vimb="vim ~/.bashrc"
alias catb="cat ~/.bashrc"
alias ls="ls --color=auto"
alias sl="ls --color=auto"
alias ks="ls --color=auto"
alias ll="ls -lah --color=auto"

# cd to the directory of the file found by fzf
cd_fzf() {
    location=$(fzf)
    if [ ! -z "$location" ]; then
        cd $(dirname $location)
    fi
}
alias cdf="cd_fzf"

# vim the file found by fzf
vim_fzf() {
    location=$(fzf)
    if [ ! -z "$location" ]; then
        vim $location
    fi
}
alias vimf="vim_fzf"

# cd and vim the file found by fzf
cdvim_fzf() {
    location=$(fzf)
    if [ ! -z "$location" ]; then
        cd $(dirname $location)
        vim $(basename $location)
    fi
}
alias cdvimf="cdvim_fzf"

# git aliases

alias sgit="git status"

# taken from https://coderwall.com/p/euwpig/a-better-git-log
alias pgit="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

alias restart_mouse="modprobe -r psmouse && modprobe psmouse"
alias max_fan="echo level 7 > /proc/acpi/ibm/fan"
alias auto_fan="echo level auto > /proc/acpi/ibm/fan"
alias attach_vga_monitor_right="xrandr --output VGA1 --auto --right-of eDP1"
alias rotate_vga_monitor="xrandr --output VGA1 --rotate left"
alias mirror_vga_monitor="xrandr --output VGA1 --same-as eDP1"
alias eDP1_output_1400_900="xrandr --output eDP1 --mode 1400x900"

# surf aliases

facebook() {
    surf www.facebook.com
}
export -f facebook

hackernews() {
    surf news.ycombinator.com
}
export -f hackernews

ddg() {
    query=$@
    surf www.duckduckgo.com?q=${query// /+}
}
export -f ddg

ff() {
    query=$@
    firefox www.duckduckgo.com?q=${query// /+}
}
export -f ff

lock() {
    slock systemctl suspend -i
}
export -f lock
