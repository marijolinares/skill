# Reglas de seguridad

## Alcance

Tratar estas reglas con prioridad de seguridad. Si una sentencia parece destructiva o explotable, preferir la interpretación más segura a menos que la entrada demuestre lo contrario.

## Condiciones críticas

- `DELETE` sin `WHERE` es `CRITICAL`.
- `UPDATE` sin `WHERE` es `CRITICAL`.
- `DELETE` o `UPDATE` con una tautología como `1 = 1`, `TRUE` o un predicado equivalente que siempre sea verdadero es `CRITICAL`.
- `DROP`, `TRUNCATE`, `ALTER TABLE ... DROP` o DDL destructivo similar es `CRITICAL`, salvo que la entrada demuestre explícitamente un contexto de migración seguro.
- SQL dinámico construido con concatenación, interpolación o entrada de usuario sin parametrizar es `HIGH` o `CRITICAL`, según qué tan directamente pueda abusarse.

## Patrones de inyección y evasión

- Marcar concatenación de cadenas dentro del texto de consulta cuando parezca combinar SQL con valores controlados por el usuario.
- Marcar `EXEC`, `sp_executesql`, `PREPARE`, `EXECUTE IMMEDIATE` concatenados o ejecución dinámica similar.
- Marcar predicados que evaden filtros deliberadamente, como `OR 1 = 1`, `LIKE '%'` o patrones equivalentes que coinciden con todo en sentencias de escritura.
- Marcar variantes equivalentes de coincidencia total, por ejemplo `LIKE '%%'`, `ILIKE '%%'`, `id IN (SELECT id FROM misma_tabla)` o condiciones que no reducen el conjunto de filas.
- Marcar SQL dinámico armado por fragmentos constantes cuando al unirlos forma una operación destructiva o una tautología.
- Si un filtro puede tocar la mayoría de las filas y la sentencia permite escritura, tratarlo como riesgo de cambio masivo.

## Límites

- No recomendar ejecutar SQL destructivo.
- No inferir parametrización solo por puntuación.
- Si el texto de la consulta está incompleto o usa plantillas, decir qué falta antes de juzgarlo seguro.

## Formalized decisions

Ejemplos de reglas expresadas en formato IF/THEN, para que cada decisión de severidad sea reproducible y no dependa de interpretación libre:

```
IF statement = DELETE OR UPDATE
AND WHERE is absent
THEN severity = CRITICAL
AND do not recommend executing the statement

IF WHERE contains a tautology (e.g. 1=1, TRUE, LIKE '%', LIKE '%%')
AND statement = DELETE OR UPDATE
THEN severity = CRITICAL
AND flag as "filter does not restrict rows"

IF query has no LIMIT (or equivalent: TOP, FETCH NEXT)
AND query can return many rows
THEN severity = MEDIUM or HIGH
AND recommend adding a row limit
```