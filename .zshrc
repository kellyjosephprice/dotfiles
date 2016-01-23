# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
bindkey -e

if test "OSX" = "$_system_name"; then
  bindkey '[1~' beginning-of-line
  bindkey '[4~' end-of-line
  bindkey '[3~' delete-key
fi

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/kelly/.zshrc'

fpath=(/usr/local/share/zsh-completions $fpath)

autoload -Uz compinit promptinit
compinit
promptinit

RETURN_CODE="%F{red}%(0?..%? )"
PROMPT_CHAR="%(!.%F{red}.%F{yellow})%#"
PS1="%F{green}%T %F{blue}%2~ $RETURN_CODE$PROMPT_CHAR%F{light_white} "

alias cp='cp -i'
alias mv='mv -i'
alias ls='ls -G'
alias less='less -R'
alias grep="grep --color=always"
alias be="bundle exec"
alias rspec="rspec -fd"

alias gloh="git log --oneline | head"

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
source $HOME/.rvm/scripts/rvm

export EDITOR=vim
export PATH=".:bin:$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export RBENV_ROOT=/usr/local/var/rbenv
export LD_LIBRARY_PATH=/usr/local/lib # osx libmagic ?

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

eval "$(direnv hook zsh)"
