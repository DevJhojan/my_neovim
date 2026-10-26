## Story
Como desarrollador de Django, quiero que Neovim reconozca mis proyectos Django y ofrezca autocompletado para sus APIs, para trabajar con asistencia contextual en el código del proyecto.

## Acceptance criteria
- [x] Dado un proyecto Python con `manage.py`, cuando se abre en Neovim, entonces se reconoce y activa el perfil Django.
- [ ] Dado que `django-stubs` no está declarado en `requirements.txt` o en `[project].dependencies` de `pyproject.toml`, cuando se activa el perfil Django, entonces queda declarado e instalado en el entorno Python del proyecto, sin añadir entradas duplicadas.
- [ ] Dado un proyecto Django con el perfil activo, cuando se completa código Django, entonces el autocompletado incluye sus APIs; los proyectos Python que no son Django conservan el comportamiento actual.

## Plan
- Detectar los proyectos Django mediante su marcador acordado.
- Preparar `django-stubs` en los formatos de dependencias acordados y en el entorno Python del proyecto.
- Activar el perfil Django y verificar el autocompletado sin alterar los proyectos Python que no son Django.

## Out of scope
- Soporte para formatos de dependencias distintos de `requirements.txt` y PEP 621 `[project].dependencies`.
- Cambios a perfiles no Django o al flujo visual de selección.
