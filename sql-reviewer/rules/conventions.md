# Reglas de convenciones

## Legibilidad

- Preferir nombres descriptivos para tablas, columnas, alias y CTEs.
- Marcar abreviaturas que dificulten entender la consulta cuando exista una opción más clara.
- Preferir listas explícitas de columnas sobre `SELECT *`.
- Preferir joins explícitos sobre joins con coma.

## Uso de NULL

- Usar `IS NULL` e `IS NOT NULL` en lugar de `= NULL` o `<> NULL`.
- Tener cuidado con `COALESCE`, `IFNULL`, `NVL` y funciones similares cuando oculten la semántica de nulos.

## Tipos de datos

- Marcar elecciones de tipo claramente débiles cuando el SQL las revele, como IDs en texto, campos tipo booleano guardados como cadenas libres o fechas manejadas como texto.
- Marcar casts inconsistentes que hagan la consulta más difícil de leer o razonar.

## Consistencia

- Señalar mayúsculas/minúsculas, estilo de alias o convenciones de nombres inconsistentes solo cuando afecten legibilidad o mantenibilidad.
- Mantener los hallazgos de convención con menor severidad que los de seguridad, salvo que también causen impacto de correctitud o rendimiento.
