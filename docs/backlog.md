## Context
Entorno personal de Neovim que selecciona y recuerda un perfil de trabajo por cada proyecto con `.git`. El menú ofrecerá perfiles de Python, Django, TypeScript, React Native, React y Bash; el código se organizará de forma modular y cada módulo tendrá sus pruebas. Además, quiero una interfaz visual con estilo cyberpunk en tonos rojos para que el editor se vea atractivo y cómodo de usar.
Stack: Neovim y Lua. Framework de pruebas de Lua pendiente de elegir.
Decisiones costosas: ninguna.

## Backlog
1. [ok]Como usuario, quiero elegir y guardar por proyecto el perfil de Python con autocompletado al abrir un repositorio Git, para que Neovim cargue ese entorno en las próximas sesiones.
2. [ok]Como usuario de Django, quiero un perfil con autocompletado, para trabajar en proyectos Django. Requiere: #1
3. Como usuario de TypeScript, quiero un perfil con autocompletado, para trabajar en proyectos TypeScript. Requiere: #1
4. Como usuario de React Native, quiero un perfil con autocompletado, para trabajar en aplicaciones móviles. Requiere: #1
5. Como usuario de React, quiero un perfil con autocompletado, para trabajar en proyectos React. Requiere: #1
6. Como usuario de Bash, quiero un perfil con autocompletado, para trabajar en scripts de shell. Requiere: #1
7. Como usuario, quiero que al abrir un repositorio sin perfil asociado se me ofrezca la selección del perfil correcto para ese proyecto y quede guardado para futuras sesiones. Requiere: #1
8. Como usuario de Neovim, quiero una interfaz visual tipo cyberpunk con colores rojos, para que el editor se vea atractivo y me ayude a concentrarme.
