if status is-interactive
  # Commands to run in interactive sessions can go here
  set -gx GPG_TTY (tty)
	if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

	fundle plugin 'oh-my-fish/plugin-thefuck'
	fundle plugin 'danhper/fish-ssh-agent'

	fundle init
end

if status is-login
  # Commands to run in login shells can go here
	source ~/.shell/aliases.sh
  fish_add_path ~/.bin/
  fish_add_path ~/.yarn/bin/
end

set fish_greeting