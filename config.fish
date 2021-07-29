if status is-interactive
  # Commands to run in interactive sessions can go here
  set -gx GPG_TTY (tty)
end

if status is-login
  # Commands to run in login shells can go here
	source ~/.shell/aliases.sh
  fish_add_path ~/.bin/
  fish_add_path ~/.yarn/bin/
end

set fish_greeting
