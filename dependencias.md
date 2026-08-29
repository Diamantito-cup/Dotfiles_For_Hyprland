<h1 align="center">Lista de dependencias de los dotfiles</h1>

> Lista de dependencias de los dotfiles :D

Si bien en el **[README](README.md)** mostré algunas dependencias, no fueron todas y tampoco mencioné mucho sobre el para que se utilizan, así que e hecho esta nueva lsita de dependencias, más completa para aquellos que la quieran leer :D

Pero bueno ya mucha chachara, asíq eu vamos al grano:

<h1 align="center">Dependencias Primarias</h1>

* **Hyprland**: Es la base de todo, es el WM que crea y mantiene todo, el que dibuja las ventanas y que los demás programas necesitan para dibujar ventanas en la pantalla.

* **Kitty**: La terminal, Hyprland la pide por default, así que es una de las dependencias de hyprland, pero pueden usar otra como Alacritty o Ghosty, pero este repo se enfoca 100% solo en la terminal Kitty.

* **Midnight-Shell/CLI**: Aquí está la joya de la corona, la shell, como saben, Hyprland no viene por default con una shell pre-isntalada, existen muchas, como Waybar, la más canocida, Ax-Shell o Ambxst, estas ya son shell prefabricadas sobre GTK, AGG's o más recientemente, QuickShell (sobre Qt Quick/QML), Midnight Shell se encarga de todo, wifi, bluetooth, bateria si estás en laptop, audio, ETC, y la CLI es lo que permite hacer cosas divertidas con la shell :D

* **Zsh**: El interprete de comandos, existen muchos, Midnight y todo el entorno de caelestia se basan mucho en la shell de Fish, pero como estoy más acostumbrado a Zsh, pues, Zsh, jejejeejejejeje.

* **Oh My Zsh**: Este es para colocarle plugins visuales y sitacticos a Zsh, es bastante bueno e interesante, muy sugerido, si bien es opcional, es muy recomendado porque eleva al siguiente nivel tu configuración de Zsh.

* **Fastfetch**: El infaltabale, aparte de mostrarte las stats de tu sistema, lo puedes personalizar para que parezca algo completamente nuevo e interesante.

* **ImageMagick**: El protocolo que le permite a Fastetch mostrar imagenes en vez del logo ASCII de la distro, es un plus inecesario pero que en este repo se usa bastante (como podran ver en ***[Carpeta imagenes de Fastfetch](fastfetch/images)*** y en ***[Config de Fastfetch](fastefetch/config.jsonc)***).

* **Qt6ct**: permite controlar los temas de iconos de caelestia y globales.

* **Kvantum**: permite colocarle temas a Dolphin y otras apps Qt 5/6.

Bien, estas son las dependencias base, indispensables para los dotfiles, allá ustedes si quieren modificarlas y todo eso, son libres de hacerlo, para eso existe el fork, pueden adaptar todo esto para Ghosty, Alacritty, Caelestia Shell base, Noctalia, ETC, pero bueno, estas son las siguientes dependencias, las secundarias, que solo te dan una mejor de experiencia de uso pero no son obligatorias:

<h2 align="center">Dependencias Secundarias</h2>

* **Cava/libcava**: Bien, cava es solo algo estetico que, bueno, literalmente solo sirve apra ver barrites subir y bajar segun la música, y libcava es la librería que lo hace posible (Libcava sí es una dependencia primaria ya que es requerida por Midnight-Shell).

* **PowerLevel10K**: Este es un tema para Zsh, a diferencia de Starship, Pl10K es más completo y personalizable, aparte que, de fabrica, ya es bastante completo.

* **zsh-syntax-highlighting/zsh-autosuggestions**: Son dos de los mejores plug-ins de Zsh, indican si un comando está bien escrito o no con colores y tambien pueden mostrar si ya has escrito ese comando antes.

* **Atuin**: Atuin es una herramienta que ayuda a ver tu historial de comandos, es bastante completa, la sugiero mucho si vas a usar constantemente los mismos comandos una y otra vez.

* **Spotify/Spicetify**: Todos conocemos a Spotify, pero con Spicetify se puede elevear al siguiente nivel, te permite colocarle plug-ins como un bloqueador de anuncios, hacer bhackups, colocarle temas, ETC, definitivamente indispensable si escuchas constantemente música.

* **Glassy Music**: Este es un cliente de Youtube Music bastante bonito y completo, añadiendo el plug-in ***Better Lyrics*** se puede lograr una estetía bastante interesante a la hoira de ver la letra de tu música favorita.

* **Zuno**: Otro cliente de Youtube Music para escritorio, puede no ser tan esteticamente interesante como visualmente como ***Glassy Music*** pero te permite descargar localemente tu musica sin necesidad de alguna suscripción.

* **HyprMod**: He aquí a uno de los mejores inventos creados por la comunidad, una App GTK5/LibAdwaita que te permite modificar y personalizar tu hyprland casi sin tener que recurrir al archivo de configuracióm `.lua`, pero es bastante limitado a la hora de multi-monitor.

* **HyprMonCFG**: Este, a diferencia de HyprMod, está casi que 100% enfocado en el uso de multimonitor, permitiendote mover practicamente todo para que la experiencia de hyprland con multiples monitores sea lo mejor posible.

Bien, por ahora, estas serían todas las dependencias, acá los links a los repos de las menos conocidas por si las quieren ver:

<h3 align="center">Repositorios de las herramientes mencionadas menos conocidas</h3>

##### HyprMoCFG
---> [HyprMonCFG - Create multi-monitor layouts for Hyprland](https://github.com/crmne/hyprmoncfg.git)

##### Glassy Music
---> [Glassy Music - A personalized fork maintained by NanKill](https://github.com/NanKillBro/glassy-music-nankill.git)

##### Zuno
---> [Zuno Music](https://github.com/noFAYZ/zuno.git)

##### Spicetify
---> [Spicetify CLI](https://github.com/spicetify/cli.git)

##### Atuin
---> [Atuin](https://github.com/atuinsh/atuin.git)

---

Bien, esas son todas las dependencias *POR AHORA* no se sí con el tiempo vayan creciendo, ya veré si eso sucede, pero por ahora, gracias por leer :D

> By Ange
