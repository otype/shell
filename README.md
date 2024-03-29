# Shell

#### A ZSH setup via simple configurations.

<p>
	<a href="https://github.com/otype/shell/commits/master">
	<img src="https://img.shields.io/github/last-commit/otype/shell.svg?style=flat-square&logo=github&logoColor=white" alt="GitHub last commit">
    <a href="https://github.com/otype/shell/issues">
    <img src="https://img.shields.io/github/issues-raw/otype/shell.svg?style=flat-square&logo=github&logoColor=white" alt="GitHub issues">
    <a href="https://github.com/otype/shell/pulls">
    <img src="https://img.shields.io/github/issues-pr-raw/otype/shell.svg?style=flat-square&logo=github&logoColor=white" alt="GitHub pull requests">
	<a href="https://github.com/otype/shell/blob/main/LICENSE">
	<img src="https://img.shields.io/github/license/otype/shell" alt="LICENSE">
</p>

Shell is a pluggable configuration for [ZSH](http://www.zsh.org/). Mainly focusing Linux-based systems (partially also Mac OS X), it provides helpful functions, aliases and PATH definitions for a variety of tools you might be using.

Configurations exist for tools/SDKs like [Android SDK](https://developer.android.com/about/versions/13/setup-sdk#install-sdk), [Docker](https://www.docker.com/), [Emacs](https://www.gnu.org/software/emacs/), [Git](https://git-scm.com/), [Goenv](https://github.com/syndbg/goenv), [powerline](https://github.com/powerline/powerline), [pyenv](https://github.com/pyenv/pyenv), [rbenv](https://github.com/rbenv/rbenv), [Rust](https://www.rust-lang.org/) and [tilix](https://gnunn1.github.io/tilix-web/).

## Installation

#### Requirements

- [ZSH](http://www.zsh.org/)
- [Oh My ZSH!](https://ohmyz.sh/)
- [Vim](https://www.vim.org/)

#### Automatic installer

Via install script

```console
$ curl -L https://raw.githubusercontent.com/otype/shell/main/bin/install.sh | bash
```

## Post-installation steps

###  Enable configurations

Configurations can be found in `~/.zsh/env-available/`. To enable e.g. the Android-SDK config `~/.zsh/env-available/zshenv-android` symlink the config:

```console
$ cd ~/.zsh/env-enabled && ln -nsf ../env-available/zshenv-android
```

Repeat by linking any other configuration you need. Restart your terminal session.

_Note: Make sure to check each configuration for sanity and correctness!_

### Load plugins and theme

Modify [zshrc](zshrc):

1. **Set your theme.** A preview of Oh My ZSH! themes can be found in the official [Themes documentation](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes).

    ```console
    ZSH_THEME="otype"
    ```

2. **Load your ZSH plugins.** A list of all plugins can be found in the official [ZSH - Plugins documentation](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins).

    ```console
    plugins=(common-aliases colored-man-pages colorize <ADD_MORE_HERE>)
    ```
