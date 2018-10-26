#!/usr/local/bin/zsh

# Use gpg-agent as SSH agent (for smart keys)
#
#
ps x | grep -v "grep" | grep "gpg-agent.*--enable-ssh-support" > /dev/null
gpg_agent_ssh_enabled=$?
if [[ $gpg_agent_ssh_enabled -eq 1 ]];then
	gpgconf --kill gpg-agent
	gpg-agent --options ~/.gnupg/gpg-agent.conf --daemon
fi

export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
launchctl setenv SSH_AUTH_SOCK $SSH_AUTH_SOCK

GPG_TTY=$(tty)
export GPG_TTY
