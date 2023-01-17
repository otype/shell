#!/usr/bin/env zsh

# ZPROFILE
#
# If configured it will use gpg-agent as SSH agent (for smart keys)
#
if [[ -f "$HOME/.gnupg/gpg-agent.conf" ]] && [[ -f "$HOME/.enable_gpg_for_ssh" ]]; then
    cat $HOME/.gnupg/gpg-agent.conf | grep enable-ssh-support > /dev/null
    ssh_support_enabled=$?

    if [[ $ssh_support_enabled -eq 0 ]]; then
	# Start or re-use a gpg-agent.
	gpgconf --launch gpg-agent
        # gpg-agent --options ~/.gnupg/gpg-agent.conf --daemon

	# Ensure that GPG Agent is used as the SSH agent
	# set -e SSH_AUTH_SOCK
	# set -U -x SSH_AUTH_SOCK ~/.gnupg/S.gpg-agent.ssh

        export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
        launchctl setenv SSH_AUTH_SOCK $SSH_AUTH_SOCK

	GPG_TTY=$(tty)
	export GPG_TTY
    fi
fi
