# Allow local customizations in the ~/.shell_local_before file
if [ -f ~/.shell_local_before ]; then
    source ~/.shell_local_before
fi

# Allow local customizations in the ~/.zshrc_local_before file
if [ -f ~/.zshrc_local_before ]; then
    source ~/.zshrc_local_before
fi

# Load Antigen
source ~/.shell/antigen_init.sh

# Aliases
source ~/.shell/aliases.sh

# Hook direnv
eval "$(direnv hook zsh)"

# Add thefuck as alias
eval "$(thefuck --alias)"

# Allow local customizations in the ~/.shell_local_after file
if [ -f ~/.shell_local_after ]; then
    source ~/.shell_local_after
fi

# Allow local customizations in the ~/.zshrc_local_after file
if [ -f ~/.zshrc_local_after ]; then
    source ~/.zshrc_local_after
fi

# Add JBang to environment
alias j!=jbang
export PATH="$HOME/.jbang/bin:$HOME/.jbang/currentjdk/bin:$PATH"
export JAVA_HOME=$HOME/.jbang/currentjdk
