# Shell

This is my rather extensive [ZSH](http://www.zsh.org/) configuration.

## Requirements

- [ZSH](http://www.zsh.org/)
- [Oh My ZSH!](https://ohmyz.sh/)

## Getting started

1. Fork this repository, then clone it to your laptop:

        $ git clone git@github.com:otype/shell.git ~/.shell

2. Symlink ZSH configuration files:

        $ ln -nsf ~/.shell/zshenv ~/.zshenv
        $ ln -nsf ~/.shell/zshrc ~/.zshrc
        $ ln -nsf ~/.shell/zsh/ ~/.zsh
        $ ln -nsf ~/.shell/zprofile ~/.zprofile

3. Modify [zshrc](/otype/shell/blob/master/zsh/zshrc) and update oh-my-zsh location and theme.

4. Enable the configuration files you need:

    For example, if you want to enable the homebrew config `~/.zsh/env-available/zshenv-brew`:

        $ cd ~/.zsh/env-enabled
        $ ln -nsf ../env-available/zshenv-brew


That's it! Repeat this for any other configuration and restart your terminal session.

_Note: Make sure to check each configuration for sanity and correct paths!_
