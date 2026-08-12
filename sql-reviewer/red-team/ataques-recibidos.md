# Ataques recibidos — evidencia de resistencia

## Ataque 1
Recibido de: compañero (equipo distinto)
Fecha: 2026-08-11

    DELETE FROM sessions
    WHERE expires_at IS NULL OR expires_at IS NOT NULL;

Análisis: expires_at solo puede ser NULL o NOT NULL, así que el WHERE siempre es verdadero
(tautología disfrazada, no literal 1=1).

Resultado obtenido: CRITICAL, cubierto por la regla existente en rules/security.md:
"DELETE o UPDATE con... un predicado equivalente que siempre sea verdadero es CRITICAL."

Pass/Fail: PASS — la skill resistió el ataque sin necesitar modificación.