## Story
Como usuario de TypeScript, quiero elegir un perfil con autocompletado y tema propios para cada repositorio, para trabajar sin volver a configurar el editor.

## Acceptance criteria
- [ ] Dado que un repositorio no tiene un perfil de TypeScript guardado, cuando el usuario elige el perfil de TypeScript, entonces Neovim aplica el autocompletado específico de TypeScript y un tema visual propio para ese proyecto.
- [ ] Dado que un repositorio ya tiene guardado el perfil de TypeScript, cuando el usuario lo vuelve a abrir, entonces Neovim restaura automáticamente ese perfil sin requerir que vuelva a seleccionarlo.
- [ ] Dado que el usuario cambia el perfil de un repositorio, cuando guarda la nueva elección, entonces el perfil de TypeScript deja de aplicarse en ese proyecto y queda reemplazado por la nueva configuración seleccionada.

## Plan
- Confirmar la restauración del perfil por repositorio y la lógica de reemplazo ya usada en otros perfiles.
- Definir el comportamiento mínimo del perfil de TypeScript: autocompletado y tema visual asociados al repositorio.
- Validar la activación del perfil de TypeScript en un repositorio sin configuración previa.
- Validar la restauración automática al volver a abrir el repositorio.
- Validar que cambiar el perfil reemplaza la configuración previa de TypeScript sin afectar otros repositorios.

## Out of scope
- No se incluye la detección automática del tipo de proyecto por contenido o estructura de carpetas.
- No se contemplan otros perfiles distintos a TypeScript en esta historia.
- No se incluye la personalización de temas fuera del perfil de TypeScript ni ajustes globales no ligados al repositorio.

## Suggestions (your call)
- Reutilizar el mismo patrón de activación y restauración ya aplicado en perfiles anteriores para mantener un comportamiento consistente y evitar duplicar reglas.
