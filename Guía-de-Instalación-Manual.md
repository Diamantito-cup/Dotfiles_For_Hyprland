<h3 align="center">Instalación manual</h3>

Con que elegiste el camino de la muerte... Baja el `.zip` desde aquí, o haz:
```bash
git clone https://github.com/Diamantito-cup/Dotfiles_For_Hyprland.git ~/Dotfiles && cd ~/Dotfiles
git checkout dev
```
Y luego descomprimelo (en caso de que hayas bajado el `.zip` desde aquí, para), dentro encontraras las carpetas de: hypr, wofi, kitty y fastfetch, y el archivo de `.zshrc`, puedes ignorar la carpeta  de Wallpapers y assets, puedes usar la carpeta de Wallpapers como base para tu colección, pero las que vamos a usar son las 4 anteriormente mencionadas y el archivo `.zshrc`.

---

<h3 align="center">Caso A: haber usado el .zip</h3>

Suponiendo que ya tienes instaladas todas las dependencias necesarias, iniciemos por hyprland, abre tu explorador de archivos (suponiendo que sea Dolphin) y entra a Descargas/Downloads -> Dotfiles_For_Hyprland -> hypr; y dentro de la carpeta hypr copia el archivo `hyprland.lua`, en la esquina superior derecha debe estar la opcion de dividir vista, click, te va a abrir otra vista, en la barra de busqueda de esa vista escribe `~/.config/hypr/` dentro de esa carpeta pega el hyprland.lua que copiaste, y si encuentras el anterior .conf, renombralo a hyprland.conf.back, luego **Windows(Super) + M** para recargar sesión grafica y debe cargar tu `hyprland.lua` (ojo, esto solo funciona para las nuevas versiones a partir de la 0.55 que implementan el formato .lua, porque si no, no va a funcionar y te va a mandar a pantalla negra).

---

<h3 align="center">Caso B: haber hecho el git clone</h3>

Si elegiste hacer el `git clone` pues, bien, te ahorras estar entrando y saliendo de tu carpeta Descargas/Downloads, lo mismo de arriba, solo que cambia Descargas/Downloads por ~/Dotfiles (o el directorio donde hayas clonado este repositorio).

---

Ahora vamos con kitty, abra una terminal **(Windows(Super) + Q)** y escriba:
```bash
mkdir -p ~/.config/kitty/
```
Eso creará el directorio necesario, de vuelta a Dolphin, salga de la carpeta hypr de la carpeta Dofiles_For_Hyprland y entra a la carpeta kitty que está ahí mismo (no cierres la vista dividida) y copia el `kitty.conf` y el `current-theme.conf`, luego, en la vista dividida, en la barra de busqueda, haz `~/.config/kitty/` y pega los dos archivos que copiaste, luego reinicia todas las terminales y se aplicaran los cambios.

*(PD:Escribo esto mientras ando escuchando un meme de Kasane Tetto, JAJAJAJAJAJA)*

Vamos con wofi, abre una terminal **(Windows(Super) + Q)** y haz:
```bash
mkdir -p ~/.config/wofi/ 
```
Y eso creará el directorio que necesitamos, entoneces, en Dolphin, sal de la carpeta kitty (la que está dentro de la carpeta Dotfiles_For_Hyprland en Descargas/Downloads o en el directorio donde hayas hecho el `git clone`) y entra a la carpeta que dice wofi, dentro encontraran una carpeta llamada styles.css, copienla, luego, en la vista dividida, en la barra de busqueda, escriban `~/.config/wofi/` dentro encontraremos la carpeta vacía, peguen el archivo que copiaron dentro de esa carpeta.

Ahora vamos con fastfetch, abre una terminal **(Windows(Super) + Q)** y haz:
```bash
mkdir -p ~/.config/fastfetch
```
No es necesario crear config porque nosotros la vamos a generar a mano, luego, en Dolphin, vamos a salir de la carpeta wofi (la que está dentro de Dotfiles_For_Hyprland) y entremos a la carpeta fastfetch, dentro encontraran dos cosas, una carpeta llamada `images`, que es donde están las imaganes, y un archivo llamado `config.jsonc`, copia ambas cosas, y en la vista dividida, en la barra de busqueda escribe `~/.config/fastfetch/` la carpeta debe estar vacia, si no, pueden borrar lo que está dentro y pegar lo que habian copiado (la carpeta images y el archivo config.jsonc) y listo :3 

Si se preguntan porque no metí a cava aquí es porque con caelestia  pueden hacer:
```bash
caelestia scheme set -n dynamic
```
Y su paleta de colores se va a cambiar segun su wallpaper y sobre el archivo de `.zshrc` pues, solo es copiar su contenido y pegarlo en su `.zshrc` propio o reemplazandolo por completo :3
