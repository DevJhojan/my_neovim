## Story
Como usuario, quiero seleccionar y guardar un perfil para cada repositorio y que Neovim active el perfil elegido al abrirlo, para volver a trabajar con el entorno adecuado sin reconfigurarlo.

## Acceptance criteria
- [ ] Dado un repositorio sin perfil guardado, cuando lo abro, entonces el selector ofrece TypeScript —el único perfil implementado actualmente— y guarda mi elección para ese repositorio.
- [ ] Dado que elegí TypeScript para un repositorio, cuando lo abro o vuelvo a abrir, entonces Neovim activa ese perfil sin volver a pedirme que lo seleccione.
- [ ] Dado que abro otro repositorio, cuando Neovim resuelve su perfil, entonces la selección guardada para el primer repositorio no se aplica al segundo.

## Plan
- Ajustar las pruebas de persistencia genérica para usar nombres de perfil neutrales, no Python.
- Revisar los fixtures de repositorio y mantenerlos neutrales respecto a perfiles.
- Conectar el selector al guardado por repositorio y a la activación del perfil TypeScript disponible.
- Verificar selección inicial, restauración/activación y aislamiento entre repositorios.

## Out of scope
- Implementar el perfil de Python o cualquier otro perfil nuevo.
- Añadir soporte de perfiles todavía no implementados al selector.
- Cambios visuales del selector o del tema de Neovim.
