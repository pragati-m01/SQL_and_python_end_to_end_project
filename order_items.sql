SELECT * FROM Ecommerce.order_items;

#7. Find the average number of Products per order, grouped by customer city.
WITH count_per_order AS 
(SELECT orders.order_id, orders.customer_id,COUNT(order_items.order_id) AS oc
FROM orders JOIN order_items
ON orders.order_id= order_items.order_id
GROUP BY orders.order_id, orders.customer_id)

SELECT customers.customer_city, ROUND(AVG(count_per_order.oc),2) average_orders
FROM customers JOIN count_per_order
ON customers.customer_id = count_per_order.customer_id
GROUP BY customers.customer_city;

#8. Calculate the percentage of total revenue contributed by each product category.
SELECT UPPER(products.product_category) category, 
ROUND((SUM(payments.payment_value)/(SELECT SUM(payment_value) FROM payments))*100,2) sales_percentage
FROM products JOIN order_items 
ON products.product_id = order_items.product_id
JOIN payments 
ON payments.order_id = order_items.order_id
group by category ORDER BY sales_percentage DESC;