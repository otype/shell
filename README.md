<div align="center">

# 🐚 Shell

**A pluggable, fast ZSH setup built from small, opt-in configurations.**

[![Last commit](https://img.shields.io/github/last-commit/otype/shell/main?style=flat-square&logo=github&logoColor=white)](https://github.com/otype/shell/commits/main)
[![Issues](https://img.shields.io/github/issues-raw/otype/shell?style=flat-square&logo=github&logoColor=white)](https://github.com/otype/shell/issues)
[![Pull requests](https://img.shields.io/github/issues-pr-raw/otype/shell?style=flat-square&logo=github&logoColor=white)](https://github.com/otype/shell/pulls)
[![License](https://img.shields.io/github/license/otype/shell?style=flat-square)](LICENSE)

[Quick start](#-quick-start) · [Configurations](#-configurations) · [How it loads](#-how-it-loads) · [The prompt](#-the-prompt) · [Writing your own](#-writing-your-own-configuration)

</div>

---

Shell is a configuration for [ZSH](https://www.zsh.org/) and [Oh My Zsh](https://ohmyz.sh/), focused on Linux. Instead of one big `.zshrc`, every tool gets its own small file. You switch on only what you use.

## ✨ Highlights

- 🔌 **Pluggable.** One file per tool or SDK in `zsh/env-available/`. Enable one with a symlink, the same way nginx and Apache do with `sites-available` and `sites-enabled`.
- 🛡️ **Safe by design.** Every configuration checks that its tool exists before touching `PATH` or defining aliases, so a file is a no-op on a machine without that tool.
- ⚡ **Fast.** An interactive shell starts in about 40 ms (measured with `zsh -i -c exit` on the author's laptop), and a script that starts `zsh` pays about 4 ms for the environment files.
- 📜 **Sensible history.** 100,000 entries, shared between sessions, with duplicates and blank lines removed.
- 🎨 **A custom prompt.** The `otype` theme shows user, host, kernel, directory, git status and the version of the project's language.
- 🧹 **Unique `PATH`.** De-duplicated once, centrally, with `typeset -U path`.

## 🚀 Quick start

### Requirements

| Needed | Why |
| --- | --- |
| [ZSH](https://www.zsh.org/) | the shell itself |
| `git` and `curl` | for the installer |
| [Oh My Zsh](https://ohmyz.sh/) | `zshrc` sources it. `install.sh` expects it to be there, `link.sh` installs it if missing |
| Vim (optional) | fallback `$EDITOR` when Emacs is not installed, target of the `vi` alias |

### Install

**Fresh machine:** clone and link in one step.

```console
$ curl -L https://raw.githubusercontent.com/otype/shell/main/bin/install.sh | bash
```

The installer clones the repo to `~/.shell` (override with `SHELL_ROOT`, pick a branch or tag with `SHELL_GIT_TAG`, use `USE_SSH=1` to clone over SSH). It refuses to run if that directory already exists.

**Existing checkout:** link it into `$HOME` with `link.sh`.

```console
$ ~/.shell/link.sh
```

It links `zshenv`, `zshrc`, `zsh` and `zprofile`, installs Oh My Zsh with a plain `git clone` if it is missing, and moves any existing real file out of the way to `<name>.bak-<timestamp>`.

Finally, make ZSH your login shell and open a new terminal:

```console
$ chsh -s "$(command -v zsh)"
```

## 🧩 Configurations

Everything in `zsh/env-available/` is **off by default**. To enable a configuration, link it into `env-enabled/` and restart your terminal:

```console
$ cd ~/.zsh/env-enabled && ln -nsf ../env-available/zshenv-docker
```

To disable it again, remove the link. Read a file before enabling it, some contain paths that are specific to one machine.

| Config | What it does |
| --- | --- |
| `zshenv-android` | `ANDROID_HOME` and the SDK tools on `PATH` |
| `zshenv-asdf` | loads [asdf](https://asdf-vm.com/) and its completions |
| `zshenv-awsume` | the `awsume` alias and its completion |
| `zshenv-cargo` | [Rust](https://www.rust-lang.org/): sources `~/.cargo/env` |
| `zshenv-claude` | plugin folder for Claude Code sessions (specific to the author) |
| `zshenv-docker` | [Docker](https://www.docker.com/) shortcuts (`di`, `dps`, `dl`, …) |
| `zshenv-elixir` | persistent shell history for IEx |
| `zshenv-emacs` | `$EDITOR` and `$VISUAL` via `emacsclient`, aliases `e`, `ec`, `se` |
| `zshenv-flutter` | Flutter on `PATH` |
| `zshenv-general` | Emacs key bindings, `^S` forward history search, small aliases (`h`, `sl`, `bc`, `vi`) |
| `zshenv-git` | `gpr`, `gpt`, `gprf` |
| `zshenv-goenv` | [goenv](https://github.com/syndbg/goenv) |
| `zshenv-gpg` | `GPG_TTY` set the zsh-safe way |
| `zshenv-hashicorp` | Packer, Terraform, Vault, … from `/opt/hashicorp/bin` |
| `zshenv-lua` | LuaRocks binaries on `PATH` |
| `zshenv-nvm` | loads [nvm](https://github.com/nvm-sh/nvm) and its completion |
| `zshenv-omarchy` | loads Omarchy's shell aliases just before the first prompt, after Oh My Zsh |
| `zshenv-pmd` | [PMD](https://pmd.github.io/) completion and `PATH` |
| `zshenv-podman` | [Podman](https://podman.io/) shortcuts (`pi`, `pps`, `pl`, …) |
| `zshenv-powerline` | starts `powerline-daemon` |
| `zshenv-pyenv` | [pyenv](https://github.com/pyenv/pyenv) |
| `zshenv-python` | the user-level Python bin directory (`~/.local/bin`) on `PATH` |
| `zshenv-rbenv` | [rbenv](https://github.com/rbenv/rbenv) |
| `zshenv-sdkman` | [SDKMAN!](https://sdkman.io/) |
| `zshenv-sshagent` | uses the systemd user `ssh-agent.socket` for `SSH_AUTH_SOCK` |
| `zshenv-tfenv` | [tfenv](https://github.com/tfutils/tfenv) |
| `zshenv-tilix` | aliases to dump and load the [Tilix](https://gnunn1.github.io/tilix-web/) configuration |
| `zshenv-virtualenv` | virtualenvwrapper (marked as possibly outdated in the file) |

> [!NOTE]
> The links in `env-enabled/` are ignored by git (see its `.gitignore`), so what you enable stays local to each machine.

## ⚙️ How it loads

ZSH reads its startup files in a fixed order. Each one has a single job here:

| Step | File | Read by | What it does |
| --- | --- | --- | --- |
| 1 | `zshenv` | every shell, scripts included | makes `PATH` unique, then sources every file in `zsh/env-enabled/` |
| 2 | `zprofile` | login shells | `KEYTIMEOUT`, `$PAGER`, a default `LANG`, adds `~/bin` and `~/.local/bin` to `PATH` |
| 3 | `zshrc` | interactive shells | history size and file, completion path, Oh My Zsh (theme and plugins), then `zsh/zshoptions` |

`zshrc` enables these Oh My Zsh plugins: `colored-man-pages`, `colorize`, `emacs`, `git`, `git-extras`, `gh`, `history` and `sudo`. `zsh-autosuggestions` and `zsh-syntax-highlighting` are not installed. Add more to the `plugins=(...)` line, a list is in the [Oh My Zsh plugin wiki](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins).

Because `zshenv` runs for every shell, it only exports variables and extends `PATH`. Aliases, key bindings and terminal settings are limited to interactive shells with `[[ -o interactive ]] || return 0`.

## 🎨 The prompt

The `otype` theme is set in `zshrc` with `ZSH_THEME="otype"`. It prints something like this (illustrative):

```text
(user@host<7.2.15>) :: ~/projects/api on  main 👍
|:.                                                             (Node:v24.1.0)
```

- **Left:** `user@host`, the kernel version, the current directory, then the git branch and status (dirty, untracked, ahead, …).
- **Right:** the version of a language, but only when the current directory has its marker file: `mix.exs` (Elixir), `pubspec.yaml` (Flutter), `go.mod` (Go), `pom.xml` (Java), `package.json` (Node), `setup.py` or `requirements.txt` (Python), `Gemfile` (Ruby), `Cargo.toml` (Rust).

The branch symbol needs a [Powerline-patched font](https://github.com/powerline/fonts), and the git status uses emoji.

## 🛠️ Writing your own configuration

1. Create `zsh/env-available/zshenv-<name>`.
2. **Guard everything.** Check with `command -v`, `[[ -d … ]]` or `(( $+commands[tool] ))` first, so the file does nothing when the tool is missing.
3. **Extend `PATH` with the array form**, `path+=("$dir")` or `path=("$dir" $path)`. `export PATH=…` bypasses the de-duplication from `zshenv`. Do not add per-file de-duplication.
4. **Keep aliases interactive-only.** Put `[[ -o interactive ]] || return 0` above them. Variables that scripts need (like `EDITOR`) go above that line.
5. Enable it with `ln -nsf ../env-available/zshenv-<name>` in `zsh/env-enabled/`.

There is no build or test tooling. Check a change by opening a new shell, or with `zsh -i -c exit` (no output means no errors).

## 📄 License

[MIT](LICENSE) © otype
