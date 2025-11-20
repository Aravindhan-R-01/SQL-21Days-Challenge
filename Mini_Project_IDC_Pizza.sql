-- =====================================================
-- 					    PIZZA - MINI PROJECT
-- =====================================================

-- Q1. List all unique pizza categories (DISTINCT).
-- SELECT DISTINCT category FROM pizza_types;

-- Q2. Display pizza_type_id, name, and ingredients, replacing NULL 
-- ingredients with "Missing Data". Show first 5 rows.
-- SELECT pizza_type_id, name, COALESCE(ingredients, 'Missing Data') AS 
-- ingredients FROM pizza_types LIMIT 5;

-- Q3. Check for pizzas missing a price (IS NULL).
-- SELECT * FROM pizzas WHERE price IS NULL;

-- Q4. Orders placed on '2015-01-01'.
-- SELECT * FROM orders WHERE date = '2015-01-01';

-- Q5. List pizzas with price descending.
-- SELECT * FROM pizzas ORDER BY price DESC;

-- Q6. Pizzas sold in sizes 'L' or 'XL'.
-- SELECT * FROM pizzas WHERE size IN ('L', 'XL');

-- Q7. Pizzas priced between $15.00 and $17.00.
-- SELECT * FROM pizzas WHERE price BETWEEN 15.00 AND 17.00;

-- Q8. Pizzas with "Chicken" in the name.
-- SELECT * FROM pizza_types WHERE name LIKE '%Chicken%';

-- Q9. Orders on '2015-02-15' or placed after 8 PM.
-- SELECT * FROM orders WHERE date = '2015-02-15' OR time >= '20:00:00';

-- Q10. Total quantity of pizzas sold (SUM).
-- SELECT SUM(quantity) AS total_quantity_sold FROM order_details;

-- Q11. Average pizza price (AVG).
-- SELECT AVG(price) AS average_pizza_price FROM pizzas;

-- Q12. Total order value per order (JOIN, SUM, GROUP BY).
-- SELECT od.order_id, SUM(od.quantity * p.price) AS total_order_value FROM order_details AS od 
-- JOIN pizzas AS p ON od.pizza_id = p.pizza_id GROUP BY od.order_id ORDER BY od.order_id;

-- Q13. Total quantity sold per pizza category (JOIN, GROUP BY).
-- SELECT pt.category, SUM(od.quantity) AS total_quantity_sold FROM order_details AS od 
-- JOIN pizzas AS p ON od.pizza_id = p.pizza_id JOIN pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id 
-- GROUP BY pt.category ORDER BY total_quantity_sold DESC;

-- Q14. Categories with more than 5,000 pizzas sold (HAVING).
-- SELECT pt.category, SUM(od.quantity) AS total_quantity_sold FROM order_details AS od JOIN pizzas AS p 
-- ON od.pizza_id = p.pizza_id JOIN pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id GROUP BY pt.category 
-- HAVING SUM(od.quantity) > 5000 ORDER BY total_quantity_sold DESC;

-- Q15. Pizzas never ordered (LEFT/RIGHT JOIN).
-- SELECT p.pizza_id, p.size FROM pizzas AS p LEFT JOIN order_details AS od ON p.pizza_id = od.pizza_id WHERE od.order_details_id IS NULL;

-- Q16. Price differences between different sizes of the same pizza (SELF JOIN).
SELECT p1.pizza_type_id, p1.size AS size_lower, p2.size AS size_higher, p2.price - p1.price AS price_difference 
FROM pizzas AS p1 JOIN pizzas AS p2 ON p1.pizza_type_id = p2.pizza_type_id AND p1.price < p2.price 
ORDER BY p1.pizza_type_id, price_difference DESC;
