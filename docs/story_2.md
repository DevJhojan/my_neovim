## Story
Como usuario de Python, quiero elegir un perfil de Python con autocompletado y un tema propio para cada repositorio, para trabajar sin reconfigurar el editor.

## Acceptance criteria
- [X] Dado que un repositorio no tiene un perfil guardado, cuando el usuario elige el perfil de Python, entonces Neovim aplica el autocompletado específico de Python y un tema visual propio para ese proyecto con una proporción de 60% amarillo, 30% azul y 10% blanco.
- [X] Dado que un repositorio ya tiene guardado el perfil de Python, cuando el usuario lo vuelve a abrir, entonces Neovim restaura automáticamente ese perfil sin requerir que vuelva a seleccionarlo.
- [x] Dado que el usuario cambia el perfil de un repositorio, cuando guarda la nueva elección, entonces el perfil de Python deja de aplicarse en ese proyecto y queda reemplazado por la nueva configuración seleccionada.

## Plan
- Confirmar cómo se restaura la elección del perfil cuando el repositorio se abre de nuevo.
- Definir el conjunto mínimo de ajustes visibles del perfil de Python: autocompletado y tema visual.
- Validar la activación del perfil en un repositorio sin configuración previa.
- Validar la restauración automática en repositorios ya guardados.
- Confirmar que un cambio de perfil reemplaza la configuración previa sin afectar otros proyectos.

## Out of scope
- No se incluye la detección automática del tipo de proyecto por contenido o archivos.
- No se contemplan perfiles para Django, TypeScript, React, React Native, Bash, Rust ni Godot en esta historia.
- No se incluye la personalización de temas fuera del perfil de Python ni ajustes globales que no dependan del repositorio.

## Suggestions (your call)
- Si varios perfiles comparten la misma lógica de activación y visualización, conviene centralizar la aplicación de autocompletado y tema por perfil para evitar duplicar reglas y mantener comportamientos consistentes.
