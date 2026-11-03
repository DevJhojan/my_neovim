## Story
Como usuario de Neovim, quiero que el perfil predeterminado tenga una interfaz visual cyberpunk en tonos rojos, para contar con un tema distintivo cuando no elija otro perfil.

## Acceptance criteria
- [x] Dado un repositorio sin un perfil guardado o cuando no se ha seleccionado ningún perfil, cuando Neovim inicia, entonces se aplica el perfil predeterminado con un esquema visual cyberpunk en rojo que se distingue claramente del resto de perfiles.
- [x] Dado que el perfil predeterminado está activo, cuando el usuario abre el editor e interactúa con los elementos principales de la interfaz, entonces la interfaz usa una paleta coherente en tonos rojos con contraste legible para texto y elementos destacados.
- [x] Dado que el usuario vuelve a abrir Neovim en el mismo repositorio sin seleccionar otro perfil, cuando el editor restaura su estado, entonces el tema cyberpunk rojo predeterminado sigue activo hasta que elija un perfil específico del proyecto.

## Plan
- Definir la identidad visual predeterminada con una paleta cyberpunk en rojo, legible y consistente.
- Confirmar que el perfil predeterminado se usa cuando no hay un perfil guardado para el repositorio.
- Validar que el tema predeterminado se restaura correctamente al volver a abrir y no entra en conflicto con perfiles específicos.
- Revisar que el tratamiento visual sea coherente en las superficies principales del editor sin introducir configuración adicional.
- Mantener el alcance limitado a la experiencia del perfil predeterminado y sus reglas de persistencia.

## Out of scope
- Crear o cambiar temas específicos de proyecto más allá del perfil predeterminado.
- Agregar flujos nuevos de selección de perfil o reglas de coincidencia por repositorio.
- Cualquier automatización o herramienta no requerida para aplicar el tema visual predeterminado.

## Suggestions (your call)
- Mantener el tema predeterminado simple y distintivo, usando una fuerte acentuación roja en lugar de intentar replicar cada variación de los perfiles específicos.
- Si el sistema actual de estilos ya tiene una abstracción de temas, reutilizar ese patrón solo para el perfil predeterminado para evitar complejidad extra.
