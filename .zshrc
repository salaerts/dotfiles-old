setopt promptsubst
autoload -U promptinit
promptinit
#prompt grb

autoload -U compinit
compinit

# Add paths that should have been there by default
export PATH=/usr/local/sbin:/usr/local/bin:${PATH}
# export PATH="$HOME/bin:$PATH"
# export PATH="$PATH:~/.gem/ruby/1.8/bin"

# Unbreak history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

alias tmux="TERM=screen-256color-bce tmux"
