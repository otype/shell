# vim:ft=zsh ts=2 sw=2 sts=2

# More symbols to choose from:
# ☀ ✹ ☄ ♆ ♀ ♁ ♐ ♇ ♈ ♉ ♚ ♛ ♜ ♝ ♞ ♟ ♠ ♣ ⚢ ⚲ ⚳ ⚴ ⚥ ⚤ ⚦ ⚒ ⚑ ⚐ ♺ ♻ ♼ ☰ ☱ ☲ ☳ ☴ ☵ ☶ ☷
# ✡ ✔ ✖ ✚ ✱ ✤ ✦ ❤ ➜ ➟ ➼ ✂ ✎ ✐ ⨀ ⨁ ⨂ ⨍ ⨎ ⨏ ⨷ ⩚ ⩛ ⩡ ⩱ ⩲ ⩵  ⩶ y⨠
# ⬅ ⬆ ⬇ ⬈ ⬉ ⬊ ⬋ ⬒ ⬓ ⬔ ⬕ ⬖ ⬗ ⬘ ⬙ ⬟  ⬤ 〒 ǀ ǁ ǂ ĭ Ť Ŧ

function elixir_version() {
  if which elixir &> /dev/null && [[ -f "mix.exs" ]]; then
    echo "(Elixir:$(elixir -v 2>&1 | grep "Elixir" | awk -F' ' '{print $2}'))"
  fi
}

function flutter_version() {
  if which flutter &> /dev/null && [[ -f "pubspec.yaml" ]]; then
    echo "(Flutter:$(flutter --version | grep "^Flutter" | awk -F' ' '{print $2}'))"
  fi
}

function goenv_version() {
	if which goenv &> /dev/null && [[ -f "go.mod" ]]; then
    echo "(Go:$(goenv version 2>/dev/null | awk '{print $1}'))"
  fi
}

function java_version() {
  if which java &> /dev/null && [[ -f "pom.xml" ]]; then
    echo "(Java:$(java -version 2>&1|awk -F\" '/version/ {print $2}'))"
  fi
}

function node_version() {
  if which node &> /dev/null && [[ -f "package.json" ]]; then
    echo "(Node:$(node --version 2>/dev/null | awk '{print $1}'))"
  fi
}

function pyenv_version() {
  if which pyenv &> /dev/null && { [[ -f "setup.py" ]] || [[ -f "requirements.txt" ]]; }; then
    echo "(Python:$(pyenv version 2>/dev/null | awk '{print $1}'))"
  fi
}

function rbenv_version() {
  if which rbenv &> /dev/null && [[ -f "Gemfile" ]]; then
    echo "(Ruby:$(rbenv version 2>/dev/null | awk '{print $1}'))"
  fi
}

function rustc_version() {
  if which rustc &> /dev/null && [[ -f "Cargo.toml" ]]; then
    echo "(Rust:$(rustc --version 2>&1 | awk -F' ' '{print $2}'))"
  fi
}


function kernel_version() {
  uname -r | cut -d"-" -f1
}

# Must use Powerline font, for \uE0A0 to render.
ZSH_THEME_GIT_PROMPT_PREFIX="on %{$fg[yellow]%}\uE0A0"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} 👀 "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[blue]%}❓"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[yellow]%} 👍  "
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✳️"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}⚠️"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}❌"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}✏️"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}⚙️"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[yellow]%}🔆"

# Left side: User@host + directory information
local user_host='(%{$fg_bold[green]%}%n@%m%{$fg_bold[white]%}<${$(kernel_version)}>%{$reset_color%})'
local current_dir='%{$fg_bold[blue]%}${PWD/#$HOME/~}%{$reset_color%}'

# Git status info
local git_info='$(git_prompt_info)%{$reset_color%}$(git_prompt_status)%{$reset_color%}$(git_prompt_ahead)%{$reset_color%}'

# Right side: All detected programming languages
local elixir_info='%{$fg_bold[red]%}${$(elixir_version)/#system/}%{$reset_color%}'
local flutter_info='%{$fg_bold[blue]%}${$(flutter_version)/#system/}%{$reset_color%}'
local goenv_info='%{$fg_bold[blue]%}${$(goenv_version)/#system/}%{$reset_color%}'
local java_info='%{$fg_bold[white]%}${$(java_version)/#system/}%{$reset_color%}'
local node_info='%{$fg_bold[yellow]%}${$(node_version)/#system/}%{$reset_color%}'
local pyenv_info='%{$fg_bold[magenta]%}${$(pyenv_version)/#system/}%{$reset_color%}'
local rbenv_info='%{$fg_bold[red]%}${$(rbenv_version)/#system/}%{$reset_color%}'
local rust_info='%{$fg_bold[red]%}${$(rustc_version)/#system/}%{$reset_color%}'

PROMPT="
${user_host} :: ${current_dir} ${git_info}
|:. "

RPROMPT="${elixir_info}${flutter_info}${goenv_info}${java_info}${node_info}${pyenv_info}${rbenv_info}${rust_info}"
