SELECT * FROM Ecommerce.customers;

#1. List of all Unique Cities where customers are located
SELECT DISTINCT customer_city FROM customers;

#5. Count the number of customers from each state
SELECT customer_state, COUNT(customer_id)
FROM customers
GROUP BY customer_state;

#14. Calculate the retention rate of customers, defined as the percentage of customers who make another purchase within 6 months
#of their first purchase.
WITH a AS(SELECT customers.customer_id, 
MIN(orders.order_purchase_timestamp) first_order
FROM customers 
JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id),
b AS(SELECT a.customer_id, COUNT(DISTINCT orders.order_purchase_timestamp) 
FROM a 
JOIN orders
ON orders.customer_id = a.customer_id
AND orders.order_purchase_timestamp > first_order
AND orders.order_purchase_timestamp < 
DATE_ADD(first_order, interval 6 month)
GROUP BY a.customer_id)

SELECT 100 * (COUNT(DISTINCT a.customer_id)/ COUNT(DISTINCT b.customer_id))
FROM a 
LEFT JOIN b
ON A.customer_id = b.customer_id;

