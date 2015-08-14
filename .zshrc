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

# key bindings
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "^H" backward-delete-word
# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
# for non RH/Debian xterm, can't hurt for RH/DEbian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix

source $HOME/.profile
source /home/kelly/.rvm/scripts/rvm

export EDITOR=vim
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
