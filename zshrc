# ZSHRC
#
#

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Default theme (overridden below for specific accounts)
ZSH_THEME="otype"

# Use different theme for Meltwater account
[[ $USER == "hgschmidtmw" ]] && ZSH_THEME="bira"

# Automatically upgrade oh-my-zsh without prompting you
DISABLE_UPDATE_PROMPT=true

# Add wisely, as too many plugins slow down shell startup.
# Note: z, sudo, direnv are bundled with OMZ.
# zsh-autosuggestions + zsh-syntax-highlighting must be cloned into $ZSH_CUSTOM/plugins/.
plugins=(common-aliases colored-man-pages colorize dnf docker docker-compose emacs encode64 github git git-extras gh golang history kubectl pyenv python mvn rust terraform z sudo)

# Set colorize style
ZSH_COLORIZE_STYLE="colorful"

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Ensure all zsh completions are loaded (must run after oh-my-zsh and all fpath additions)
fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit && compinit
