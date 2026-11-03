<!-- Firma: @DevJhojan -->

## Story
Como usuario de Godot, quiero elegir un perfil con soporte para GDScript y archivos de escena, además de un tema propio por repositorio, para trabajar en mis proyectos Godot sin reconfigurar el editor.

## Acceptance criteria
- [x] Dado que un repositorio no tiene un perfil Godot guardado, cuando el usuario lo elige, entonces Neovim ofrece soporte de edición para GDScript (`.gd`) y archivos de escena/recursos (`.tscn`, `.tres`), incluyendo resaltado de sintaxis y, cuando corresponda, autocompletado, diagnósticos y navegación; además, aplica un tema con fondo azul medianoche `#141B26` (60%), texto blanco hielo `#E3EAF2` (30%) y acento cian eléctrico `#5FD4F4` (10%).
- [x] Dado que un repositorio ya tiene guardado el perfil Godot, cuando el usuario lo vuelve a abrir, entonces Neovim restaura automáticamente ese perfil y su configuración.
- [x] Dado que el usuario cambia el perfil de un repositorio, cuando guarda la nueva elección, entonces el perfil Godot deja de aplicarse allí y queda reemplazado por la configuración seleccionada.

## Plan
- Confirmar el flujo existente para guardar y restaurar perfiles por repositorio.
- Definir el soporte de edición para GDScript y archivos de escena/recursos según las capacidades disponibles en Neovim.
- Validar activación del perfil, soporte de archivos y tema acordado.
- Validar la restauración automática al reabrir el repositorio.
- Validar que otra elección reemplace el perfil Godot sin afectar otros repositorios.

## Out of scope
- No se incluye detección automática de proyectos Godot por su contenido o archivos.
- No se incluyen funciones exclusivas del editor Godot que no estén disponibles desde Neovim.
- No se contemplan otros perfiles ni personalización de temas fuera del perfil Godot.
- No se incluyen ajustes globales que no dependan del repositorio.

## Suggestions (your call)
- El código ya contempla `godot` como perfil seleccionable, pero no encontré configuración de GDScript ni archivos de escena. Conviene verificar qué capacidades ofrecen el servidor `gdscript` y las herramientas de sintaxis para `.tscn`/`.tres` antes de fijar el alcance de “todo”.
