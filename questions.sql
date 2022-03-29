-- What products are the in the product table?
SELECT * FROM product;
-- Which products cost more than 2 euros?
SELECT * FROM product WHERE price > 2;
-- Which customer lives in an address with 'polku' in the name?
SELECT name FROM customer WHERE address LIKE '%polku%';
-- How many order were there in april 2021?
SELECT COUNT(*) FROM customerorder WHERE time >= '2021-04-01' and time < '2021-05-01';
SELECT COUNT(*) FROM customerorder WHERE time BETWEEN '2021-04-01' AND '2021-30-01';
-- Select only the latest order
SELECT * from customerorder ORDER BY time DESC LIMIT 1;
-- Join customers, orders, ordered products and product information in a query
SELECT c.name, cu.time, p.name, oi.amount, p.price
FROM customer c JOIN customerorder cu ON c.id = cu.customerid
JOIN orderitem oi ON cu.id = oi.orderid
JOIN product p ON oi.productcode = p.code;
-- Edit the previous query so that you count the total price of the order (price * amount)
SELECT c.name, cu.time, p.name, oi.amount * p.price
FROM customer c JOIN customerorder cu ON c.id = cu.customerid
JOIN orderitem oi ON cu.id = oi.orderid
JOIN product p ON oi.productcode = p.code;
-- Sum the total prices per order
SELECT c.name, cu.time, SUM(oi.amount * p.price) AS total
FROM customer c JOIN customerorder cu ON c.id = cu.customerid
JOIN orderitem oi ON cu.id = oi.orderid
JOIN product p ON oi.productcode = p.code
GROUP BY c.name, cu.time;
-- Filter out the results where the total order price is less than 50 euros
SELECT c.name, cu.time, SUM(oi.amount * p.price) AS total
FROM customer c JOIN customerorder cu ON c.id = cu.customerid
JOIN orderitem oi ON cu.id = oi.orderid
JOIN product p ON oi.productcode = p.code
GROUP BY c.name, cu.time
HAVING SUM(oi.amount * p.price) > 50;
-- Select the id and price with the biggest total price
WITH prices AS
(SELECT cu.id, SUM(oi.amount * p.price) AS total
FROM customerorder cu
JOIN orderitem oi ON cu.id = oi.orderid
JOIN product p ON oi.productcode = p.code
GROUP BY cu.id)
SELECT id, hinta FROM prices
WHERE hinta = (SELECT MAX(hinta) FROM prices);