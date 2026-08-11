# Reglas de rendimiento

## Alcance

Usar estas reglas cuando la entrada sugiera costo de consulta, volumen de escaneo o una forma de plan deficiente.

## Hallazgos comunes

- `SELECT *` es al menos `LOW` y puede subir de severidad cuando la consulta es amplia o tiene joins.
- Falta de `LIMIT` o restricción equivalente en consultas exploratorias o de cara al usuario es un riesgo real cuando la consulta puede regresar muchas filas.
- Límites equivalentes excesivos, como `FETCH NEXT 1000000000 ROWS ONLY`, `TOP 1000000000` o paginaciones con topes enormes, deben tratarse como límites no restrictivos.
- Búsqueda con comodín inicial como `LIKE '%term'` normalmente impide usar índices y debe marcarse.
- Funciones o casts sobre columnas indexadas en predicados `WHERE` o `JOIN` pueden volver el predicado no sargable.
- Casts implícitos entre columnas unidas pueden causar planes lentos o evitar el uso de índices.
- `DISTINCT` grande, `ORDER BY` amplio y subconsultas innecesarias pueden agregar costo cuando el SQL ya escanea muchas filas.

## Guía de índices

- Sugerir un índice faltante solo cuando el predicado, join o columna de ordenamiento esté explícito en el SQL.
- Si se desconoce el esquema, cardinalidad o carga de trabajo, aclarar que el consejo sobre índices es condicional.
- Nunca afirmar que falta un índice específico cuando la entrada no muestra evidencia suficiente.

## Límites

- No adivinar el tamaño de las tablas.
- No afirmar que hay un cuello de botella solo por estilo.
- Si la consulta podría estar bien en una tabla pequeña, bajar la severidad o marcar la observación como condicional.
