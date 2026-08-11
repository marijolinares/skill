SELECT id, name
FROM customers
WHERE email LIKE '%@example.com'
ORDER BY created_at DESC
LIMIT 50;

SELECT o.id, o.total
FROM orders o
JOIN order_items i ON i.order_id = o.id
WHERE o.created_at >= CURRENT_DATE - INTERVAL '30 days';
