# Test 03

## Input

`examples/edge-cases.sql`

## Expected behavior

Marcar la búsqueda con comodín inicial como problema de rendimiento y evitar inventar una recomendación de índice para el join sin contexto de esquema.

## Actual behavior

El predicado `LIKE '%@example.com'` se marca como riesgo de rendimiento. El join se menciona como potencialmente costoso, pero no se hace una afirmación de índice sin sustento.

## Pass / Fail

Pass

## Problem detected

El primer borrador no hacía suficientemente explícita la búsqueda con comodín inicial.

## Modification made to the skill

Se agregó `LIKE '%term'` como patrón de rendimiento nombrado en `rules/performance.md`.
