set -l os (uname)
if test "$os" = Darwin
    eval (/opt/homebrew/bin/brew shellenv)
else if test "$os" = Linux
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

set -gx PATH "/home/clwaltke/.local/bin" $PATH

if status is-interactive
  # Commands to run in interactive sessions can go here
  set -gx GPG_TTY (tty)

  set -U PROJECT_PATHS ~/workspace
  set -gx DISPLAY :0

  # Shell plugins and completions
  navi widget fish | source
  direnv hook fish | source
  starship init fish | source
  kubectl completion fish | source

  # Add aliases
  source ~/.shell/aliases.sh
	# Add paths
  fish_add_path ~/.bin/
  fish_add_path ~/.yarn/bin/
  fish_add_path ~/.krew/bin
end

if status is-login
  # Commands to run in login shells can go here
end

set fish_greeting


set -gx FUNCTIONS_CORE_TOOLS_TELEMETRY_OPTOUT 1


# pnpm
set -gx PNPM_HOME "/home/clwaltke/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
