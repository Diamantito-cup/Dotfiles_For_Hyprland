#!/bin/bash

# --- Colores para la salida ---
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🚀 Iniciando automatización total de Dotfiles...${NC}"

# Asegurar que estamos en el directorio del repo
cd "$(dirname "$0")"

# 1. Instalación de dependencias (Pacman + AUR)
# Incluye todo lo de tu imagen: Hyprland, Kitty, FastFetch, ImageMagick, etc.
DEPENDENCIAS=(
    hyprland caelestia-shell-git kitty zsh oh-my-zsh-git 
    ttf-meslo-nerd-font-powerlevel10k fastfetch imagemagick 
    wofi cava zsh-syntax-highlighting zsh-autosuggestions hyprmod
)

echo -e "${GREEN}📦 Instalando paquetes y dependencias...${NC}"
if command -v yay &> /dev/null; then
    yay -S --needed "${DEPENDENCIAS[@]}"
else
    echo "⚠️ yay no encontrado. Instalando dependencias con pacman (las de AUR fallarán)..."
    sudo pacman -S --needed hyprland kitty zsh fastfetch imagemagick wofi cava
fi

# 2. Configuración de Carpetas (Enlace Simbólico vs Copia)
# Usar enlaces simbólicos (ln -s) permite que los cambios en .config se guarden en tu repo
echo -e "${GREEN}📂 Configurando carpetas en ~/.config...${NC}"
mkdir -p ~/.config

CARPETAS=("hypr" "kitty" "wofi" "cava" "fastfetch")

for carpeta in "${CARPETAS[@]}"; do
    if [ -d "$HOME/.config/$carpeta" ]; then
        echo "🔄 Respaldando config antigua de $carpeta..."
        mv "$HOME/.config/$carpeta" "$HOME/.config/${carpeta}_bak"
    fi
    echo "🔗 Creando enlace para $carpeta..."
    ln -s "$(pwd)/$carpeta" "$HOME/.config/$carpeta"
done

# 3. Configuración de Zsh
if [ -f ".zshrc" ]; then
    echo "🐚 Instalando .zshrc..."
    [ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc_bak
    ln -s "$(pwd)/.zshrc" ~/.zshrc
fi

# Cambiar shell si es necesario
[[ $SHELL != "/usr/bin/zsh" ]] && chsh -s $(which zsh)

echo -e "${BLUE}✅ Instalación completa. ¡Disfruta tu día libre cacharreando!${NC}"
