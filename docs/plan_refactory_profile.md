## Story
Como mantenedor de la configuración de Neovim, quiero modularizar la gestión y las pruebas de perfiles por responsabilidad, de modo que cada módulo tenga un propósito claro y las futuras ampliaciones puedan reutilizar las piezas existentes.

## Acceptance criteria
- [ ] Dado el uso público actual de perfiles por proyecto, cuando se guarda, consulta o actualiza un perfil, entonces se conserva el comportamiento para repositorios normales y worktrees.
- [ ] Dado el código de persistencia de perfiles, cuando se organiza por responsabilidades, entonces las responsabilidades pueden entenderse y mantenerse de forma independiente sin cambiar el uso público existente.
- [ ] Dado que se ejecutan las pruebas de perfiles, cuando se validan guardado inicial, restauración y reasignación, entonces los escenarios están organizados por comportamiento, sin duplicar preparación innecesaria, y pasan.

## Plan
- Identificar las responsabilidades existentes y sus dependencias.
- Separar las piezas que tienen límites claros, conservando un punto de entrada para el uso actual.
- Ordenar las pruebas por comportamiento y compartir solo la preparación común que reduzca duplicación.
- Ejecutar las pruebas y confirmar que repositorios normales y worktrees mantienen el comportamiento.

## Out of scope
- Implementar perfiles nuevos o sus configuraciones específicas.
- Cambiar el flujo visual de selección o activación de entornos.
- Añadir abstracciones o módulos sin una responsabilidad real que separar.

## Suggestions (your call)
- Conviene mantener un módulo de entrada que invoque los módulos especializados. “Una cosa por archivo” puede significar una responsabilidad coherente por módulo, sin crear un archivo por cada función pequeña.
