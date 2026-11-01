## Story
Como usuario, quiero seleccionar y guardar un perfil de trabajo para cada repositorio y que Neovim lo recuerde al volver a abrirlo, para mantener asociado el perfil correcto a cada proyecto.

## Acceptance criteria
- [x] Dado que un repositorio no tiene un perfil guardado, cuando el usuario elige un perfil de trabajo, entonces Neovim lo guarda para ese proyecto y lo aplica de inmediato.
- [x] Dado que un repositorio ya tiene un perfil guardado, cuando el usuario lo vuelve a abrir, entonces Neovim restaura automáticamente ese perfil sin pedir la selección otra vez.
- [x] Dado que un usuario cambia de perfil en un repositorio, cuando confirma la nueva elección, entonces la nueva configuración reemplaza la anterior y queda recordada para futuras aperturas.

## Plan
- Identificar el punto mínimo en el que Neovim puede reconocer el repositorio activo.
- Definir la persistencia necesaria para recordar la elección entre sesiones.
- Establecer el flujo para guardar el perfil la primera vez y restaurarlo después.
- Validar que un cambio de perfil en un proyecto se refleje de forma inmediata.
- Confirmar el comportamiento cuando ya existe un perfil guardado.

## Out of scope
- No se incluyen perfiles específicos de Python, Django, TypeScript, React, React Native, Bash, Rust o Godot; eso queda para historias posteriores.
- No se contempla la detección automática por tipo de proyecto; esta historia solo cubre la selección manual y el recuerdo por repositorio.
- No se incluye la personalización visual ni ajustes de tema; eso corresponde a otra historia.

## Suggestions (your call)
- Si el proyecto crece con varios perfiles, conviene centralizar la lógica de activación y persistencia para evitar duplicar reglas y mantener la configuración consistente por repositorio.
