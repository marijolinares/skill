SELECT u.id, u.email, u.created_at
FROM users u
WHERE u.status = 'active'
ORDER BY u.created_at DESC
LIMIT 100;
