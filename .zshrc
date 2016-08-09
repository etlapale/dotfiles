export HISTFILE=~/.zsh/histfile
export HISTSIZE=30000
export SAVEHIST=30000

bindkey -e

source ~/.zsh/prompt

# Auto completion
autoload -U compinit && compinit
autoload -U colors && colors

autoload -U CORRECT
setopt extendedglob

alias ls='ls -Fh --color'

export EDITOR=vim
 
export LANG="en_US.UTF-8"
export LC_COLLATE="C"

# Man pages in color
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline


export LESS='-R -M --shift 5 -F'

# Dot files tracking
alias poconf='git --git-dir=$HOME/.poconf/ --work-tree=$HOME'

# —————————————————————————————————————————————————————————————————————
# Ctrl+Z
# —————————————————————————————————————————————————————————————————————
# - On an empty command line, runs bg (so that Ctrl+Z Ctrl+Z suspends
#   a program and immediately resumes it in the background).
# - On a non-empty command line, suspend the current command edition:
#   let me type another command, and when that second command line
#   finished, I get back the first command to edit.
fancy-ctrl-z() {
  if [[ $#BUFFER -eq 0 ]]; then
    bg
    zle redisplay
  else
    zle push-input
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
