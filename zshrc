# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
if [[ $USER == "hgschmidtmw" ]]; then
    ZSH_THEME="bira"
elif [[ $USER == "hgschmidt" ]]; then
    # Beforehand, copy the otype theme:
    # ln -nsf ./themes/otype.zsh-theme ~/.oh-my-zsh/themes/otype.zsh-theme
    ZSH_THEME="otype"
else
    ZSH_THEME="norm"
fi

# Automatically upgrade oh-my-zsh without prompting you
DISABLE_UPDATE_PROMPT=true

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(common-aliases colored-man-pages colorize dnf docker encode64 github git git-extras golang history pyenv python rust)

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh
