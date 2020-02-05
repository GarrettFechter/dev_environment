# bash configuration file
#
# REQUIRES:
#       git, vim, tput
#       fzf (https://github.com/junegunn/fzf)
#       bcc (https://github.com/iovisor/bcc)

MANPATH=/usr/share/bcc/man:$MANPATH
PATH=/usr/share/bcc/tools:$PATH

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
alias sl="ls"
alias ll="ls -lah"

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

# git aliases

alias sgit="git status"

# below taken from https://coderwall.com/p/euwpig/a-better-git-log
# thanks!
alias pgit="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
