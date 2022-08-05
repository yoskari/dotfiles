#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PATH=$PATH:/home/oskari/scripts/xmpp/

alias vim=nvim
alias vi=nvim
alias v=nvim
alias z=zathura
alias yt=youtube-dl
alias ls="ls --color=auto"
alias l="ls -lo"

alias pset=$HOME/scripts/punnerrus/pset
alias pcheck=$HOME/scripts/punnerrus/pcheck
alias pstat="cat $HOME/.local/share/punnerrus/punnerrus_stats.txt"

#export PS1="\[\033[38;5;9m\][\A]\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;14m\]\u\[$(tput sgr0)\]\[\033[38;5;11m\]@\[$(tput sgr0)\]\[\033[38;5;12m\]\h\[$(tput sgr0)\]\[\033[38;5;11m\]:\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;11m\]\w\[$(tput sgr0)\]\\$ \[$(tput sgr0)\]"
export PS1="\[\033[38;5;9m\][\A]\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;14m\]\u\[$(tput sgr0)\]\[\033[38;5;11m\]@\[$(tput sgr0)\]\[\033[38;5;12m\]\h\[$(tput sgr0)\]\[\033[38;5;11m\]:\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;11m\]\w\[$(tput sgr0)\]\\$ \[$(tput sgr0)\]"
neofetch
. "$HOME/.cargo/env"
