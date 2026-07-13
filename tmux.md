# Terminal and desktop shortcut reference

This setup has three intentionally separate control layers:

- **Windows / Komorebi** manages desktop windows and workspaces.
- **WezTerm** manages short-lived terminal tabs and their domains.
- **tmux** manages persistent sessions, windows, and panes inside a terminal context.

## WezTerm tabs

WezTerm tabs are independent terminal contexts. A tab may be a WSL shell, PowerShell, or an SSH connection; tmux state is separate from the tab that displays it.

| Shortcut | Action |
|---|---|
| `Ctrl+Shift+1..9` | Select WezTerm tab 1 through 9 |
| `Ctrl+Shift+H` | Select the previous WezTerm tab |
| `Ctrl+Shift+L` | Select the next WezTerm tab |

These bindings do not navigate tmux windows or panes. tmux owns navigation inside each context.

## Komorebi / Windows

Bare Windows taskbar shortcuts remain available:

- `Win+1..5` launches or focuses the corresponding pinned taskbar applications.
- `Win+Shift+1..5` keeps Windows' new-instance behavior.
- `Win+L` remains Windows lock and is not intercepted by whkd.

Use the explicit `Win+Alt` Komorebi command layer for desktop management:

| Shortcut | Action |
|---|---|
| `Win+Alt+1..6` | Focus main-monitor workspace 1 through 6 |
| `Win+Alt+Shift+1..6` | Move the current window to a main-monitor workspace |
| `Win+Alt+Ctrl+1..3` | Focus only presentation-monitor workspace 1 through 3 |
| `Win+Alt+Ctrl+Shift+1..3` | Move the current window to a presentation-monitor workspace |
| `Win+Alt+H/J/K/L` | Focus left/down/up/right |
| `Win+Alt+Shift+H/J/K/L` | Move left/down/up/right |
| `Win+Alt+Oem4/Oem6` | Cycle focus previous/next |
| `Win+Alt+Shift+Return` | Promote the focused window |
| `Win+Alt+Left/Down/Up/Right` | Stack left/down/up/right |
| `Win+Alt+Oem1` | Unstack |
| `Win+Alt+Shift+Oem4/Oem6` | Cycle stack previous/next |
| `Win+Alt+OemPlus/OemMinus` | Resize horizontally increase/decrease |
| `Win+Alt+Shift+OemPlus/OemMinus` | Resize vertically increase/decrease |
| `Win+Alt+T` | Toggle floating |
| `Win+Alt+F` | Toggle monocle |
| `Win+Alt+Shift+R` | Retile |
| `Win+Alt+P` | Toggle pause |
| `Win+Alt+X/Y` | Flip layout horizontally/vertically |
| `Win+Alt+Q/M/S` | Close, minimize, or toggle Komorebi lock |
| `Win+Alt+O` | Restart whkd |
| `Win+Alt+Shift+O` | Reload Komorebi configuration |
| `Win+Alt+I` | Toggle Komorebi shortcuts |

Presentation shortcuts target monitor index 1 explicitly. If that temporary monitor is absent, Komorebi reports an error or no-op rather than changing the main monitor's workspace.

## tmux sessions, windows, and panes

The tmux prefix is `Ctrl+Space`.

| Shortcut | Action |
|---|---|
| `Prefix+1..9` | Select tmux window 1 through 9 |
| `Prefix+H/L` | Select the previous/next tmux window |
| `Prefix+h/j/k/l` | Select the pane left/down/up/right |
| `Prefix+Ctrl+D` | Detach from the session |
| `Prefix+S` | Choose a session |
| `Prefix+R` | Reload tmux configuration and display a confirmation |
| `Prefix+z` | Toggle pane zoom |
| `Prefix+c` | Kill the current pane |
| `Prefix+Ctrl+C` | Create a new window |
| `Prefix+l` | Select the pane on the right |
| `Prefix+*` | Toggle synchronized panes |

`Prefix+H/L` belongs to tmux window navigation; `Prefix+h/j/k/l` belongs to pane navigation. WezTerm tabs and tmux windows are intentionally separate layers.

## Local and remote session workflow

After entering WSL or a remote host, start or reattach to the durable `main` session:

```sh
tmux new-session -A -s main
```

Detach with `Ctrl+Space` followed by `Ctrl+D`, then run the same command to reattach to the existing session and its windows. Run tmux on the host whose work you need to persist: local sessions persist on WSL, and remote sessions persist on the remote host. No SSH ControlMaster or automatic remote wrapping is configured.

If `$TMUX` is already set, do not run a nested session command; continue using the current session.

Continuum periodically saves tmux state and Resurrect captures pane contents on the host running tmux. WezTerm tabs themselves are not persistent sessions.
