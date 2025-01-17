#!/bin/bash
# Check if on arm64
{{ if eq .chezmoi.osRelease.id "debian" -}}
wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim
nvim --version
{{ end }}