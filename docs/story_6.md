## Story
Como usuario de React Native, quiero elegir un perfil con autocompletado y tema propios para cada repositorio, para desarrollar aplicaciones móviles sin reconfigurar el editor.

## Acceptance criteria
- [x] Dado que un repositorio no tiene un perfil React Native guardado, cuando el usuario lo elige, entonces Neovim activa el autocompletado de TypeScript/JavaScript y aplica un tema de azul 60%, púrpura 30% y blanco 10%.
- [x] Dado que un repositorio ya tiene guardado el perfil React Native, cuando el usuario lo vuelve a abrir, entonces Neovim restaura automáticamente ese perfil.
- [ ] Dado que el usuario cambia el perfil de un repositorio, cuando guarda la nueva elección, entonces el perfil React Native deja de aplicarse allí y queda reemplazado por la configuración seleccionada.

## Plan
- Confirmar el flujo existente para guardar y restaurar perfiles por repositorio.
- Definir el comportamiento del perfil React Native con el autocompletado y la paleta acordados.
- Validar que el perfil se active y aplique su configuración al seleccionarlo.
- Validar la restauración automática al reabrir el repositorio.
- Validar que una nueva elección reemplace el perfil React Native sin afectar otros repositorios.

## Out of scope
- No se incluye la detección automática de proyectos React Native por su contenido o archivos.
- No se contemplan otros perfiles ni personalización de temas fuera del perfil React Native.
- No se incluyen ajustes globales que no dependan del repositorio.

## Suggestions (your call)
- Reutilizar el flujo existente de perfiles por repositorio y el autocompletado TypeScript/JavaScript (`ts_ls`).
