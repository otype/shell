#!/usr/bin/env zsh

# ZSHENV
#
#

# Source all environment configuration files.
for config in ${HOME}/.zsh/env-enabled/*
do
    . ${config}
done

# Ensures all PATH entries are unique.
export PATH=$(echo "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++' | sed 's/:$//' | sed '/^$/d')
