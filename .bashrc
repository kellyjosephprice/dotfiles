# kprice's .bashrc 
#

# Check for an interactive session
[ -z "$PS1" ] && return

PATH=$PATH:.:${HOME}/bin/
export PATH

export HISTSIZE=1000
[[ `which vim` ]] && export EDITOR=vim

complete -cf man
complete -cf sudo

alias ls='ls --color=auto'
alias rm='rm -I'
alias cp='cp -i'
alias mv='mv -i'
alias less='less -R'
alias sudo="sudo "
alias xcalc="xcalc -stipple"
alias grep="grep --color=always"

[[ `grep 'Arch Linux' /etc/issue` ]] && alias pacman="pacman-color"

txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
badgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

say() { 
    if [[ "${1}" =~ -[a-z]{2} ]]; then 
        local lang=${1#-}; 
        local text="${*#$1}"; 
    else 
        local lang=${LANG%_*}; 
        local text="$*";
    fi; 
    mplayer "http://translate.google.com/translate_tts?ie=UTF-8&tl=${lang}&q=${text}" &> /dev/null ; 
}

bash_prompt_cmd() {
    #   How many characters of the $PWD should be kept
    local pwdmaxlen=18
    #   Indicator that there has been directory truncation:
    #trunc_symbol="<"
    local trunc_symbol="<"
    if [ ${#PWD} -gt $pwdmaxlen ]
        then
            local pwdoffset=$(( ${#PWD} - $pwdmaxlen ))
            newPWD="${trunc_symbol}${PWD:$pwdoffset:$pwdmaxlen}"
        else
            newPWD=${PWD}
    fi
}
PROMPT_COMMAND=bash_prompt_cmd

if [ -n "$SSH_CLIENT" ]; then
    HOST_SHORT=`echo $HOSTNAME | cut -c1-5`
    PS1="\[$txtgrn\]\A\[$txtwht\] \[$bldblu\]\${newPWD} \[$txtylw\]$HOST_SHORT \$ \[$txtrst\]"
else 
    if [ `id -u` != "0" ]; then
        PS1="\[$txtgrn\]\A\[$txtwht\] \[$bldblu\]\${newPWD} \[$txtylw\]\$ \[$txtrst\]"
    else
        PS1="\[$txtgrn\]\A\[$txtwht\] \[$bldblu\]\${newPWD} \[$txtred\]\$ \[$txtrst\]"
    fi
fi

case $TERM in 
    screen*)
        HOST_SHORT=`echo $HOSTNAME | cut -c1-5`
        SCREENTITLE='\033${HOST_SHORT}\033\\'
        ;;
    *)
        SCREENTITLE=''
        ;;
esac

PS1=${SCREENTITLE}${PS1}

# load .bashrc.local
[[ -f ${HOME}/.bashrc.local ]] && source ${HOME}/.bashrc.local
