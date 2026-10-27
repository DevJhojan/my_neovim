## Story
Como usuario de TypeScript, quiero un perfil con autocompletado para trabajar en proyectos TypeScript, para que pueda desarrollar en repositorios Git sin reconfigurar el entorno en cada sesión.

## Acceptance criteria
- [x] Dado un repositorio Git sin un perfil de TypeScript guardado, cuando lo abro, entonces puedo elegir el perfil adecuado y guardar esa selección para asociarla al proyecto.
- [ ] Dado un repositorio Git con un perfil de TypeScript guardado, cuando lo abro de nuevo, entonces Neovim carga automáticamente el entorno de autocompletado de TypeScript sin pedirme que lo elija otra vez.
- [ ] Dado que cambio la selección de perfil de TypeScript para un proyecto, cuando guardo la nueva elección, entonces la asociación del repositorio se actualiza y la próxima apertura usa el perfil más reciente.

## Plan
- Confirmar el punto en que se detecta el repositorio y cuándo se ofrece la elección del perfil para ese proyecto.
- Definir la asociación del perfil de TypeScript con el repositorio actual y su persistencia.
- Añadir la restauración automática del perfil guardado al volver a abrir ese mismo repositorio.
- Validar los casos de ausencia de perfil, persistencia y reasignación con la mínima suite necesaria.
- Verificar que el comportamiento no rompe la lógica general de perfiles ya implementada para otros proyectos.

## Out of scope
- Los perfiles de Python, Django, React Native, React o Bash.
- Cambios visuales o de interfaz que no formen parte del flujo de perfil.
- Reestructuración global de la configuración de Neovim fuera del manejo de perfiles por proyecto.
- Funcionalidades de autocompletado o tooling más allá del mínimo necesario para TypeScript.

## Suggestions (your call)
- Si el flujo de selección y restauración se repite en futuros perfiles, conviene centralizar la decisión de “qué perfil cargar para este repositorio” en un único punto para evitar duplicación y mantener consistencia.
