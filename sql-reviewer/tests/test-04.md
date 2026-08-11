# Test 04

## Input

```
SELECT * FROM {{table}} WHERE id = ?;
```

## Expected behavior

Indicar que la entrada usa plantilla y que la skill no puede concluir comportamiento específico de tabla o dialecto sin más contexto.

## Actual behavior

La skill evita completar el placeholder, señala que el nombre de la tabla es desconocido y limita la revisión al fragmento SQL visible.

## Pass / Fail

Pass

## Problem detected

La redacción original podía tentar al revisor a inferir detalles de esquema faltantes.

## Modification made to the skill

Se reforzó el manejo de fallos en `SKILL.md` para rechazar esquema o carga de trabajo inventados.
