-- Which orders were made by property 14, 16, and 10?
SELECT *
FROM orders
WHERE "PropertyID" IN (14, 16, 10);


-- • What products have names starting with “T”?
SELECT "ProductName"
FROM products
WHERE "ProductName" LIKE 'T%';

-- • What is the average quantity of products bought by each property?
SELECT "PropertyID", AVG("Quantity")
FROM orders
GROUP BY "PropertyID";

-- • What is the total amount all products will be worth if there were just 2 of it in Denis store?
SELECT SUM("Price")*2 AS store_worth
FROM products;

-- • What is the most expensive and the least expensive product?
SELECT "ProductName", "Price"
FROM products
WHERE "Price" = (SELECT MAX("Price")
FROM products)

SELECT "ProductName", "Price"
FROM products
WHERE "Price" = (SELECT MIN("Price")
FROM products);


-- • Identify whether a product’s worth is more than $200 or not in a new column called ‘Price Category’
SELECT "ProductName", "Price",
CASE
	WHEN "Price" > 200 THEN 'worth more than $200'
	WHEN "Price" <= 200 THEN 'not worth more than $200'
END AS Price_Category
FROM products;


