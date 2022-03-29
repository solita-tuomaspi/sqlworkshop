CREATE TABLE city (
    zipcode CHAR(5) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    population INT NOT NULL CHECK (population >= 0)
);

CREATE TABLE customer (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    zipcode CHAR(5) REFERENCES city (zipcode)
);

CREATE TABLE product (
    code VARCHAR(5) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price NUMERIC(5, 2) NOT NULL CHECK (price >= 0)
);

CREATE TABLE customerorder (
    id INT PRIMARY KEY,
    customerid INT NOT NULL REFERENCES customer (id),
    time TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE orderitem (
    orderid INT NOT NULL REFERENCES customerorder (id),
    productcode CHAR(5) NOT NULL REFERENCES product (code),
    amount SMALLINT NOT NULL CHECK (amount >= 0),
    PRIMARY KEY (orderid, productcode)
);

INSERT INTO city VALUES
    ('33100', 'Tampere', 243538),
    ('00130', 'Helsinki', 653835),
    ('90100', 'Oulu', 207327),
    ('20100', 'Turku', 194981);

INSERT INTO customer(name, address, zipcode) VALUES
    ('Teppo Tamppaaja', 'Jokukatu 5', '33100'),
    ('Hannele Helle', 'Tietie 13', '00130'),
    ('Olli Osaaja', 'Luontopolku 99', '90100'),
    ('Tuula Tuunaaja', 'Kyläraitti 111', '20100'),
    ('Tiina Tuunaaja', 'Kyläraitti 111', '20100');

INSERT INTO product(code, name, description, price) VALUES
    ('113', 'Horror Energy SuperDuper', 'Terrific new version of the Horror Energy drink', 1.5),
    ('555', 'Cheapo Cookie', 'Cheap and good', 0.2),
    ('668', 'Luxurious Cookie', 'Expensive and ok', 5),
    ('777', 'Bun', 'Generic bun', 2),
    ('4444', 'SosaCola', 'The best cola drink', 4),
    ('42', 'TurboSalmiac', null, 13);

INSERT INTO customerorder VALUES
    (1, (SELECT id FROM customer WHERE name = 'Teppo Tamppaaja'), TIMESTAMP '2021-03-13 12:34:56'),
    (2, (SELECT id FROM customer WHERE name = 'Teppo Tamppaaja'), TIMESTAMP '2021-04-16 12:34:56'),
    (3, (SELECT id FROM customer WHERE name = 'Teppo Tamppaaja'), TIMESTAMP '2021-04-18 12:34:56'),
    (4, (SELECT id FROM customer WHERE name = 'Hannele Helle'), TIMESTAMP '2021-01-02 07:07:07'),
    (5, (SELECT id FROM customer WHERE name = 'Hannele Helle'), TIMESTAMP '2021-01-12 12:34:56'),
    (6, (SELECT id FROM customer WHERE name = 'Hannele Helle'), TIMESTAMP '2021-03-22 12:34:56'),
    (7, (SELECT id FROM customer WHERE name = 'Olli Osaaja'), TIMESTAMP '2021-04-27 12:34:56'),
    (8, (SELECT id FROM customer WHERE name = 'Tuula Tuunaaja'), TIMESTAMP '2021-04-13 12:34:56'),
    (9, (SELECT id FROM customer WHERE name = 'Tiina Tuunaaja'), TIMESTAMP '2021-04-14 12:34:56');

INSERT INTO orderitem VALUES
    (1, '113', 10),
    (1, '42', 2),
    (2, '555', 10),
    (2, '668', 1),
    (3, '42', 100),
    (4, '4444', 3),
    (5, '555', 7),
    (6, '42', 24),
    (6, '4444', 12),
    (6, '555', 2),
    (7, '113', 14),
    (8, '668', 20),
    (9, '555', 10),
    (9, '4444', 5);