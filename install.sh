#!/usr/bin/env bash

# Salir inmediatamente si un comando falla
set -e

# Colores para la terminal
VERDE="\e[0;32m"
AMARILLO="\e[0;33m"
ROJO="\e[0;31m"
RESET="\e[0m"

echo -e "${VERDE}🚀 Iniciando instalación del entorno de pruebas (Lua)...${RESET}"

# Definir directorios base
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config_hypr_bak_$(date +%Y%m%d_%H%M%S)"

# Lista de carpetas/archivos a instalar en ~/.config
COMPONENTES=("hyprland.lua" "cava" "wofi" "caelestia")

# 1. Crear copia de seguridad si ya existen configuraciones previas
echo -e "${AMARILLO}📦 Verificando configuraciones existentes para respaldo...${RESET}"
NECESITA_BACKUP=false

for comp in "${COMPONENTES[@]}"; do
    if [ -e "$CONFIG_DIR/$comp" ] || [ "$comp" == "hyprland.lua" -a -e "$CONFIG_DIR/hypr/hyprland.conf" ]; then
        NECESITA_BACKUP=true
    fi
done

if [ "$NECESITA_BACKUP" = true ]; then
    mkdir -p "$BACKUP_DIR/hypr"
    echo -e "${AMARILLO}💾 Respaldando configuraciones antiguas en: $BACKUP_DIR${RESET}"
    
    # Respaldar la carpeta completa de Hyprland antigua si existe
    if [ -d "$CONFIG_DIR/hypr" ]; then
        cp -r "$CONFIG_DIR/hypr/"* "$BACKUP_DIR/hypr/" 2>/dev/null || true
    fi
    
    # Respaldar los otros componentes
    for comp in "cava" "wofi" "caelestia"; do
        if [ -d "$CONFIG_DIR/$comp" ]; then
            mv "$CONFIG_DIR/$comp" "$BACKUP_DIR/"
        fi
    done
fi

# 2. Limpieza crítica de Hyprland viejo (.conf)
# Si hyprland.conf se queda en ~/.config/hypr/, el sistema podría ignorar tu archivo .lua
if [ -f "$CONFIG_DIR/hypr/hyprland.conf" ]; then
    echo -e "${ROJO}🗑️ Removiendo hyprland.conf antiguo para priorizar la carga de Lua...${RESET}"
    rm -f "$CONFIG_DIR/hypr/hyprland.conf"
fi

# 3. Instalación de los nuevos archivos de la rama dev
echo -e "${VERDE}⚙️ Instalando nuevos archivos de configuración...${RESET}"

# Instalar Hyprland Lua
mkdir -p "$CONFIG_DIR/hypr"
cp "$SCRIPT_DIR/hyprland.lua" "$CONFIG_DIR/hypr/hyprland.lua"
echo -e "  ↳ ${VERDE}Instalado:${RESET} hyprland.lua -> $CONFIG_DIR/hypr/"

# Instalar el resto de aplicaciones
for comp in "cava" "wofi" "caelestia"; do
    if [ -d "$SCRIPT_DIR/$comp" ]; then
        cp -r "$SCRIPT_DIR/$comp" "$CONFIG_DIR/"
        echo -e "  ↳ ${VERDE}Instalada la carpeta:${RESET} $comp -> $CONFIG_DIR/"
    else
        echo -e "  ↳ ${ROJO}Advertencia:${RESET} No se encontró la carpeta $comp en el repositorio."
    fi
done

echo -e "${VERDE}✅ ¡Entorno de desarrollo configurado con éxito!${RESET}"
echo -e "${AMARILLO}💡 Reinicia tu sesión de Hyprland para aplicar los cambios basados en Lua.${RESET}"
