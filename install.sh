#!/bin/bash

# --- Colores ---
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${BLUE}🚀 Configurando entorno de desarrollo para angelito...${NC}"

# 1. Habilitar yay (AUR Helper)
if ! command -v yay &> /dev/null; then
    echo -e "${GREEN}📦 yay no encontrado. Instalando desde el AUR...${NC}"
    sudo pacman -S --needed base-devel git
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
else
    echo -e "${BLUE}✅ yay ya está instalado.${NC}"
fi

# 2. Dependencias (Ahora sí, usando yay)
# Incluimos ImageMagick para el logo de Fastfetch y p10k
DEPENDENCIAS=(
    hyprland kitty zsh fastfetch imagemagick wofi cava 
    ttf-meslo-nerd-font-powerlevel10k 
    zsh-syntax-highlighting zsh-autosuggestions
    caelestia-shell- hyprmod
)

echo -e "${GREEN}📥 Instalando dependencias del sistema y Zsh...${NC}"
yay -S --needed --noconfirm "${DEPENDENCIAS[@]}"

# 3. Configuración de Dotfiles (Enlaces simbólicos)
# Esto vincula tu .zshrc sin errores de Powerlevel10k
echo -e "${GREEN}🔗 Creando enlaces simbólicos...${NC}"
CARPETAS=("hypr" "kitty" "wofi" "cava" "fastfetch")
for carpeta in "${CARPETAS[@]}"; do
    [ -d "$HOME/.config/$carpeta" ] && mv "$HOME/.config/$carpeta" "$HOME/.config/${carpeta}_bak"
    ln -s "$(pwd)/$carpeta" "$HOME/.config/$carpeta"
done

# Vincular .zshrc corregido
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc_bak
ln -s "$(pwd)/.zshrc" ~/.zshrc

echo -e "${BLUE}✅ ¡Todo listo! yay habilitado y sistema configurado.${NC}"
