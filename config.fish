if status is-interactive
  # Commands to run in interactive sessions can go here
  set -gx GPG_TTY (tty)
  set -gx FUNCTIONS_CORE_TOOLS_TELEMETRY_OPTOUT 0
  if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

  set -U PROJECT_PATHS ~/workspace
end

if status is-login
  # Commands to run in login shells can go here
  source ~/.shell/aliases.sh
  fish_add_path ~/.bin/
  fish_add_path ~/.yarn/bin/
  fish_add_path ~/.krew/bin
end

set fish_greeting

set -l os (uname)
if test "$os" = Darwin
    eval (/opt/homebrew/bin/brew shellenv)
else if test "$os" = Linux
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

direnv hook fish | source

starship init fish | source
kubectl completion fish | source

set -gx FUNCTIONS_CORE_TOOLS_TELEMETRY_OPTOUT 1

# pnpm
set -gx PNPM_HOME "/home/clwaltke/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
