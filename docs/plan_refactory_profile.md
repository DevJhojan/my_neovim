## Story
Como mantenedor de la configuración de Neovim, quiero modularizar la gestión y las pruebas de perfiles por responsabilidad, de modo que cada módulo tenga un propósito claro y las futuras ampliaciones puedan reutilizar las piezas existentes.

## Acceptance criteria
- [ ] Dado el uso público actual de perfiles por proyecto, cuando se guarda, consulta o actualiza un perfil, entonces se conserva el comportamiento para repositorios normales y worktrees.
- [x] Dado el código de persistencia de perfiles, cuando se organiza por responsabilidades, entonces las responsabilidades pueden entenderse y mantenerse de forma independiente sin cambiar el uso público existente.
- [x] Dado que se ejecutan las pruebas de perfiles, cuando se validan guardado inicial, restauración y reasignación, entonces los escenarios están organizados por comportamiento, sin duplicar preparación innecesaria, y pasan.

## Plan
- Confirmar las responsabilidades ya separadas: `project_profile.lua` expone la API pública, `project_profile/git_dir.lua` resuelve repositorios y worktrees, y `project_profile/storage.lua` persiste los perfiles. Mantener esta estructura salvo que se encuentre una responsabilidad realmente mezclada.
- Revisar si la organización actual de `tests/project_profile_spec.lua` y su fixture `tests/support/project_repo.lua` tienen duplicación que justifique un cambio; no mover ni abstraer pruebas sin una mejora concreta.
- Ejecutar la suite existente y confirmar los escenarios de repositorio normal, worktree y reasignación.

## Situación actual
- La implementación ya tiene un punto de entrada público y módulos separados para resolución Git y almacenamiento.
- Las pruebas existentes cubren guardado/consulta, repositorio normal, worktree y reasignación. La restauración se entiende como consultar mediante `get_profile` el valor ya persistido; no implica reiniciar Neovim.
- Por tanto, antes de refactorizar, hay que confirmar que queda una mejora concreta en la organización de pruebas. Si no la hay, cerrar el trabajo sin cambios de código.

## Out of scope
- Implementar perfiles nuevos o sus configuraciones específicas.
- Cambiar el flujo visual de selección o activación de entornos.
- Añadir abstracciones o módulos sin una responsabilidad real que separar.

## Suggestions (your call)
- Conviene mantener un módulo de entrada que invoque los módulos especializados. “Una cosa por archivo” puede significar una responsabilidad coherente por módulo, sin crear un archivo por cada función pequeña.
