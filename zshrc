# ZSHRC
#
#

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="otype"

# Automatically upgrade oh-my-zsh without prompting you
DISABLE_UPDATE_PROMPT=true

# History size and file (HISTFILESIZE is bash-only and is ignored by zsh).
# Set here and not in zprofile: zprofile is only read by login shells, so a
# non-login terminal would fall back to oh-my-zsh's smaller defaults.
# Must come before oh-my-zsh.sh, which only raises values that are too small.
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history

# Custom completions go on fpath before oh-my-zsh.sh, which runs compinit
# itself. Do not run compinit again afterwards.
fpath=(~/.zsh/completions $fpath)

# Add wisely, as too many plugins slow down shell startup.
# Only plugins bundled with oh-my-zsh are used here. zsh-autosuggestions and
# zsh-syntax-highlighting are NOT installed (they would have to be cloned into
# $ZSH_CUSTOM/plugins/ and added to this list).
plugins=(colored-man-pages colorize emacs git git-extras gh history sudo)

# Set colorize style
ZSH_COLORIZE_STYLE="colorful"

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Extra shell options (history). After oh-my-zsh so they take precedence.
[[ -r ~/.zsh/zshoptions ]] && source ~/.zsh/zshoptions
