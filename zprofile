#!/usr/bin/env zsh

# ZPROFILE
#
#

# History size/file are set in zshrc (zprofile is only read by login shells).
export KEYTIMEOUT=1			# reduce vi-mode lag of 0.4 second delay to 0.1

# General exports
export PAGER="less"

# Locale: only fall back to a UTF-8 default when the system has none. LC_ALL is
# deliberately not exported: it overrides every other LC_* category, so no
# per-category setting (LC_TIME, LC_MESSAGES, ...) could ever take effect.
export LANG="${LANG:-en_US.UTF-8}"

# PATH additions use the array form (path+=...) so that typeset -U path from
# zshenv drops duplicates. `export PATH=$PATH:...` bypasses that.

# Add ~/bin to our PATH
[[ -d "$HOME/bin" ]] && path+=("$HOME/bin")

# ~/.local/bin to our PATH
[[ -d "$HOME/.local/bin" ]] && path+=("$HOME/.local/bin")
