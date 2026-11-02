## Story
Como usuario de Bash, quiero elegir un perfil con autocompletado y tema propios para cada repositorio, para trabajar con asistencia contextual en mis scripts.

## Acceptance criteria
- [x] Dado que un repositorio no tiene un perfil Bash guardado, cuando el usuario lo elige, entonces Neovim activa autocompletado para Bash y aplica una paleta con fondo `#16141F` (60%), texto `#E0DEF4` (30%) y acento `#9CCFD8` (10%).
- [ ] Dado que un repositorio ya tiene guardado el perfil Bash, cuando el usuario lo vuelve a abrir, entonces Neovim restaura automáticamente ese perfil.
- [ ] Dado que el usuario cambia el perfil de un repositorio, cuando guarda la nueva elección, entonces el perfil Bash deja de aplicarse allí y queda reemplazado por la configuración seleccionada.

## Plan
- Confirmar el flujo existente para guardar y restaurar perfiles por repositorio.
- Definir el comportamiento del perfil Bash con el autocompletado y la paleta acordados.
- Validar la activación del perfil en un repositorio sin configuración previa.
- Validar la restauración automática al reabrir el repositorio.
- Validar que una nueva elección reemplace el perfil Bash sin afectar otros repositorios.

## Out of scope
- No se incluye la detección automática de proyectos Bash por su contenido o archivos.
- No se contemplan otros perfiles ni personalización de temas fuera del perfil Bash.
- No se incluyen ajustes globales que no dependan del repositorio.

## Suggestions (your call)
- Reutilizar el flujo existente de perfiles por repositorio. El gestor actual ya registra el perfil `bash`, aunque aún no tiene su configuración específica.
