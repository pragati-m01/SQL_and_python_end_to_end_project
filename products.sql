SELECT * FROM Ecommerce.products;

#9 Identify the correlation between product price and the number of times a product has been purchased.
SELECT products.product_category, COUNT(order_items.product_id), 
ROUND(AVG(order_items.price),2)
FROM products 
JOIN order_items
ON products.product_id = order_items.product_id
GROUP BY products.product_category;


