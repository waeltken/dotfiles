if status is-interactive
  # Commands to run in interactive sessions can go here
  set -gx GPG_TTY (tty)
  set -gx FUNCTIONS_CORE_TOOLS_TELEMETRY_OPTOUT 0
  if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

  fundle plugin 'oh-my-fish/plugin-thefuck'
  #fundle plugin 'oh-my-fish/plugin-pj'
  #fundle plugin 'jethrokuan/z'
  fundle plugin 'danhper/fish-ssh-agent'
  fundle plugin 'oh-my-fish/plugin-linuxbrew'
  #fundle plugin 'jorgebucaran/nvm.fish'
  fundle plugin 'FabioAntunes/fish-nvm'
  fundle plugin 'edc/bass'

  set -U PROJECT_PATHS ~/workspace

  fundle init
end

if status is-login
  # Commands to run in login shells can go here
  source ~/.shell/aliases.sh
  fish_add_path ~/.bin/
  fish_add_path ~/.yarn/bin/
  fish_add_path ~/.krew/bin
end

set fish_greeting

direnv hook fish | source
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)

starship init fish | source
kubectl completion fish | source

# pnpm
set -gx PNPM_HOME "/home/clwaltke/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
