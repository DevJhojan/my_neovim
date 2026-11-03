## Story
Como usuario de Neovim, quiero que todos los perfiles de proyecto tengan fondos transparentes o con una transparencia aproximada del 90%, para mantener una interfaz visual ligera y consistente en todos mis repositorios.

## Acceptance criteria
- [x] Given cualquier perfil activo, when Neovim carga la configuración del proyecto, then el fondo principal de la interfaz se muestra con transparencia o con una opacidad cercana al 90%, sin afectar la legibilidad del texto.
- [x] Given un perfil específico de proyecto, when el usuario trabaja en el editor y abre ventanas flotantes o paneles, then esos fondos también mantienen la misma transparencia para conservar una experiencia visual uniforme.
- [x] Given el usuario cambia entre perfiles o abre un repositorio distinto, when la configuración del perfil se restaura, then la transparencia del fondo sigue aplicada consistentemente y no vuelve a un fondo opaco.

## Plan
- Definir la transparencia base que aplica a todos los perfiles.
- Ajustar la apariencia de fondos principales y superficies complementarias para mantener legibilidad.
- Confirmar que la transparencia se conserva al cambiar de perfil o repositorio.
- Revisar que no haya contrastes problemáticos en texto, comentarios o elementos destacados.
- Mantener el cambio centrado solo en la apariencia visual del fondo y su consistencia.

## Out of scope
- Cambiar la paleta de colores de cada perfil más allá del fondo transparente.
- Reestructurar la lógica de selección o guardado de perfiles.
- Añadir nuevas configuraciones visuales no relacionadas con la transparencia.

## Suggestions (your call)
- Mantener una transparencia uniforme en todos los perfiles para evitar que un solo perfil se vea “más claro” o “más oscuro” que el resto.
- Si existe una regla visual común para todos los temas, aplicarla como base y dejar que cada perfil solo ajuste la paleta de acentos.
