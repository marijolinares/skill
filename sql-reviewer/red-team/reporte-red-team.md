# Reporte Red Team

## Objetivo probado

Repositorio objetivo: `https://github.com/KIRA21M/Skill.git`

Fecha de prueba: 2026-08-11

## Método

Se revisó el `SKILL.md`, `rules/security.md`, `rules/performance.md`, `rules/conventions.md`, ejemplos y pruebas del repositorio objetivo. Después se diseñaron entradas que cumplen superficialmente algunas reglas, pero siguen siendo peligrosas o ambiguas.

No se ejecutó SQL. La evaluación fue estática, con base en las reglas publicadas por el repositorio objetivo.

## Casos probados

### Caso 1: comodín total disfrazado

```sql
UPDATE users
SET role = 'admin'
WHERE email LIKE '%%';
```

Resultado esperado: `CRITICAL`, porque `LIKE '%%'` equivale a coincidir con todo y puede actualizar todos los usuarios.

Riesgo encontrado: el objetivo menciona `LIKE '%'` e `ILIKE '%'`, pero no deja explícitas variantes equivalentes como `LIKE '%%'`.

Corrección aplicada en nuestra skill: se agregó una regla para variantes equivalentes de coincidencia total.

### Caso 2: filtro con subconsulta que selecciona toda la tabla

```sql
DELETE FROM users
WHERE id IN (SELECT id FROM users);
```

Resultado esperado: `CRITICAL`, porque hay `WHERE`, pero el filtro elimina todos los IDs de la misma tabla.

Riesgo encontrado: la regla del objetivo cubre tautologías simples como `1 = 1`, `TRUE` y `col = col`, pero no documenta filtros equivalentes basados en subconsultas.

Corrección aplicada en nuestra skill: se agregó `id IN (SELECT id FROM misma_tabla)` como patrón de filtro no restrictivo.

### Caso 3: SQL destructivo partido en fragmentos

```sql
EXEC('DE' + 'LETE FROM users WHERE 1' + '=1');
```

Resultado esperado: `CRITICAL`, porque al unir las cadenas aparece un `DELETE` con tautología.

Riesgo encontrado: el objetivo cubre SQL dinámico con concatenación desde valores no confiables, pero no deja claro que también debe revisar concatenación constante que oculte una operación destructiva.

Corrección aplicada en nuestra skill: se agregó una regla para SQL dinámico armado por fragmentos constantes.

### Caso 4: límite enorme con sintaxis distinta a LIMIT

```sql
SELECT *
FROM audit_log
ORDER BY created_at DESC
OFFSET 0 ROWS FETCH NEXT 1000000000 ROWS ONLY;
```

Resultado esperado: `HIGH`, porque el límite existe, pero no es realmente restrictivo.

Riesgo encontrado: el objetivo menciona `LIMIT 1000000` o más, pero no documenta variantes como `FETCH NEXT`, `TOP` o paginaciones con topes enormes.

Corrección aplicada en nuestra skill: se agregó una regla para límites equivalentes excesivos por dialecto.

### Caso 5: filtro amplio en escritura

```sql
UPDATE accounts
SET status = 'disabled'
WHERE email IS NOT NULL;
```

Resultado esperado: `HIGH` o `CRITICAL`, según contexto, porque el filtro puede tocar casi todas las filas aunque exista `WHERE`.

Riesgo encontrado: el objetivo advierte sobre filtros siempre verdaderos, pero puede necesitar una regla más explícita para predicados muy amplios en DML.

Corrección aplicada en nuestra skill: se reforzó la regla que trata filtros de escritura amplios como riesgo de cambio masivo.

## Conclusión

La skill objetivo cubre bien casos básicos y algunos edge cases del PDF. Los principales huecos están en equivalencias semánticas: condiciones que no son literalmente `1 = 1` o `LIKE '%'`, pero tienen el mismo efecto práctico.
