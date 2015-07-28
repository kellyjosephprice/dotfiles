# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/kelly/.zshrc'

autoload -Uz compinit promptinit
compinit
promptinit

RETURN_CODE="%F{red}%(0?..%? )"
PROMPT_CHAR="%(!.%F{red}.%F{yellow})%#"
PS1="%F{green}%T %F{blue}%2~ $RETURN_CODE$PROMPT_CHAR%F{light_white} "

alias ls='ls --color=auto'
alias rm='rm -I'
alias cp='cp -i'
alias mv='mv -i'
alias less='less -R'
alias xcalc="xcalc -stipple"
alias grep="grep --color=always"
alias be="bundle exec"

source $HOME/.profile
source /home/kelly/.rvm/scripts/rvm

export EDITOR=vim
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
