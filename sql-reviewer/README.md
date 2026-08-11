# Skill SQL Reviewer

Este repositorio define una skill reutilizable para revisar SQL mediante análisis estático.

## Estructura

- `SKILL.md` - comportamiento principal, reglas de activación, formato de salida y validación.
- `rules/` - reglas deterministas de seguridad, rendimiento y convenciones.
- `examples/` - entradas SQL de ejemplo para casos válidos, inválidos y límite.
- `tests/` - casos de prueba en Markdown con comportamiento esperado y real.
- `red-team/` - reporte de pruebas Red Team contra el repositorio objetivo.

## Notas

- La fase Red Team se realizó contra `https://github.com/KIRA21M/Skill.git`, según la instrucción recibida.
- La skill está diseñada para evitar adivinar esquema, carga de trabajo o contexto de negocio faltante.
