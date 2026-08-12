# Reporte Red Team — objetivo: IRVINISAEL/sql-reviewer-skill

## Objetivo probado
Repositorio: https://github.com/IRVINISAEL/sql-reviewer-skill
Fecha: 2026-08-11

## Método
Se leyeron SKILL.md, rules/security.md y rules/performance.md del repositorio objetivo,
y se diseñaron entradas que cumplen su letra literal pero evaden el resultado esperado.

## Caso 1: SQL dinámico armado con constantes (sin variable)

    EXEC('DE' + 'LETE FROM users WHERE 1' + '=1');

Resultado esperado: CRITICAL, porque al unir los fragmentos aparece un DELETE con tautología.
Riesgo encontrado: SEC-03 del objetivo exige explícitamente que la concatenación involucre
"una variable". Aquí son solo strings constantes, así que SEC-03 no se dispara, y SEC-01/SEC-02
tampoco evalúan el SQL ya ensamblado dentro del EXEC.
Severidad obtenida en la práctica: ninguna regla lo cubre de forma clara.

## Caso 2: límite gigante con sintaxis FETCH NEXT en vez de LIMIT

    SELECT * FROM audit_log
    ORDER BY created_at DESC
    OFFSET 0 ROWS FETCH NEXT 1000000000 ROWS ONLY;

Resultado esperado: HIGH, porque el límite existe pero no es funcionalmente restrictivo.
Riesgo encontrado: PERF-02 no se activa porque exige ausencia de LIMIT/TOP/FETCH FIRST, y aquí
hay un FETCH NEXT. PERF-03 solo revisa "LIMIT clause" de forma literal, sin cubrir FETCH NEXT/
FETCH FIRST/TOP. El límite gigante pasa sin marcarse.

## Conclusión
El repositorio objetivo usa un formato IF/THEN muy sólido y bien formalizado, con reglas
generalizadas por intención (ver test-05 de su repo). Los huecos encontrados están en cobertura
de sinónimos sintácticos (variantes de LIMIT) y en el alcance de "variable" en SEC-03, que
excluye concatenación de literales constantes.