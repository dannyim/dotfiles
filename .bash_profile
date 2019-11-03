# Start ssh-agent
SSH_ENV="$HOME/.ssh/env"

function start_agent {
	echo "Initializing new SSH agent..."
	/usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
	echo succeeded
	chmod 600 "${SSH_ENV}"
	. "${SSH_ENV}" > /dev/null
	/usr/bin/ssh-add;
}

if [ -f "${SSH_ENV}" ]; then
	. "${SSH_ENV}" > /dev/null
	ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
		start_agent;
	}
else 
	start_agent;
fi

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
eval "$(pyenv init -)"
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
export PATH=$PATH:~/.local/bin
export PATH="/usr/local/opt/libpq/bin:$PATH"
if [ -e /Users/anymind/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/anymind/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
