if status is-interactive
  # Commands to run in interactive sessions can go here
end

if status is-login
  # Commands to run in login shells can go here
  fish_add_path ~/.bin/
  fish_add_path ~/.yarn/bin/
  set -gx GPG_TTY (tty)
end

set fish_greeting
