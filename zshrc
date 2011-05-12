# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
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

#PROMPT="%B%(?..[%?] )%b%n@%U%m%u>"
#RPROMPT="(%T)  %F{green}%~%f"
prompt walters

alias external_display="xrandr --output LVDS1 --off --output VGA1 --auto"
alias laptop_screen="xrandr --output VGA1 --off --output LVDS1 --auto"
alias download_from_xclip='wget $(xclip -o)'

export BROWSER='firefox'
export EDITOR='vim'
