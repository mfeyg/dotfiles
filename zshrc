# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mendel/.zshrc'

autoload -Uz compinit promptinit
compinit
promptinit
# End of lines added by compinstall

setopt hist_ignore_all_dups hist_ignore_space correctall
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

prompt walters

path=( "$HOME/bin" "$path[@]" )

alias external_display="xrandr --output LVDS1 --off --output VGA1 --auto"
alias laptop_screen="xrandr --output VGA1 --off --output LVDS1 --auto"
alias download_from_xclip='wget $(xclip -o)'
alias hdate="date && hebcal -TcCChicago"
alias lh="ls --color=always -lasth|less -R"
alias clock="watch -tn1 'date && hebcal -TcCChicago && acpi'"
alias igrep="grep -i"
alias xo="xclip -o"
alias mpg123="mpg123 -C"
alias df="df -h"
alias jplay='mplayer -fs ~/.jd/downloads/*(-om)'
alias aria=aria2c
alias pgoog="ping google.com"
alias medit='([ -e $(basename $(pwd)).tex ] || (echo Not found && exit 1)) && vim +/maketitle ++1 $(basename $(pwd)).tex'

if [ $UID -ne 0 ]; then
   alias netcfg='sudo netcfg2'
   alias pacman='sudo pacman'
   alias wifi='sudo wifi-select eth1'
   alias rc.d='sudo rc.d'
   alias restart='sudo rc.d restart'
   alias start='sudo rc.d start'
   alias stop='sudo rc.d stop'
   alias reboot='sudo reboot'
   alias halt='sudo halt'
fi

export BROWSER='firefox'
export EDITOR='vim'
export PAGER=$HOME/scripts/vimpager.sh

# ls colors
alias ls="ls --color=auto"
eval "$(dircolors)"

# custom functions
random() {  # pick a random line from a file
  head -$(( $(od -N4 -An -tu /dev/urandom) % ( $( wc -l "$1" | cut -d' ' -f1) + 1 ) )) "$1" | tail -1
}

pmount() {  # special arguments to pmount
   typeset PMOUNT=/usr/bin/pmount
   typeset -A drives
   drives=(drive /dev/disk/by-uuid/C6A06413A0640C6D)
   if [[ -n ${drives[$1]} ]]
   then $PMOUNT ${drives[$1]} "$1"
   else $PMOUNT $*
   fi
}

mkmathhw() {
   typeset NAME=$1
   if [ "x$NAME" = x ]; then
      if [ ! -e h1 ]; then NAME=h1
      else NAME=h$(( $( ls -drv1 h[0-9]## | head -n1 | tr -Cd '[:digit:]' ) + 1)) ; fi
   fi
   mkdir "$NAME"
   cd "$NAME"
   cp ~/math/Makefile .
   ed Makefile <<-END
   ,s/XNAME/$NAME/g
   w
END
   cp ~/math/hw.tex "$NAME".tex
   vim -c'norm zR/TITLEdi{l' -cstart "$NAME".tex
}
