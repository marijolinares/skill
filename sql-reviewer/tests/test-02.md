# Test 02

## Input

`examples/invalid.sql`

## Expected behavior

Reportar al menos un hallazgo `CRITICAL` por `DELETE FROM orders;`, un hallazgo de seguridad por `WHERE email = @email OR 1 = 1` y un hallazgo de actualización masiva destructiva por `LIKE '%'`.

## Actual behavior

`DELETE FROM orders;` es `CRITICAL`. El predicado tautológico es `CRITICAL`. El patrón de actualización también es `HIGH` o `CRITICAL` porque puede actualizar filas de forma masiva.

## Pass / Fail

Pass

## Problem detected

El borrador inicial necesitaba una regla más clara para predicados tautológicos en sentencias de escritura.

## Modification made to the skill

Se ajustó `rules/security.md` para tratar predicados siempre verdaderos como `CRITICAL` en SQL con capacidad de escritura.
