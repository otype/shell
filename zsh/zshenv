#!/usr/bin/env zsh

# ZSH
#
#

# SOURCE ALL ENVIRONMENT CONFIGS
#
#
for config in ${HOME}/.zsh/env-enabled/*
do
    . ${config}
done

export PATH=$(echo "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++' | sed 's/:$//' | sed '/^$/d')
