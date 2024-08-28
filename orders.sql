SELECT * FROM Ecommerce.orders;

#2. Count the number of Orders placed in 2017
SELECT COUNT(order_id)
FROM orders
WHERE year(order_purchase_timestamp) = 2017;

#6. Calculate the number of Orders per month in 2018.
SELECT monthname(order_purchase_timestamp) months, count(order_id) order_count
FROM orders 
WHERE year(order_purchase_timestamp) = 2018
GROUP BY months;

#11 Calculate the moving average of order values for each customer over their order history.
SELECT customer_id, order_purchase_timestamp,payment, 
AVG(payment) OVER(PARTITION BY customer_id ORDER BY order_purchase_timestamp 
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS mov_avg
FROM
(SELECT orders.customer_id, orders.order_purchase_timestamp,
payments.payment_value AS payment
FROM payments
JOIN orders
ON payments.order_id = orders.order_id) AS a;

