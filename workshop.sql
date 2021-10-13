CREATE TABLE city ()
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
    code SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price NUMERIC(5, 2) NOT NULL CHECK (price >= 0)
);

CREATE TABLE order (
    id SERIAL PRIMARY KEY,
    customerid INT REFERENCES customer (id),
    time TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE orderitem (
    orderid INT REFERENCES order (id),
    productcode INT REFERENCES product (code),
    amount SMALLINT NOT NULL CHECK (amount >= 0),
    price NUMERIC(5, 2) NOT NULL CHECK (price => 0),
    PRIMARY KEY (orderid, productcode)
);