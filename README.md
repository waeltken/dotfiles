# Clemens Wältken's dotfiles

> A reproducible, keyboard-first development environment for macOS, Linux, Windows, and Windows + WSL—managed with [chezmoi](https://www.chezmoi.io/).

This repository turns a fresh machine into the environment I use every day: a capable shell, a durable terminal workflow, Neovim, and (even on Windows) a tiling desktop built around Komorebi.

It is intentionally opinionated. Chezmoi owns configuration, Homebrew owns macOS/Linux packages, Scoop owns Windows applications, WezTerm owns terminal tabs, tmux owns persistent sessions, and Komorebi owns desktop windows. Keeping those responsibilities separate makes the setup predictable and recoverable.

## At a glance

| Layer | Tools |
| --- | --- |
| Dotfile management | chezmoi |
| Shells | Fish, Zsh, Bash |
| Terminal | WezTerm + tmux |
| Editor | Neovim + LazyVim |
| Windows desktop | Komorebi + whkd + YASB |
| Packages | Homebrew on macOS/Linux, Scoop on Windows |
| Developer tooling | Git, GitHub CLI, Kubernetes, Terraform, Azure, Rust, Python, Node.js, and more |

The complete keyboard map lives in [`tmux.md`](tmux.md). The short version:

- **Komorebi** manages desktop windows and workspaces with `Win+Alt+…`.
- **WezTerm** manages terminal tabs with `Ctrl+Shift+…`.
- **tmux** manages persistent sessions, windows, and panes behind `Ctrl+Space`.

## Choose your setup

| Machine | macOS/Linux setup | Windows setup | Where chezmoi runs |
| --- | :---: | :---: | --- |
| macOS | Yes | No | Native macOS shell |
| Native Linux | Yes | No | Native Linux shell |
| Windows-native | No | Yes | Native PowerShell |
| Windows + WSL (Ubuntu) | Yes, inside WSL | Yes, in PowerShell | Once in each environment |

> [!IMPORTANT]
> **Windows + WSL is two cooperating installations, not one combined filesystem.** Run chezmoi inside WSL for Linux files and in native PowerShell for Windows files. Keep the two source checkouts synchronized through Git.

## Before you begin

The first apply is interactive. Chezmoi asks for:

- your full name and email for Git commits;
- an optional GPG signing key—leave it blank to disable signing;
- your GitHub username, used to populate `authorized_keys` from your public GitHub keys.

Do not run the first apply from a non-interactive script. You will also need network access, Git, curl, and a terminal.

After any successful initialization, this command prints the local source checkout:

```sh
chezmoi source-path
```

`README.md`, `LICENSE`, and `Brewfile` stay in that checkout rather than being copied into your home directory. Commands below therefore address `Brewfile` through `chezmoi source-path`.

---

## Install on macOS

Run everything in a native macOS terminal.

### 1. Install the prerequisites

```sh
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

The shell configuration in this repository expects Homebrew at `/opt/homebrew` on Apple Silicon. Keep the `shellenv` line in your startup file if the installer did not add it.

### 2. Bootstrap the dotfiles

```sh
command -v chezmoi >/dev/null || brew install chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply waeltken
```

Open a new shell, then install the declared package set:

```sh
brew bundle --file="$(chezmoi source-path)/Brewfile"
```

### 3. Add the font

Install **CaskaydiaCove NF** separately. WezTerm and YASB both refer to that exact font name; the repository does not include a font installer.

## Install on Linux

Run these commands in a native Linux shell. For Windows + WSL, run them inside the Ubuntu distribution.

### 1. Install the bootstrap packages

```sh
sudo apt update
sudo apt install -y build-essential curl file git fish
```

### 2. Install and initialize Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

Homebrew is the primary package manager for this setup. Apt only provides the small bootstrap set above.

### 3. Bootstrap the dotfiles and packages

```sh
command -v chezmoi >/dev/null || brew install chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply waeltken
```

Open a new shell, then install the repository's package set:

```sh
brew bundle --file="$(chezmoi source-path)/Brewfile"
```

The shell templates configure `nvm` and, in Fish, `fnm`. The repository's `.nvmrc` selects `lts/*`; load the configured version manager before diagnosing a missing `node` or `npm` command.

## Install on Windows

Run this section in **native PowerShell**, not in WSL.

### 1. Install Scoop and the desktop stack

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex
scoop bucket add extras
scoop install git chezmoi neovim wezterm komorebi whkd yasb oh-my-posh
```

There is no Scoop manifest in this repository, so the package list is explicit. The Homebrew `Brewfile` does not install Windows GUI applications.

### 2. Apply the Windows configuration

```powershell
chezmoi init --apply waeltken
```

Running chezmoi natively ensures that Windows-only files—including `AppData\Roaming\topgrade.toml`—land in the profile used by Windows applications.

Set Komorebi's configuration directory, then open a new PowerShell session so child processes inherit it:

```powershell
[Environment]::SetEnvironmentVariable(
    'KOMOREBI_CONFIG_HOME',
    (Join-Path $HOME '.config\komorebi'),
    'User'
)
```

### 3. Start the desktop

```powershell
komorebic start --whkd
yasb
```

Configure your preferred Windows startup mechanism manually; this repository does not create a startup task or service.

### Windows targets

| Source | Native target |
| --- | --- |
| `dot_config/komorebi/` | `%USERPROFILE%\.config\komorebi\` |
| `dot_config/yasb/` | `%USERPROFILE%\.config\yasb\` |
| `dot_config/wezterm/wezterm.lua` | `%USERPROFILE%\.config\wezterm\wezterm.lua` |
| `dot_config/whkdrc` | `%USERPROFILE%\.config\whkdrc` |
| `AppData/Roaming/topgrade.toml` | `%USERPROFILE%\AppData\Roaming\topgrade.toml` |

The whkd configuration uses PowerShell syntax. WezTerm's Windows branch opens the `WSL:Ubuntu` domain by default and adds PowerShell with oh-my-posh to its launch menu.

## Install on Windows + WSL

This is the recommended Windows setup and consists of two clean, independent applies:

1. **Inside Ubuntu:** complete [Install on Linux](#install-on-linux), including `brew bundle` and the Linux checks.
2. **In native PowerShell:** complete [Install on Windows](#install-on-windows), including Scoop, the Komorebi environment variable, and the desktop stack.

The result is deliberately split:

```text
WSL home                                      Windows profile
/home/<user>/                                 C:\Users\<user>\
├── .config/fish                              ├── .config/komorebi
├── .config/nvim                              ├── .config/whkdrc
├── .config/tmux                              ├── .config/yasb
└── Linux tools and shell state               └── .config/wezterm
        ▲                                              ▲
        │ chezmoi in Ubuntu                            │ chezmoi in PowerShell
        └──────── separate Git-synced checkouts ───────┘
```

Do not point one installation at the other environment's home directory. Each first apply has its own chezmoi data and prompts.

WezTerm expects the WSL distribution to be named `Ubuntu`. If yours has another name, update `config.default_domain` in `dot_config/wezterm/wezterm.lua` before launching WezTerm.

<details>
<summary><strong>Fallback: copy Windows files from WSL</strong></summary>

Use this only when you deliberately do **not** run chezmoi in native Windows. A WSL apply writes to `/home/<user>`; Windows programs do not read configuration from there.

Run in WSL:

```bash
WIN_HOME="$(wslpath "$(cmd.exe /c echo %USERPROFILE% | tr -d '\r')")"
test -n "$WIN_HOME" || { echo "Could not resolve the Windows profile" >&2; exit 1; }
mkdir -p "$WIN_HOME/.config/komorebi" \
         "$WIN_HOME/.config/yasb" \
         "$WIN_HOME/.config/wezterm"
cp -a "$HOME/.config/komorebi/." "$WIN_HOME/.config/komorebi/"
cp -a "$HOME/.config/yasb/." "$WIN_HOME/.config/yasb/"
cp -a "$HOME/.config/wezterm/." "$WIN_HOME/.config/wezterm/"
cp "$HOME/.config/whkdrc" "$WIN_HOME/.config/whkdrc"
```

Do not guess a `/mnt/c/Users/...` path. Resolve the actual Windows profile, then reload the native programs as shown below.

</details>

---

## First run

### Neovim

Launch `nvim` once. The configuration bootstraps `folke/lazy.nvim`, then LazyVim installs the checked-in plugin set. Node and npm must be available because the CopilotChat configuration installs `mcp-hub` with npm.

After plugin installation and any required Copilot authentication:

```sh
nvim --headless '+checkhealth' +qa
```

`dot_config/nvim/create_lazy-lock.json` is a create-only lock snapshot. Chezmoi materializes `lazy-lock.json` when appropriate; the generated file is intentionally not tracked here.

### tmux

Chezmoi fetches [TPM](https://github.com/tmux-plugins/tpm) into `~/.tmux/plugins/tpm` through `.chezmoiexternal.toml`.

```sh
test -d ~/.tmux/plugins/tpm
tmux
```

Inside tmux, press `Ctrl+Space`, then `I`, to install plugins. Start or reattach to the durable default session with:

```sh
tmux new-session -A -s main
```

See [`tmux.md`](tmux.md) for the full terminal and desktop shortcut model.

### Fish

The non-Windows post-update hook normally installs or updates Fisher plugins. If the first shell has not loaded them, run:

```sh
fish -c "curl -sL https://git.io/fisher | source && fisher update"
```

The declared plugin set lives in `dot_config/fish/fish_plugins`.

### Accounts and local secrets

- Import or create the selected GPG key before reapplying with commit signing enabled.
- Authenticate GitHub and Copilot separately; chezmoi does not perform those interactive sign-ins.
- `.pi/agent/auth.json` and `.pi/agent/sessions/` are intentionally excluded from version control.
- YASB's weather widget reads its API key and location from the environment. Use the variable names documented by the installed YASB version; do not store secrets in `config.yaml`.
- The templated Puppeteer path expects Microsoft Edge on Windows, macOS, and WSL. Native Linux intentionally has no configured Edge path.

## Day-to-day use

Preview before applying:

```sh
chezmoi diff
chezmoi apply --dry-run --verbose
```

Apply local source changes:

```sh
chezmoi apply
```

Pull the latest repository revision and apply it:

```sh
chezmoi update
```

### Reload Windows programs

After a native Windows apply—or after using the WSL copy fallback—run in PowerShell:

```powershell
taskkill /f /im whkd.exe
Start-Process whkd -WindowStyle hidden
komorebic reload-configuration
yasb
```

`Win+Alt+O` restarts whkd; `Win+Alt+Shift+O` reloads Komorebi.

## Verify the installation

### Every platform

```sh
chezmoi verify
chezmoi source-path
tmux -V
fish --version
```

### macOS and Linux

```sh
brew bundle check --file="$(chezmoi source-path)/Brewfile"
nvim --headless '+checkhealth' +qa
git --version
rg --version
node --version
npm --version
gpg --version
```

`brew bundle check` should succeed, and Neovim's health check should exit cleanly after first-run plugin installation.

### Windows

```powershell
Test-Path "$HOME\.config\komorebi\komorebi.json"
Test-Path "$HOME\.config\komorebi\applications.json"
Test-Path "$HOME\.config\yasb\config.yaml"
Test-Path "$HOME\.config\wezterm\wezterm.lua"
Test-Path "$HOME\.config\whkdrc"
Get-Item Env:KOMOREBI_CONFIG_HOME
komorebic state
Get-Process whkd
```

All five path checks should return `True`; the environment variable should point to `.config\komorebi`; Komorebi should report a running manager; and whkd should be running. Launch YASB and WezTerm to verify the bar, font, and `WSL:Ubuntu` domain visually.

For Windows + WSL, run both the Linux checks inside Ubuntu and the Windows checks in PowerShell. A successful check in one home says nothing about the other.

## Repository map

```text
.
├── dot_config/                  # Application configuration
│   ├── fish/                    # Shell and Fisher plugins
│   ├── komorebi/                # Windows tiling window manager
│   ├── nvim/                    # LazyVim-based Neovim setup
│   ├── tmux/                    # Persistent terminal sessions
│   ├── wezterm/                 # Cross-platform terminal
│   ├── whkdrc                   # Windows hotkeys
│   └── yasb/                    # Windows status bar
├── dot_bin/                     # Personal executable scripts
├── dot_shell/                   # Shared shell helpers
├── dot_ssh/                     # SSH templates
├── AppData/Roaming/             # Windows-only application data
├── Brewfile                     # macOS/Linux package manifest
├── .chezmoi.toml.tmpl           # First-run prompts and data
├── .chezmoiignore               # Platform and secret exclusions
└── .chezmoiexternal.toml        # External assets such as TPM
```

## Intentional exceptions

A few things are deliberately manual:

- **No symlinks.** Chezmoi renders and copies files; the repository contains no `link_*` sources.
- **No automatic Windows startup.** Start Komorebi/whkd and YASB through the Windows mechanism you prefer.
- **No automatic registry import.** `windows_reg_files/set_timezone_to_utc.reg` is optional and requires an elevated PowerShell. `disable_lock.reg` is legacy and must not be imported—`Win+L` remains the native Windows lock shortcut.
- **No committed credentials.** Pi sessions, authentication files, GPG material, GitHub auth, and Copilot auth remain local.
- **Optional Watchman automation.** `dot_bin/executable_chezmoi-watchman` is only for users who explicitly want source changes to trigger `chezmoi apply --force`.

If you intentionally apply the UTC registry setting, import it from an elevated native PowerShell:

```powershell
reg.exe import (Join-Path (chezmoi source-path) 'windows_reg_files\set_timezone_to_utc.reg')
```

Log off or reboot if Windows does not pick up the change immediately.

## License

See [`LICENSE`](LICENSE).
