CREATE OR REPLACE VIEW customer_value_report AS
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    co.country,
    ci.city,
    SUM(p.amount) AS total_paid,
    CASE
        WHEN SUM(p.amount) >= 200 THEN 'Platinum'
        WHEN SUM(p.amount) >= 100 THEN 'Gold'
        ELSE 'Silver'
    END AS customer_tier
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
GROUP BY c.customer_id, co.country, ci.city, c.first_name, c.last_name;