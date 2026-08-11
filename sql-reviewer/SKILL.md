---
name: sql-reviewer
description: Revisa sentencias o scripts SQL por seguridad, rendimiento y convenciones; úsala para detectar operaciones destructivas, riesgo de inyección, filtros o límites faltantes, mal uso de NULL, índices potenciales y criterios explícitos de revisión.
---

# SQL Reviewer

## Purpose

Revisar SQL de forma determinista. No ejecutar el SQL. No inventar esquema, conteos de filas, índices ni intención de negocio cuando no estén en la entrada.

## When to activate

Usar esta skill cuando el usuario pida revisar, auditar, criticar, endurecer o calificar sentencias SQL, archivos de consultas, scripts de migración, procedimientos almacenados o fragmentos de base de datos.

## When NOT to activate

No usar esta skill para preguntas generales de arquitectura de bases de datos que no incluyan SQL para revisar, para optimización sin texto SQL, ni para tareas que dependan de resultados de ejecución en lugar de análisis estático.

## Inputs

- Una o más sentencias SQL, o un archivo de script.
- Dialecto, esquema, carga de trabajo o tamaño de tablas, si el usuario lo proporciona.
- Criterios de aceptación adicionales, si el usuario los proporciona.

Si falta contexto, indicarlo en lugar de adivinar.

## Procedure

1. Separar la entrada en sentencias y revisar cada una por separado.
2. Identificar el dialecto solo si está declarado o claramente implícito en el SQL.
3. Revisar primero reglas de seguridad, luego rendimiento y al final convenciones.
4. Citar el fragmento exacto que activó cada hallazgo.
5. Clasificar cada hallazgo con un solo nivel de severidad.
6. Si aplican varias reglas, conservar la severidad más alta y explicar el impacto principal.
7. Si la evidencia es insuficiente, reportar qué falta y no forzar una conclusión.

## Rules

- Seguir [rules/security.md](rules/security.md), [rules/performance.md](rules/performance.md) y [rules/conventions.md](rules/conventions.md).
- Preferir razonamiento explícito y reproducible sobre consejos generales.
- Nunca asumir que una sentencia sin `WHERE` es segura.
- Nunca asumir que una consulta sin `LIMIT` es inofensiva cuando puede regresar muchos registros.
- Nunca asumir que existe un índice si la entrada no lo demuestra.
- No recomendar ejecutar SQL destructivo.
- Si dos reglas entran en conflicto, elegir la interpretación más segura y explicar por qué.

## Severity levels

- `CRITICAL`: destructivo, inseguro o claramente explotable.
- `HIGH`: probable daño mayor, actualización masiva o exposición seria de seguridad.
- `MEDIUM`: problema relevante de correctitud o rendimiento que probablemente importa.
- `LOW`: problema real pero limitado, normalmente de legibilidad o eficiencia menor.
- `INFO`: sugerencia, nota de estilo u observación dependiente del contexto.

## Expected output

Devolver un resumen corto y después una lista de hallazgos. Cada hallazgo debe incluir:

- Severidad
- Sentencia o fragmento
- Por qué importa
- Cambio recomendado

Si no hay problemas, decirlo explícitamente.

## Validation

- Cada hallazgo debe citar un fragmento SQL concreto.
- No afirmar que falta un índice, que hay un problema de cantidad de filas o que existe un cuello de botella sin evidencia.
- No inventar semántica de tablas ni intención de la aplicación.
- Si el dialecto no está claro, evitar recomendaciones específicas de un motor.

## Failure handling

- Si el SQL está mal formado, indicar dónde falló el análisis.
- Si la información es insuficiente, indicar qué falta y qué no se puede concluir.
- Si el script mezcla dialectos, separar los hallazgos por sentencia y señalar la incertidumbre.
- Si la entrada contiene placeholders como `{{table}}` o `?`, no completarlos mentalmente.
