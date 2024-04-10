#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PATH=$PATH:/home/oskari/scripts/path/

alias vim=nvim
alias vi=nvim
alias v=nvim
alias z=zathura
alias yt=youtube-dl
alias ls="ls --color=auto"
alias l="ls -lo"
alias ll="ls -l --color=auto"
alias la="ls -la --color=auto"
alias gdb="TERM=vt100 gdb"

alias pset=$HOME/scripts/punnerrus/pset
alias pcheck=$HOME/scripts/punnerrus/pcheck
alias pstat="cat $HOME/.local/share/punnerrus/punnerrus_stats.txt"
export EDITOR=nvim

export HISTFILESIZE=10000
export PATH=$HOME/stm32/bitbake/bin:$PATH
export PYTHONPATH=$HOME/stm32/bitbake/lib:$PYTHONPATH

#export PS1="\[\033[38;5;9m\][\A]\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;14m\]\u\[$(tput sgr0)\]\[\033[38;5;11m\]@\[$(tput sgr0)\]\[\033[38;5;12m\]\h\[$(tput sgr0)\]\[\033[38;5;11m\]:\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;11m\]\w\[$(tput sgr0)\]\\$ \[$(tput sgr0)\]"
#export PS1="\[\033[38;5;9m\][\A]\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;14m\]\u\[$(tput sgr0)\]\[\033[38;5;11m\]@\[$(tput sgr0)\]\[\033[38;5;12m\]\h\[$(tput sgr0)\]\[\033[38;5;11m\]:\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;11m\]\w\[$(tput sgr0)\]\\$ \[$(tput sgr0)\]"
#export PS1="\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;14m\]\u\[$(tput sgr0)\]\[\033[38;5;11m\]@\[$(tput sgr0)\]\[\033[38;5;12m\]\h\[$(tput sgr0)\]\[\033[38;5;11m\]:\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;11m\]\w\[$(tput sgr0)\]\\$ \[$(tput sgr0)\]"
PS1='\[\e[93m\]\w \[\e[0m\]❯ '
. "$HOME/.cargo/env"
