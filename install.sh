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

# Componentes: archivos y directorios a instalar
# Formato: "tipo:nombre:origen"
# tipo: "file" o "dir"
COMPONENTES=(
    "file:hyprland.lua:hypr/hyprland.lua"
    "dir:caelestia:caelestia"
    "dir:wofi:wofi"
)

# 1. Crear copia de seguridad si ya existen configuraciones previas
echo -e "${AMARILLO}📦 Verificando configuraciones existentes para respaldo...${RESET}"
NECESITA_BACKUP=false

for comp in "${COMPONENTES[@]}"; do
    tipo=$(echo "$comp" | cut -d: -f1)
    nombre=$(echo "$comp" | cut -d: -f2)
    
    if [ "$tipo" = "dir" ]; then
        if [ -d "$CONFIG_DIR/$nombre" ]; then
            NECESITA_BACKUP=true
        fi
    else
        # Para archivos, verificar si existe en la ubicación esperada
        if [ "$nombre" = "hyprland.lua" ]; then
            if [ -f "$CONFIG_DIR/hypr/hyprland.conf" ]; then
                NECESITA_BACKUP=true
            fi
        fi
    fi
done

if [ "$NECESITA_BACKUP" = true ]; then
    echo -e "${AMARILLO}💾 Creando copia de seguridad en: $BACKUP_DIR${RESET}"
    mkdir -p "$BACKUP_DIR"
    
    # Respaldar la carpeta de Hyprland si existe
    if [ -d "$CONFIG_DIR/hypr" ]; then
        cp -r "$CONFIG_DIR/hypr" "$BACKUP_DIR/" 2>/dev/null || true
    fi
    
    # Respaldar otros componentes
    for comp in "${COMPONENTES[@]}"; do
        tipo=$(echo "$comp" | cut -d: -f1)
        nombre=$(echo "$comp" | cut -d: -f2)
        
        if [ "$tipo" = "dir" ]; then
            if [ -d "$CONFIG_DIR/$nombre" ]; then
                cp -r "$CONFIG_DIR/$nombre" "$BACKUP_DIR/" 2>/dev/null || true
            fi
        fi
    done
    
    echo -e "${VERDE}✅ Copia de seguridad creada con éxito.${RESET}"
fi

# 2. Limpieza crítica de Hyprland viejo (.conf)
# Si hyprland.conf se queda en ~/.config/hypr/, el sistema podría ignorar tu archivo .lua
if [ -f "$CONFIG_DIR/hypr/hyprland.conf" ]; then
    echo -e "${ROJO}🗑️ Removiendo hyprland.conf antiguo para priorizar la carga de Lua...${RESET}"
    rm -f "$CONFIG_DIR/hypr/hyprland.conf"
fi

# 3. Instalación de los nuevos archivos de la rama dev
echo -e "${VERDE}⚙️ Instalando nuevos archivos de configuración...${RESET}"

# Instalar cada componente
for comp in "${COMPONENTES[@]}"; do
    tipo=$(echo "$comp" | cut -d: -f1)
    nombre=$(echo "$comp" | cut -d: -f2)
    origen=$(echo "$comp" | cut -d: -f3)
    
    if [ "$tipo" = "dir" ]; then
        if [ -d "$SCRIPT_DIR/$origen" ]; then
            mkdir -p "$CONFIG_DIR/$nombre"
            cp -r "$SCRIPT_DIR/$origen/"* "$CONFIG_DIR/$nombre/" 2>/dev/null || true
            echo -e "  ↳ ${VERDE}Instalada la carpeta:${RESET} $nombre -> $CONFIG_DIR/"
        else
            echo -e "  ↳ ${ROJO}Advertencia:${RESET} No se encontró la carpeta $origen en el repositorio."
        fi
    else
        # Para archivos
        if [ -f "$SCRIPT_DIR/$origen" ]; then
            mkdir -p "$(dirname "$CONFIG_DIR/$nombre")"
            cp "$SCRIPT_DIR/$origen" "$CONFIG_DIR/$nombre"
            echo -e "  ↳ ${VERDE}Instalado:${RESET} $nombre -> $CONFIG_DIR/"
        else
            echo -e "  ↳ ${ROJO}Advertencia:${RESET} No se encontró el archivo $origen en el repositorio."
        fi
    fi
done

# 4. Mostrar resumen
echo -e "${VERDE}✅ ¡Entorno de desarrollo configurado con éxito!${RESET}"
echo -e "${AMARILLO}💡 Si había configuraciones anteriores, puedes restaurarlas desde: $BACKUP_DIR${RESET}"
echo -e "${AMARILLO}💡 Reinicia tu sesión de Hyprland para aplicar los cambios basados en Lua.${RESET}"
