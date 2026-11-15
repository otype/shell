#!/usr/bin/env zsh

# ZSHENV
#
#

# Keep every PATH entry unique. This is zsh-native (no awk/sed subprocesses,
# paths with spaces are safe) and the flag stays set for the whole session, so
# entries added later (zprofile, tool installers, ...) are de-duplicated too.
typeset -U path

# Source all environment configuration files. (N) = no error if the directory
# is empty.
for config in ${HOME}/.zsh/env-enabled/*(N)
do
    . "${config}"
done
