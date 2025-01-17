# Clemens Wältken dotfiles

My dotfiles. A mashup of useful configurations and scripts I've collected over the years. Now using chezmoi to manage them.


## Prerequisites

Have git and fish installed.

```
sudo apt install git fish -y
```

## Installation

Run the following commands in your terminal.

```terminal
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply waeltken
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

After installing, open a new terminal window to see the effects.

Feel free to customize to match your preference.
