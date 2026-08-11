# Test 06

## Input

`examples/red-team-target.sql`

## Expected behavior

La skill debe detectar los patrones Red Team diseñados contra `https://github.com/KIRA21M/Skill.git`: comodín total disfrazado, subconsulta que selecciona toda la misma tabla, SQL destructivo partido en fragmentos, límite enorme con sintaxis distinta a `LIMIT` y filtro amplio en una sentencia de escritura.

## Actual behavior

Las reglas de seguridad y rendimiento fueron actualizadas para cubrir esos patrones. El reporte Red Team documenta el objetivo probado, el riesgo detectado y la corrección aplicada.

## Pass / Fail

Pass

## Problem detected

Las reglas originales podían centrarse demasiado en patrones literales como `LIKE '%'`, `1 = 1` y `LIMIT 1000000`, dejando fuera variantes equivalentes.

## Modification made to the skill

Se agregaron `examples/red-team-target.sql`, `red-team/reporte-red-team.md` y reglas explícitas para coincidencia total equivalente, subconsultas no restrictivas, SQL dinámico partido y límites enormes con sintaxis alternativa.
