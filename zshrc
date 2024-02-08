# ZSHRC
#
#

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="otype"

# Use different them for Meltwater account
[[ $USER == "hgschmidtmw" ]] && ZSH_THEME="bira"

# Automatically upgrade oh-my-zsh without prompting you
DISABLE_UPDATE_PROMPT=true

# Add wisely, as too many plugins slow down shell startup.
plugins=(common-aliases colored-man-pages colorize dnf docker docker-compose emacs encode64 github git git-extras gh golang history kubectl pyenv python mvn rust terraform)

# Set colorize style
ZSH_COLORIZE_STYLE="colorful"

# Ensure all zsh completions are loaded
fpath=(~/.zsh/completions $fpath)
autoload -U compinit && compinit

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh
