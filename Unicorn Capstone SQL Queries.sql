SELECT count(customer_id)
FROM customers

--795


SELECT shipping_city, SUM(order_profits) as p
FROM orders
JOIN  order_details ON orders.order_id = order_details.order_id
WHERE order_date like '%2015%'
Group By shipping_city 
ORDER BY p DESC;

--New York City 14753

Select COUNT(DISTINCT(shipping_city))
FROM orders;

--531

SELECT customer_id, SUM(order_sales) AS total_sales
FROM orders
JOIN order_details ON orders.order_id = order_details.order_id
GROUP BY customer_id
ORDER BY total_sales;

--546, 657

SELECT shipping_city, shipping_state, SUM(order_profits) as profit
FROM orders
JOIN  order_details ON orders.order_id = order_details.order_id
WHERE shipping_state = 'Tennessee'
GROUP by shipping_city
ORder by profit desc;

--Lebanon

SELECT shipping_city, shipping_state, avg(order_profits) as profit
FROM orders
JOIN order_details ON orders.order_id = order_details.order_id
WHERE shipping_state = 'Tennessee'
GROUP by shipping_city
Order by profit desc;

--27.67


SELECT COUNT(customer_segment) as Customer_type
FROM customers
WHERE customer_segment = 'Corporate';

--237

SELECT shipping_state, avg(order_profits) as pp,  product_category
FROM orders
JOIN order_details ON orders.order_id = order_details.order_id
JOIN product ON order_details.product_id = product.product_id 
WHERE shipping_state = 'Iowa'
GROUP By product_category
Order By pp DESC;

--Furniture

SELECT order_date, product_category, product_name, sum(quantity) as q
FROM orders
JOIN order_details ON orders.order_id = order_details.order_id
JOIN product ON order_details.product_id = product.product_id 
WHERE product_category = 'Furniture' AND order_date like '%2016%'
GROUP By product_name
ORDER By q DESC;

--Global Push Button Manager's Chair, Indigo


SELECT customer_id,
	SUM(order_sales / (1 - order_discount) - order_sales) AS total_discount
FROM orders
JOIN order_details ON orders.order_id = order_details.order_id
GROUP BY customer_id
ORDER BY total_discount DESC;

--687

WITH table_1 AS 
	(SELECT
		CAST(SUBSTR(order_date, INSTR(order_date,'/') -2,2) AS INT) AS month,
		SUM(order_profits) AS total_profit,
		SUBSTR(order_date, -4, 4) as year
	FROM orders
	JOIN order_details ON orders.order_id = order_details.order_id
	WHERE year = '2018'
	GROUP BY month),
table_2 AS
	(SELECT
		CAST(SUBSTR(order_date,INSTR(order_date,'/') -2,2) AS INT) AS month,
		LAG(SUM(order_profits), 1,0)
		OVER (ORDER BY SUBSTR(order_date,INSTR(order_date, '/') -2,2) ) AS previous_month,
		SUBSTR(order_date, -4, 4) as year
	FROM orders
	JOIN order_details ON orders.order_id = order_details.order_id
	WHERE year = '2018'
	GROUP BY month
	ORDER BY month)

SELECT table_1.month, ABS(table_1.total_profit)-ABS(table_2.previous_month) AS HD_Year
FROM table_1
JOIN table_2 ON table_1.month = table_2.month
ORDER BY HD_year DESC;

--13824


SELECT order_date, orders.order_id, SUM(order_sales) AS sales
FROM orders
JOIN order_details ON orders.order_id = order_details.order_id
WHERE order_date LIKE '%2015%'
GROUP BY orders.order_id
ORDER BY sales DESC;
--CA-2015-145317--



SELECT shipping_city,
	SUM(quantity) AS amt_ordered,
	RANK() OVER (ORDER BY SUM(quantity) DESC) AS rank
FROM orders
JOIN order_details ON orders.order_id = order_details.order_id
WHERE order_date LIKE '%2015%' AND shipping_region = 'East'
GROUP BY shipping_city;
--Columbus--



SELECT *

FROM customers

LEFT JOIN orders ON orders.customer_id = customers.customer_id

LEFT JOIN order_details ON order_details.order_id = orders.order_id

LEFT JOIN product ON product.product_id = order_details.product_id




