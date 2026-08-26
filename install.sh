#!/usr/bin/env bash

set -euo pipefail

# 🎨 PALETA DE COLORES ANSI
BOLD="\e[1m"
VERDE="\e[32m"
AZUL="\e[34m"
CYAN="\e[36m"
AMARILLO="\e[33m"
ROJO="\e[31m"
MAGENTA="\e[35m"
RESET="\e[0m"

# 📁 RUTA BASE Y BACKUPS
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config_hypr_bak_$(date +%Y%m%d_%H%M%S)"

# ==========================================
# 🖼️ BANNERS Y SECCIONES VISUALES
# ==========================================
imprimir_banner() {
  clear
  echo -e "${CYAN}${BOLD}"
  cat <<"EOF"
  ██╗  ██╗██╗   ██╗██████╗ ██████╗ ██╗      █████╗ ███╗   ██╗██████╗ 
  ██║  ██║╚██╗ ██╔╝██╔══██╗██║  ██║██║     ██╔══██╗████╗  ██║██╔══██╗
  ███████║ ╚████╔╝ ██████╔╝██████║ ██║     ███████║██╔██╗ ██║██║  ██║
  ██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══██║██║     ██╔══██║██║╚██╗██║██║  ██║
  ██║  ██║   ██║   ██║     ██║  ██║███████╗██║  ██║██║ ╚████║██████╔╝
  ╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ 
EOF
  echo -e "${MAGENTA}       --- ARCH LINUX HYPRLAND DOTFILES INSTALLER ---${RESET}\n"
}

imprimir_seccion() {
  echo -e "\n${BOLD}${AZUL}───> $1${RESET}"
}

# ==========================================
# 📦 GESTOR DE DEPENDENCIAS (pacman/yay)
# ==========================================
verificar_aur_helper() {
  if ! command -v yay &>/dev/null; then
    echo -e "${AMARILLO}⚠️ 'yay' no está instalado. Instalando yay (AUR helper)...${RESET}"
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    (cd /tmp/yay && makepkg -si --noconfirm)
    rm -rf /tmp/yay
  fi
}

instalar_paquetes() {
  imprimir_seccion "Gestión de Dependencias y Software Extra"
  verificar_aur_helper

  # Lista base para el entorno Hyprland + Lua
  local paquetes_base=(hyprland kitty neovim fastfetch)

  echo -e "${CYAN}Instalando entorno base (Hyprland + herramientas)...${RESET}"
  sudo pacman -S "${paquetes_base[@]}"

  # Menú interactivo para software opcional
  echo -e "\n${AMARILLO}¿Deseas seleccionar software opcional para instalar?${RESET}"

  declare -A OPCIONES=(
    ["1"]="vscodium-bin"
    ["2"]="spotify"
    ["3"]="spicetify-cli"
    ["4"]="zen-browser-bin"
    ["5"]="midnight-shell-git"
    ["6"]="midnight-shell-cli-git"
  )

  for key in "${!OPCIONES[@]}"; do
    pkg=$(echo "${OPCIONES[$key]}" | cut -d: -f1)
    desc=$(echo "${OPCIONES[$key]}" | cut -d: -f2)

    read -p "$(echo -e "${CYAN}¿Instalar $desc ($pkg)? [s/N]: ${RESET}")" resp
    if [[ "$resp" =~ ^[Ss]$ ]]; then
      echo -e "${VERDE}Instalando $pkg...${RESET}"
      yay -S --needed --noconfirm "$pkg"
    fi
  done
}

# ==========================================
# 💾 GESTIÓN DE BACKUPS
# ==========================================
gestionar_backup() {
  imprimir_seccion "Copia de Seguridad"

  read -p "$(echo -e "${AMARILLO}¿Deseas crear una copia de seguridad de ~/.config/hypr antes de instalar? [S/n]: ${RESET}")" resp
  if [[ "$resp" =~ ^[Nn]$ ]]; then
    echo -e "${ROJO}Omitiendo respaldo...${RESET}"
    return
  fi

  echo -e "${VERDE}💾 Creando copia de seguridad en: $BACKUP_DIR${RESET}"
  mkdir -p "$BACKUP_DIR"

  if [ -d "$CONFIG_DIR/hypr" ]; then
    cp -r "$CONFIG_DIR/hypr" "$BACKUP_DIR/"
  fi
  echo -e "${VERDE}✅ Respaldos creados exitosamente.${RESET}"
}

# ==========================================
# ⚙️ INSTALACIÓN DE DOTFILES Y CONFIGS
# ==========================================
instalar_dotfiles() {
  imprimir_seccion "Despliegue de Configuraciones (Lua)"

  # Limpieza del hyprland.conf clásico para dar prioridad a hyprland.lua
  if [ -f "$CONFIG_DIR/hypr/hyprland.conf" ]; then
    echo -e "${ROJO}🗑️ Eliminando hyprland.conf antiguo para habilitar la carga de Lua...${RESET}"
    rm -f "$CONFIG_DIR/hypr/hyprland.conf"
  fi

  mkdir -p "$CONFIG_DIR/hypr"

  if [ -f "hypr/hyprland.lua" ]; then
    cp "hypr/hyprland.lua" "$CONFIG_DIR/hypr/"
    echo -e "  ↳ ${VERDE}Copiado:${RESET} hyprland.lua -> $CONFIG_DIR/hypr/"
  fi

  if [ -d "caelestia" ]; then
    mkdir -p "$CONFIG_DIR/caelestia"
    cp -r caelestia/* "$CONFIG_DIR/caelestia/"
    echo -e "  ↳ ${VERDE}Copiado directorio:${RESET} caelestia -> $CONFIG_DIR/"
  fi
}

# ==========================================
# 🚀 FLUJO PRINCIPAL DE EJECUCIÓN
# ==========================================
main() {
  imprimir_banner

  echo -e "${BOLD}Bienvenido al configurador del entorno Hyprland (dev branch).${RESET}"
  echo -e "Este script instalará las dependencias y aplicará los dotfiles basados en Lua.\n"

  read -p "$(echo -e "${CYAN}¿Deseas iniciar el proceso de instalación? [S/n]: ${RESET}")" inicio
  if [[ "$inicio" =~ ^[Nn]$ ]]; then
    echo -e "${ROJO}Instalación cancelada.${RESET}"
    exit 0
  fi

  gestionar_backup
  instalar_paquetes
  instalar_dotfiles

  imprimir_seccion "¡Instalación Finalizada!"
  echo -e "${VERDE}${BOLD}✨ ¡Entorno Hyprland configurado correctamente!${RESET}"
  echo -e "${AMARILLO}Puedes revisar tus backups en: $BACKUP_DIR${RESET}\n"
}

main "$@"
