# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A pluggable ZSH configuration ("dotfiles") repo, intended to be cloned to `~/.shell` and symlinked into `$HOME` (`~/.zshenv`, `~/.zshrc`, `~/.zsh`, `~/.zprofile`). There is no build, lint, or test tooling — changes are verified by sourcing the shell files and checking behavior interactively.

## Architecture

Load order on shell startup (standard zsh startup file order):

1. **`zshenv`** — sourced for every shell. Iterates `zsh/env-enabled/*` and sources each file, then de-duplicates `$PATH`.
2. **`zprofile`** — sourced for login shells. Sets history file location/size, locale (`en_US.UTF-8`), `$PAGER`, and appends `~/bin`, `~/.local/bin`, `/opt/local/bin` to `$PATH` if they exist.
3. **`zshrc`** — sourced for interactive shells. Configures Oh My Zsh (theme, plugins), then sources `$ZSH/oh-my-zsh.sh`, then adds `~/.zsh/completions` to `fpath` and runs `compinit`.

### `zsh/env-available/` vs `zsh/env-enabled/`

This is the core plugin mechanism:

- `zsh/env-available/zshenv-<tool>` — one config file per tool/SDK (Android SDK, Docker, Emacs, Git, Goenv, powerline, pyenv, rbenv, Rust, tilix, etc.), each guarding its own logic (e.g. checking a binary exists or a directory is present) before exporting `PATH`/env vars or defining aliases.
- `zsh/env-enabled/` — contains **symlinks** to files in `env-available/`. Only files linked here get sourced by `zshenv`. This mirrors the Apache/nginx `sites-available`/`sites-enabled` pattern.

To add a new tool config: create `zsh/env-available/zshenv-<name>`, following the existing files' pattern of guarding all logic with existence checks (`command -v`, `[[ -d ... ]]`, etc.) so the config is a no-op on machines without that tool. To enable it, symlink it into `zsh/env-enabled/`:

```console
$ cd zsh/env-enabled && ln -nsf ../env-available/zshenv-<name>
```

### Theme

`themes/otype.zsh-theme` is an Oh My Zsh theme. It defines per-language version-detection functions (each guarded by checking the binary exists *and* a marker file like `go.mod`/`Cargo.toml`/`package.json` is present in the cwd) and assembles the prompt (`PROMPT`/`RPROMPT`) from git status plus detected language versions.

### Installer

`bin/install.sh` is the one-shot installer fetched via curl. It clones this repo to `$SHELL_ROOT` (default `~/.shell`), refuses to run if that directory already exists, and symlinks `zshenv`/`zshrc`/`zsh`/`zprofile` into `$HOME`, plus the theme into `~/.oh-my-zsh/themes/` if Oh My Zsh is present.

## Conventions

- Every `env-available` config must be self-guarding (safe to source even when the tool it configures isn't installed).
- `$PATH` de-duplication happens once, centrally, in `zshenv` — don't add per-file dedup logic.
