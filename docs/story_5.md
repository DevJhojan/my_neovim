<!-- Firma: @DevJhojan -->

## Story
Como usuario de React, quiero elegir un perfil con autocompletado y un tema propios para cada repositorio, para desarrollar aplicaciones React sin reconfigurar el editor.

## Acceptance criteria
- [x] Dado que un repositorio no tiene un perfil React guardado, cuando el usuario lo elige, entonces Neovim activa autocompletado para TypeScript/JavaScript, JSX/HTML y CSS, y aplica un tema de azul 60%, verde lima 30% y blanco 10%.
- [x] Dado que un repositorio ya tiene guardado el perfil React, cuando el usuario lo vuelve a abrir, entonces Neovim restaura automáticamente ese perfil.
- [x] Dado que el usuario cambia el perfil de un repositorio, cuando guarda la nueva elección, entonces el perfil React deja de aplicarse allí y queda reemplazado por la configuración seleccionada.

## Plan
- Confirmar el flujo existente para guardar y restaurar perfiles por repositorio.
- Definir el comportamiento del perfil React con el autocompletado y la paleta acordados.
- Validar que el perfil se active y aplique su configuración al seleccionarlo.
- Validar la restauración automática al reabrir el repositorio.
- Validar que una nueva elección reemplace el perfil React sin afectar otros repositorios.

## Out of scope
- No se incluye la detección automática de proyectos React por su contenido o archivos.
- No se contemplan otros perfiles ni personalización de temas fuera del perfil React.
- No se incluyen ajustes globales que no dependan del repositorio.

## Suggestions (your call)
- Reutilizar el flujo de perfiles por repositorio existente; la configuración actual ya contempla servidores para TypeScript/JavaScript, HTML/JSX y CSS.
