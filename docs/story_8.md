<!-- Firma: @DevJhojan -->

## Story
Como usuario de Rust, quiero elegir un perfil con autocompletado y tema propios para cada repositorio, para desarrollar en Rust sin reconfigurar el editor.

## Acceptance criteria
- [x] Dado que un repositorio no tiene un perfil Rust guardado, cuando el usuario lo elige, entonces Neovim activa autocompletado para Rust con `rust_analyzer` y aplica un tema con fondo azul marino oscuro `#0F1A2B` (60%), texto blanco hueso `#EDE6D6` (30%) y acento rojo coral `#F74C3C` (10%).
- [x] Dado que un repositorio ya tiene guardado el perfil Rust, cuando el usuario lo vuelve a abrir, entonces Neovim restaura automáticamente ese perfil.
- [x] Dado que el usuario cambia el perfil de un repositorio, cuando guarda la nueva elección, entonces el perfil Rust deja de aplicarse allí y queda reemplazado por la configuración seleccionada.

## Plan
- Confirmar el flujo existente para guardar y restaurar perfiles por repositorio.
- Definir el comportamiento del perfil Rust con el autocompletado y la paleta acordados.
- Validar la activación del perfil en un repositorio sin configuración previa.
- Validar la restauración automática al reabrir el repositorio.
- Validar que una nueva elección reemplace el perfil Rust sin afectar otros repositorios.

## Out of scope
- No se incluye la detección automática de proyectos Rust por su contenido o archivos.
- No se contemplan otros perfiles ni personalización de temas fuera del perfil Rust.
- No se incluyen ajustes globales que no dependan del repositorio.

## Suggestions (your call)
- Reutilizar el flujo existente de perfiles por repositorio.
