set -U fish_greeting ""
# aliases 
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias mkdir="mkdir -p"
# default to human readable figured
alias df="df -h"
alias du="du -kh"
# misc ;)
alias grep="grep --color"
# some shortcuts for different directory listings
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.
alias lsd="ls -l | grep ^d"
# disk usage, with color
alias ncdu='ncdu --color dark'
# find and delete empty dirs
alias demp='find . -empty -type d -delete'

# cht.sh online manpages
function cht
    command curl "cheat.sh/$argv"
end  


# up arrow alias for ctrl-p
#bindkey "^P" up-line-or-search
#bindkey "^N" down-line-or-search

starship init fish | source
