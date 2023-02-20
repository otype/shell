#!/usr/bin/env zsh

# ZPROFILE
#
#

# History settings
export HISTFILESIZE=200000
export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILE=~/.zsh_history
export KEYTIMEOUT=1			# reduce vi-mode lag of 0.4 second delay to 0.1

# General exports
export PAGER="less"

# Lang variables
export LC_CTYPE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"

# Add ~/bin to our PATH
[[ -d "$HOME/bin" ]] && export PATH=$PATH:$HOME/bin

# ~/.local/bin to our PATH
[[ -d "$HOME/.local/bin" ]] && export PATH=$PATH:$HOME/.local/bin

# Add /opt/local/bin
[[ -d "/opt/local/bin" ]] && export PATH=$PATH:/opt/local/bin
