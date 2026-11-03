<!-- Firma: @DevJhojan -->

# Configuración personal de Neovim

Configuración de Neovim en Lua para elegir y recordar perfiles de trabajo por repositorio. Cada perfil guarda su selección, define metadatos de tema y un proveedor de autocompletado, y se restaura al abrir Neovim desde ese repositorio. Los fondos del editor y de las ventanas flotantes son transparentes; el perfil predeterminado usa acentos cyberpunk rojos.

## Requisitos

- Neovim 0.11 o posterior. La configuración de LSP utiliza `vim.lsp.config` y `vim.lsp.enable`.
- Git, para descargar `lazy.nvim`, los plugins y los servidores administrados por Mason.
- Una terminal con soporte para colores true color de 24 bits.
- Para usar el portapapeles del sistema, un proveedor compatible con Neovim en el sistema operativo.
- Para GDScript, Godot debe estar ejecutándose con su servidor de lenguaje habilitado.

## Instalación

Coloca este repositorio en el directorio de configuración de Neovim (`~/.config/nvim` en Linux y macOS; en Windows, el directorio indicado por `stdpath("config")`). Si ya tienes una configuración allí, respáldala antes de sustituirla.

Inicia Neovim:

```sh
nvim
```

En el primer inicio, `init.lua` clona `lazy.nvim` si no está instalado; después, `lazy.nvim` descarga los plugins definidos en `lua/plugins/`. Mason administra la instalación de los servidores LSP configurados. Reinicia Neovim si algún plugin o servidor termina de instalarse durante la primera sesión.

## Perfiles de proyecto

El gestor ofrece estos perfiles:

| Perfil | Metadatos de autocompletado | Tema |
|---|---|---|
| `default` | `none` | Fondo transparente y acentos cyberpunk rojos |
| `python` | `pyright` | Paleta amarilla, azul y blanca |
| `django` | `django` | Paleta naranja, verde y blanca |
| `typescript` | `ts_ls` | Paleta azul, cian y blanca |
| `react` | `ts_ls` | Paleta azul, lima y blanca |
| `react-native` | `ts_ls` | Paleta azul, morada y blanca |
| `bash` | `bashls` | Paleta oscura con acentos claros |
| `rust` | `rust_analyzer` | Paleta azul oscura con acentos cálidos |
| `godot` | `gdscript` | Paleta azul oscura con acentos cian |

`ProjectProfileSelect` abre el selector y guarda la elección para el directorio de trabajo actual. El perfil se restaura automáticamente al iniciar Neovim en ese directorio. Si no existe una selección guardada, se activa `default`.

Los valores de autocompletado son metadatos expuestos en `vim.g.project_profile_completion`. Los servidores LSP listados en la configuración de Mason se habilitan globalmente; la selección de un perfil no los instala ni habilita de forma exclusiva. La configuración actual no incluye un motor de autocompletado dedicado. El servidor `gdscript` lo proporciona Godot y debe estar disponible en ejecución.

## Comandos

| Comando | Acción |
|---|---|
| `:ProjectProfileSelect` | Elegir y guardar un perfil para el directorio de trabajo actual |
| `:ProjectProfileClear` | Borrar el perfil guardado para el directorio actual y volver al predeterminado |

El estado se guarda como JSON en `stdpath("data")/project_profiles.json` (habitualmente `~/.local/share/nvim/project_profiles.json` en Linux). Las selecciones se asocian a la ruta del directorio tal como la devuelve Neovim; mover un repositorio puede requerir volver a elegir el perfil.

## Atajos de teclado

La tecla líder es la barra espaciadora.

| Atajo | Acción |
|---|---|
| `<leader>w` | Guardar el archivo |
| `<leader>q` | Cerrar |
| `<leader>p` | Abrir el selector de perfiles |
| `<leader>ff` | Buscar archivos con Telescope |
| `<leader>fg` | Buscar texto en el proyecto con Telescope |
| `<leader>fb` | Listar buffers abiertos con Telescope |
| `<leader>nt` | Alternar el árbol de archivos |
| `]c` / `[c` | Ir al siguiente/anterior cambio de Git |
| `<leader>hs` | Preparar (stage) el hunk actual |
| `<leader>hr` | Revertir el hunk actual |
| `<leader>hp` | Previsualizar el hunk actual |
| `<leader>hb` | Mostrar el blame de la línea actual |

## Opciones y plugins

- Números de línea absolutos y relativos, indentación de dos espacios, `expandtab`, indentación inteligente, `cursorline` y colores true color.
- Portapapeles configurado como `unnamedplus`.
- **Catppuccin** como colorscheme base, configurado con fondo transparente.
- **Mason** y **nvim-lspconfig** para servidores de lenguaje.
- **Telescope** para búsqueda de archivos, texto y buffers.
- **nvim-tree** como explorador de archivos.
- **Gitsigns** para visualizar y gestionar cambios de Git.
- **nvim-colorizer** para resaltar valores de color en archivos.
- `lazy-lock.json` registra las revisiones fijadas de los plugins.

Los fondos de `Normal` y `NormalFloat` se fuerzan a transparentes al aplicar un perfil y al cambiar el colorscheme. Los perfiles `default` y `godot` también aplican colores de texto y acentos propios.

## Estructura

```text
init.lua                         Punto de entrada y carga de plugins
lua/config/                      Opciones, atajos y transparencia
lua/plugins/                     Especificaciones de plugins
lua/project_profile/manager.lua  API pública y comandos del gestor
lua/project_profile/core/        Perfiles, persistencia y lógica de activación
tests/                           Pruebas de perfiles y restauración
docs/                            Backlog e historias del proyecto
lazy-lock.json                   Versiones fijadas de plugins
```

## Pruebas

Desde la raíz del repositorio, ejecuta la suite de perfiles con la configuración del proyecto:

```sh
nvim --headless -u init.lua \
  -c "lua dofile('tests/profiles_alls_spec.lua')" \
  -c "qa"
```

La prueba verifica el guardado y la restauración de perfiles, la transparencia de los fondos del editor y de las ventanas flotantes, las transiciones entre perfiles y la restauración del colorscheme base.

## Solución de problemas

- **El selector no aparece:** ejecuta `:ProjectProfileSelect` o usa `<leader>p` en modo normal. `vim.ui.select` usa el selector disponible en la configuración actual.
- **Un plugin falta después del primer inicio:** revisa `:Lazy` y permite que termine la descarga; luego reinicia Neovim.
- **Un servidor LSP no está disponible:** revisa `:Mason` y `:checkhealth`; confirma que el servidor esté instalado. Para Godot, abre el editor del proyecto y habilita su servidor de lenguaje.
- **El portapapeles del sistema no funciona:** instala/configura un proveedor de clipboard compatible con tu plataforma.
- **El perfil de un repositorio no se restaura:** comprueba el directorio actual con `:pwd`; el gestor asocia perfiles a la ruta del directorio de trabajo.
