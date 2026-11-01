## Story
Como usuario de Django, quiero activar un perfil con autocompletado específico para Django y un tema propio para cada repositorio, para trabajar con asistencia contextual sin reconfigurar el editor.

## Acceptance criteria
- [ ] Dado que un repositorio no tiene un perfil de Django guardado, cuando el usuario elige el perfil de Django, entonces Neovim aplica el autocompletado específico de Django y un tema visual propio para ese proyecto con una proporción de 60% Naranja, 30% Verde y 10% blanco.
- [ ] Dado que un repositorio ya tiene guardado el perfil de Django, cuando el usuario lo vuelve a abrir, entonces Neovim restaura automáticamente ese perfil sin requerir que vuelva a seleccionarlo.
- [ ] Dado que el usuario cambia el perfil de un repositorio, cuando guarda la nueva elección, entonces el perfil de Django deja de aplicarse en ese proyecto y queda reemplazado por la nueva configuración seleccionada.

## Plan
- Confirmar el flujo de restauración del perfil por repositorio ya usado en el proyecto.
- Definir el comportamiento mínimo del perfil de Django: soporte de autocompletado y tema asociado al repositorio.
- Validar la activación del perfil de Django en un repositorio sin configuración previa.
- Validar la restauración automática al volver a abrir el repositorio.
- Validar que cambiar el perfil reemplaza la configuración previa de Django sin afectar otros repositorios.

## Out of scope
- No se incluye la detección automática del tipo de proyecto por contenido o estructura de carpetas.
- No se contempla soporte para otros perfiles distintos a Django en esta historia.
- No se incluye la personalización de temas fuera del perfil de Django ni ajustes globales que no dependan del repositorio.

## Suggestions (your call)
- Reutilizar el mismo patrón de activación de perfiles ya empleado para otros perfiles para mantener consistencia en autocompletado y tema entre repositorios.
