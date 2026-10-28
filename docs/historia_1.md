## Story
Como usuario, quiero seleccionar y guardar un perfil de trabajo para cada repositorio y que Neovim lo recuerde al volver a abrir el proyecto, para mantener el entorno correcto asociado a cada repositorio sin volver a configurarlo.

## Acceptance criteria
- [ ] Dado un repositorio sin un perfil guardado, cuando lo abro, entonces Neovim me ofrece un selector con los perfiles disponibles y guarda mi elección para ese repositorio.
- [ ] Dado que elegí un perfil para un repositorio, cuando lo abro o lo vuelvo a abrir, entonces Neovim restaura ese perfil sin volver a pedirme que lo seleccione.
- [ ] Dado que abro otro repositorio, cuando Neovim resuelve su perfil, entonces la selección guardada para el primer repositorio no se aplica al segundo.

## Plan
- Definir el flujo genérico de perfiles por repositorio, sin depender de un lenguaje específico.
- Conectar el selector con el modelo de persistencia por repositorio.
- Restaurar el perfil guardado al volver a abrir el repositorio y mantener cada repositorio aislado.
- Validar la selección inicial, la restauración y el aislamiento entre repositorios.

## Out of scope
- Añadir nuevos perfiles de lenguaje más allá de los que ya estén disponibles.
- Implementar comportamientos de LSP o herramientas específicas del perfil como parte de esta historia.
- Rediseñar visualmente el selector ni el tema del editor.

## Suggestions (your call)
- Mantener la lógica del selector genérica y asociada al repositorio, para que TypeScript sea solo una opción disponible y no una implementación especial.
- Si el proyecto crece más adelante, un pequeño “registro de perfiles” puede centralizar las opciones disponibles sin cambiar el comportamiento de memoria por repositorio.
