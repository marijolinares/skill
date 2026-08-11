SELECT *
FROM users
WHERE email = @email OR 1 = 1;

DELETE FROM orders;

UPDATE accounts
SET role = 'admin'
WHERE email LIKE '%';
