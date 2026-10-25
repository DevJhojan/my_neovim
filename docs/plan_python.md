## Story
Como usuario, quiero elegir y guardar un perfil de Python con autocompletado por proyecto al abrir un repositorio Git, para que Neovim cargue ese entorno en las próximas sesiones.

## Acceptance criteria
- [ ] Dado un repositorio Git sin ningún perfil guardado, cuando lo abro, entonces puedo elegir un perfil de Python y guardar esa selección para asociarla al proyecto.
- [ ] Dado un repositorio Git con un perfil de Python guardado, cuando lo abro nuevamente, entonces Neovim carga el entorno y el autocompletado de Python sin volver a pedirme que lo seleccione.
- [ ] Dado que cambio o vuelvo a seleccionar el perfil de Python de un proyecto, cuando guardo la nueva elección, entonces la asociación del proyecto se actualiza y la próxima apertura del repositorio usa el perfil más reciente.

## Plan
- Confirmar cómo se detecta un repositorio Git al iniciar y cuándo se mostrará la selección al usuario.
- Definir el flujo para elegir el perfil de Python y asociarlo con el proyecto actual.
- Añadir la lógica de restauración para cargar automáticamente el perfil guardado al abrir ese repositorio más adelante.
- Validar los casos límite de ausencia de perfil, cambio de repositorio y reasignación sin romper el flujo inicial.
- Verificar el comportamiento con la menor batería de pruebas posible que cubra persistencia y restauración.

## Out of scope
- Los perfiles de Django, TypeScript, React Native, React o Bash.
- Cambios en la gestión de ajustes globales o de otros editores.
- Un sistema multi-proyecto más allá del repositorio que está abierto actualmente.
- Cualquier trabajo visual más allá del flujo de selección necesario para esta historia.

## Suggestions (your call)
- Si la lógica de perfiles crece con el tiempo, conviene centralizar la decisión de “qué perfil cargar para este repositorio” en un único punto para mantener consistencia y evitar duplicación.
