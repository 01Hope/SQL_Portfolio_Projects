-- Find the different properties that have made orders
SELECT DISTINCT("PropertyID")
FROM orders
ORDER BY "PropertyID";

-- Find the five least expensive products
SELECT "ProductName", "Price"
FROM products
ORDER BY "Price" DESC
LIMIT 5;

-- All properties in alphabetical order of their city names
SELECT "PropID", "PropertyCity"
FROM propertyinfo
ORDER BY "PropertyCity";

-- The name and category of the most expensive product
SELECT "ProductName", "ProductCategory","Price"
FROM products
WHERE "Price" = (SELECT MAX("Price") 
				FROM products);

-- The name and category of product whose price is $300
SELECT "ProductName", "ProductCategory"
FROM products
WHERE "Price" = 300;

-- Orders by properties that are not 14, 16, and 10
SELECT "OrderID", "PropertyID"
FROM orders
WHERE "PropertyID" NOT IN (14, 16, 10);

-- Total amount all products will be worth if there were just 5 of it in the store
SELECT SUM("Price")* 5 AS store_worth
FROM products;

-- What are the most purchased and least purchased product?

-- MOST PURCHASED PRODUCT:
SELECT "ProductID", SUM("Quantity") AS sum_qty
FROM orders
GROUP BY "ProductID"
ORDER BY sum_qty DESC
LIMIT 1;

-- LEAST PURCHASED PRODUCT:
SELECT "ProductID", SUM("Quantity") AS sum_qty
FROM orders
GROUP BY "ProductID"
ORDER BY sum_qty
LIMIT 1;

-- What is the average price of products for each product category?
SELECT "ProductCategory", ROUND(AVG("Price"), 2)
FROM products
GROUP BY "ProductCategory";

-- How many products are soaps?
SELECT "ProductName", COUNT("ProductID")
FROM products
WHERE "ProductName" ILIKE '%soap%'
GROUP BY "ProductName";

-- What is the average price of envelopes?
SELECT "ProductName", ROUND(AVG("Price"),2)
FROM products
WHERE "ProductName" ILIKE '%envelope%'
GROUP BY "ProductName";

-- What is the cheapest envelope?
SELECT "ProductName", "Price"
FROM products
WHERE "ProductName" ILIKE '%envelope%'
ORDER BY "Price"
LIMIT 1;

-- We want to find the average price of housekeeping products.
SELECT "ProductCategory", ROUND(AVG("Price"),2)
FROM products
WHERE "ProductCategory" ILIKE '%housekeeping%'
GROUP BY "ProductCategory";

-- Denis wants to stop selling products below $50. In a new column identify if Denis will stop selling a product or not .
SELECT "ProductName", "Price",
CASE
	WHEN "Price" < 50 THEN 'stop selling prodct'
	WHEN "Price" > 50 THEN 'continue selling product'
END AS product_status
FROM products;



