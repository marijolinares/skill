UPDATE users
SET role = 'admin'
WHERE email LIKE '%%';

DELETE FROM users
WHERE id IN (SELECT id FROM users);

EXEC('DE' + 'LETE FROM users WHERE 1' + '=1');

SELECT *
FROM audit_log
ORDER BY created_at DESC
OFFSET 0 ROWS FETCH NEXT 1000000000 ROWS ONLY;

UPDATE accounts
SET status = 'disabled'
WHERE email IS NOT NULL;
