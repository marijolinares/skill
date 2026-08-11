# Test 05

## Input

```
EXEC('UP' + 'DATE users SET role = ''admin'' WHERE ''a'' = ''a''');
```

## Expected behavior

Tratar el SQL dinámico concatenado como un problema serio de seguridad y marcar el patrón de predicado siempre verdadero.

## Actual behavior

La construcción de SQL dinámico se marca como `HIGH` o `CRITICAL`, y la condición tautológica se trata como insegura.

## Pass / Fail

Pass

## Problem detected

El primer borrador necesitaba un ejemplo más claro de SQL dinámico para entradas adversariales.

## Modification made to the skill

Se amplió `rules/security.md` para cubrir explícitamente sentencias concatenadas estilo `EXEC` y patrones de evasión.
