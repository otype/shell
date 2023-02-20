# ZSHRC
#
#

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
if [[ $USER == "hgschmidtmw" ]]; then
  ZSH_THEME="bira"
else
  ZSH_THEME="otype"
fi

# Automatically upgrade oh-my-zsh without prompting you
DISABLE_UPDATE_PROMPT=true

# Add wisely, as too many plugins slow down shell startup.
plugins=(common-aliases colored-man-pages colorize dnf docker encode64 github git git-extras golang history pyenv python rust)

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh
