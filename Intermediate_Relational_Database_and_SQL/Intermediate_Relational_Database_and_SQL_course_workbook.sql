-- Task 3 -----------------------------------

SHOW DATABASES;

CREATE DATABASE temp_database;

DROP DATABASE temp_database;

CREATE DATABASE world_peace;


-- Task 4 -----------------------------------

USE world_peace;

CREATE TABLE temp_table (
item_id CHAR(10),
description VARCHAR(50),
unit_price int
); 

DROP TABLE temp_table;


CREATE TABLE merchandise_item(
	merchandise_item_id CHAR(10),
    description VARCHAR(50),
	unit_price int
	); 


-- Task 5 -----------------------------------

CREATE TABLE customer(
	customer_id CHAR(10) PRIMARY KEY,
    customer_name VARCHAR(50),
	unit_price int
	); 


-INSERT INTO customer
SET customer_id = "C000000001",
customer_name = "Harrison Kong";

INSERT INTO customer
SET customer_id = "C000000002",
customer_name = "John Doe";

INSERT INTO merchandise_item
SET
merchandise_item_id = "BAMBOOBOOK",
description = "Bamboo Notebook",
unit_price = 200;

INSERT INTO merchandise_item
SET
merchandise_item_id = "BAMBOOBOOK",
description = "Dragon Painting",
unit_price = 300;



UPDATE merchandise_item
SET merchandise_item_id = "DRAGON"
WHERE unit_price = 300;



ALTER TABLE merchandise_item
ADD CONSTRAINT
merchandise_item_pk
PRIMARY KEY(merchandise_item_id);


-- Task 6 -----------------------------------
CREATE INDEX description_idx
ON merchandise_item(description);

DROP INDEX description_idx
ON merchandise_item;

CREATE UNIQUE INDEX description_idx
ON merchandise_item(description);

INSERT INTO
merchandise_item
SET
merchandise_item_id = "THORSTATUE",
description = "Thor statue",
unit_price = 2500;


-- Task 7 -----------------------------------
CREATE TABLE customer_order (
customer_order_id CHAR(10) PRIMARY KEY,
customer_id CHAR(10),
FOREIGN KEY (customer_id)
REFERENCES customer(customer_id)
);

INSERT INTO 
customer_order
SET customer_order_id = "D123456789",
customer_id = "C123456789";

CREATE TABLE customer_order_line_item (
	customer_order_id CHAR(10),
    customer_id CHAR(10),
    merchandise_item_id CHAR(10),
    quantity int,
    PRIMARY KEY (customer_order_id,
	merchandise_item_id),
    FOREIGN KEY (customer_order_id)
    REFERENCES
    customer_order(customer_order_id)
    );
	
	
ALTER TABLE customer_order_line_item
ADD CONSTRAINT item_id_fk
FOREIGN KEY (merchandise_item_id)
REFERENCES merchandise_item
(merchandise_item_id);


-- EXAMPLE:

USE world_peace;

-- Let's create an order for Harrison

INSERT INTO customer_order
SET
customer_id = "C000000001",
customer_order_id = "D000000001";

-- Let's add some line items!!

INSERT INTO customer_order_line_item
SET
customer_order_id = "D000000001",
merchandise_item_id = "BAMBOOBOOK",
quantity = 4;

INSERT INTO customer_order_line_item
SET
customer_order_id = "D000000001",
merchandise_item_id = "DRAGONPTNG",
quantity = 2;

INSERT INTO customer_order_line_item
SET
customer_order_id = "D000000001",
merchandise_item_id = "THORSTATUE",
quantity = 1;

-- Let's add another order for Harrison!

INSERT INTO customer_order
SET
customer_id = "C000000001",
customer_order_id = "D000000002";

INSERT INTO customer_order_line_item
SET
customer_order_id = "D000000002",
merchandise_item_id = "BAMBOOBOOK",
quantity = 20;

INSERT INTO customer_order_line_item
SET
customer_order_id = "D000000002",
merchandise_item_id = "DRAGONPTNG",
quantity = 50;

INSERT INTO customer_order_line_item
SET
customer_order_id = "D000000002",
merchandise_item_id = "THORSTATUE",
quantity = 15;

-- Let's add an order for John Doe

INSERT INTO customer_order
SET
customer_id = "C000000002",
customer_order_id = "D000000003";

-- Let's add some line items!!

INSERT INTO customer_order_line_item
SET
customer_order_id = "D000000003",
merchandise_item_id = "DRAGONPTNG",
quantity = 1000;

INSERT INTO customer_order_line_item
SET
customer_order_id = "D000000003",
merchandise_item_id = "THORSTATUE",
quantity = 500;

-- This will link everything together!!

SELECT
customer.customer_name,
customer_order_line_item.customer_order_id,
merchandise_item.description,
customer_order_line_item.quantity,
merchandise_item.unit_price / 100 AS "unit_price_decimal",
customer_order_line_item.quantity * merchandise_item.unit_price / 100 AS "line_total"
FROM customer_order_line_item, customer_order, customer, merchandise_item
WHERE
customer_order_line_item.merchandise_item_id = merchandise_item.merchandise_item_id AND
customer_order.customer_id = customer.customer_id AND
customer_order_line_item.customer_order_id = customer_order.customer_order_id
ORDER BY
customer_name,
customer_order_line_item.customer_order_id,
merchandise_item.description

	