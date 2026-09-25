#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing apt dependencies"

sudo apt update
sudo apt install -y \
    nvim \
    less \
    alacritty \
    curl \
    wget \
    unzip \
    fzf \
    fontconfig \
    build-essential

echo "==> Ensuring Rust/Cargo exists"

if ! command -v cargo >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    . "$HOME/.cargo/env"
fi

echo "==> Installing Zellij"

if ! command -v zellij >/dev/null 2>&1; then
    cargo install --locked zellij
fi

echo "==> Installing zoxide"

if ! command -v zoxide >/dev/null 2>&1; then
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

echo "==> Installing Starship"

if ! command -v starship >/dev/null 2>&1; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

echo "==> Installing Atuin"

if ! command -v atuin >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
fi

echo "==> Installing JetBrains Mono Nerd Font"

FONT_DIR="$HOME/.local/share/fonts/JetBrainsMono"
mkdir -p "$FONT_DIR"

if ! fc-list | grep -qi "JetBrainsMono Nerd Font"; then
    TMP_DIR="$(mktemp -d)"

    wget -q \
        https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip \
        -O "$TMP_DIR/JetBrainsMono.zip"

    unzip -oq "$TMP_DIR/JetBrainsMono.zip" -d "$FONT_DIR"
    rm -rf "$TMP_DIR"

    fc-cache -f
fi

echo "==> Backing up existing configs"

timestamp="$(date +%Y%m%d-%H%M%S)"
BACKUP="$HOME/.config-backup-$timestamp"

mkdir -p "$BACKUP"

[ -f "$HOME/.bashrc" ] \
    && cp "$HOME/.bashrc" "$BACKUP/bashrc"

[ -f "$HOME/.config/alacritty/alacritty.toml" ] \
    && cp "$HOME/.config/alacritty/alacritty.toml" "$BACKUP/alacritty.toml"

[ -f "$HOME/.config/starship.toml" ] \
    && cp "$HOME/.config/starship.toml" "$BACKUP/starship.toml"

[ -f "$HOME/.config/zellij/config.kdl" ] \
    && cp "$HOME/.config/zellij/config.kdl" "$BACKUP/zellij-config.kdl"

[ -f "$HOME/.config/zellij/themes/gruvbox-orange.kdl" ] \
    && cp "$HOME/.config/zellij/themes/gruvbox-orange.kdl" \
        "$BACKUP/gruvbox-orange.kdl"

echo "==> Installing configs"

mkdir -p "$HOME/.config/alacritty"
mkdir -p "$HOME/.config/zellij/themes"

cp "$REPO_DIR/dotfiles/bashrc" \
    "$HOME/.bashrc"

cp "$REPO_DIR/dotfiles/alacritty/alacritty.toml" \
    "$HOME/.config/alacritty/alacritty.toml"

cp "$REPO_DIR/dotfiles/starship.toml" \
    "$HOME/.config/starship.toml"

cp "$REPO_DIR/dotfiles/zellij/config.kdl" \
    "$HOME/.config/zellij/config.kdl"

cp "$REPO_DIR/dotfiles/zellij/themes/gruvbox-orange.kdl" \
    "$HOME/.config/zellij/themes/gruvbox-orange.kdl"

echo "==> Checking Bash config"

bash -n "$HOME/.bashrc"

echo
echo "Done."
echo "Previous configs backed up to:"
echo "  $BACKUP"
echo
echo "Launch with:"
echo "  alacritty"
