#!/bin/bash
set -e

echo "🚀 Instalando dotfiles..."

# Asegurar que estamos en el repo
cd "$(dirname "$0")"

mkdir -p ~/.config

echo "📦 Instalando Hyprland..."
[ ! -d ~/.config/hypr ] && cp -r config/hypr ~/.config/ || echo "⚠️ hypr ya existe"

echo "📦 Instalando Kitty..."
[ ! -d ~/.config/kitty ] && cp -r config/kitty ~/.config/ || echo "⚠️ kitty ya existe"

echo "📦 Instalando Wofi..."
[ ! -d ~/.config/wofi ] && cp -r config/wofi ~/.config/ || echo "⚠️ wofi ya existe"

echo "📦 Instalando Cava..."
[ ! -d ~/.config/cava ] && cp -r config/cava ~/.config/ || echo "⚠️ cava ya existe"

if [ -f ".zshrc" ]; then
    echo "⚙️ Instalando .zshrc..."
    cp .zshrc ~/
fi

echo "✅ Instalación completa"
