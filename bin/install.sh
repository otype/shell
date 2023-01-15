#!/usr/bin/env bash

set -e
[ -n "$PYENV_DEBUG" ] && set -x

if [ -z "$SHELL_ROOT" ]; then
  export SHELL_ROOT="${HOME}/.shell2"
fi

colorize() {
  if [ -t 1 ]; then printf "\e[%sm%s\e[m" "$1" "$2"
  else echo -n "$2"
  fi
}

# Checks for `.shell` file, and suggests to remove it for installing
if [ -d "${SHELL_ROOT}" ]; then
  { echo
    colorize 1 "WARNING"
    echo ": Can not proceed with installation. Kindly remove the '${SHELL_ROOT}' directory first."
    echo
  } >&2
    exit 1
fi

failed_checkout() {
  echo "Failed to git clone $1"
  exit -1
}

checkout() {
  [ -d "$2" ] || git -c advice.detachedHead=0 clone --branch "$3" --depth 1 "$1" "$2" || failed_checkout "$1"
}

if ! command -v git 1>/dev/null 2>&1; then
  echo "shell: Git is not installed, can't continue." >&2
  exit 1
fi

# Check ssh authentication if USE_SSH is present
if [ -n "${USE_SSH}" ]; then
  if ! command -v ssh 1>/dev/null 2>&1; then
    echo "shell: configuration USE_SSH found but ssh is not installed, can't continue." >&2
    exit 1
  fi

  # `ssh -T git@github.com' returns 1 on success
  # See https://docs.github.com/en/authentication/connecting-to-github-with-ssh/testing-your-ssh-connection
  ssh -T git@github.com 1>/dev/null 2>&1 || EXIT_CODE=$?
  if [[ ${EXIT_CODE} != 1 ]]; then
      echo "shell: github ssh authentication failed."
      echo
      echo "In order to use the ssh connection option, you need to have an ssh key set up."
      echo "Please generate an ssh key by using ssh-keygen, or follow the instructions at the following URL for more information:"
      echo
      echo "> https://docs.github.com/en/repositories/creating-and-managing-repositories/troubleshooting-cloning-errors#check-your-ssh-access"
      echo
      echo "Once you have an ssh key set up, try running the command again."
    exit 1
  fi
fi

if [ -n "${USE_SSH}" ]; then
  GITHUB="git@github.com:"
else
  GITHUB="https://github.com/"
fi

checkout "${GITHUB}otype/shell.git"            "${SHELL_ROOT}"                           "${SHELL_GIT_TAG:-main}"

# Link all ZSH configs
echo "shell: Symlink all ZSH configurations"
ln -nsf ${SHELL_ROOT}/zshenv ~/.zshenv2
ln -nsf ${SHELL_ROOT}/zshrc ~/.zshrc2
ln -nsf ${SHELL_ROOT}/zsh ~/.zsh2
ln -nsf ${SHELL_ROOT}/zprofile ~/.zprofile2

echo "shell: Installation finished."
echo ""
colorize 1 "Set your default shell to ZSH and restart your shell to activate the configurations"
