-- Mitä tuotteita tietokannan product-taulusta löytyy?
SELECT * FROM product;
-- Mitkä tuotteet maksavat yli 2 euroa?
SELECT * FROM product WHERE price > 2;
-- Kuka asiakkaista asuu osoitteessa, jonka nimessä on 'polku'?
SELECT name FROM customer WHERE address LIKE '%polku%';
-- Kuinka monta tilausta on tehty huhtikuussa 2021?
SELECT COUNT(*) FROM customerorder WHERE time >= '2021-04-01' and time < '2021-05-01';
SELECT COUNT(*) FROM customerorder WHERE time BETWEEN '2021-04-01' AND '2021-30-01';
-- Yhdistä asiakkaat, tilaukset ja tilausten tuotteet keskenään.
SELECT c.name, cu.time, p.name, oi.amount, p.price
FROM customer c JOIN customerorder cu ON c.id = cu.customerid
JOIN orderitem oi ON cu.id = oi.orderid
JOIN product p ON oi.productcode = p.code;
-- Muokkaa edellistä kyselyä siten, että lasket yhteen tuotteiden kokonaishinnan (eli hinta * kappalemäärä)
SELECT c.name, cu.time, p.name, oi.amount * p.price
FROM customer c JOIN customerorder cu ON c.id = cu.customerid
JOIN orderitem oi ON cu.id = oi.orderid
JOIN product p ON oi.productcode = p.code;
-- Summaa tämän jälkeen tilauskohtaiset kokonaishinnat
SELECT c.name, cu.time, SUM(oi.amount * p.price) AS hinta
FROM customer c JOIN customerorder cu ON c.id = cu.customerid
JOIN orderitem oi ON cu.id = oi.orderid
JOIN product p ON oi.productcode = p.code
GROUP BY c.name, cu.time;
-- Suodata tämän jälkeen kyselystä pois ne tilaukset, joiden hinta on alle 50 euroa.
SELECT c.name, cu.time, SUM(oi.amount * p.price) AS hinta
FROM customer c JOIN customerorder cu ON c.id = cu.customerid
JOIN orderitem oi ON cu.id = oi.orderid
JOIN product p ON oi.productcode = p.code
GROUP BY c.name, cu.time
HAVING SUM(oi.amount * p.price) > 50;
-- Valitse se id ja hinta, jonka hinta on suurin.
WITH summat AS
(SELECT cu.id, SUM(oi.amount * p.price) AS hinta
FROM customerorder cu
JOIN orderitem oi ON cu.id = oi.orderid
JOIN product p ON oi.productcode = p.code
GROUP BY cu.id)
SELECT id, hinta FROM summat
WHERE hinta = (SELECT MAX(hinta) FROM summat);