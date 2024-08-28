SELECT * FROM Ecommerce.payments;

#3. Find the total sales per Category
SELECT UPPER(products.product_category) category, 
ROUND(SUM(payments.payment_value),2) sales
FROM products JOIN order_items 
ON products.product_id = order_items.product_id
JOIN payments
ON payments.order_id = order_items.order_id
group by category;

#4. Calculate the percentage of orders that were paid in installments.
SELECT SUM(CASE WHEN payment_installments >= 1 THEN 1 
ELSE 0 END) / COUNT(*)*100
FROM payments;

#15. Identify the top 3 customers who spent the most money in each year.
SELECT years, customer_id, payment, c_rank
FROM
(SELECT year(orders.order_purchase_timestamp) years,
orders.customer_id,
SUM(payments.payment_value)payment,
DENSE_RANK() OVER(PARTITION BY year(orders.order_purchase_timestamp)
ORDER BY SUM(payments.payment_value)desc)c_rank
FROM orders
JOIN payments
ON payments.order_id = orders.order_id
GROUP BY year(orders.order_purchase_timestamp),
orders.customer_id) AS a
WHERE c_rank <= 3; 
