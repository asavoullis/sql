---------------- MYSQL Concepts -----------------


-- https://www.coursera.org/learn/concepts-in-sql/

-- DML Commands (Data Maniuplation Language)

UPDATE items
SET price = 8.50
WHERE id = 11;

DELETE FROM customer
WHERE firstname = 'Emma';

--------------------------------
USE finances;

INSERT INTO accounts
(id, fullname, balance)
VALUES
(1, 'Emma Smith', 550)
(2, 'Clive Jonns', 22)
(4, 'Peter White', 200)

--------------------------------


START TRANSACTION;

-- CHECK SCENARIO 
SELECT 
	IF(balance > 0, balance, 0) AS FUNDS
FROM accounts
WHERE id=1 AND fullname = 'Emma Smith';

-- set what the transfer will be - how much money is going from one account to another
SET @TransferAmount = 50;

-- UPDATE the account TABLE
UPDATE accounts

-- set the balance column 
SET
	balance = balance - 50
WHERE id=1 AND fullname = 'Emma Smith';

-- do the exact same to add the money to the balance of the other person
UPDATE accounts
SET
	balance = balance + 50
WHERE id=4 AND fullname = 'Peter White';

---------- Checking
SELECT * from accounts 

COMMIT;

-- undo changes
ROLLBACK;



------------------------
-- Views
USE bookstore;


CREATE VIEW vw_books
AS 
SELECT booktitle, author
FROM items;


CREATE OR REPLACE VIEW vw_booksjkrowling
AS
SELECT booktitle, author
FROM items
WHERE author = 'JK Rowling';

SELECT * FROM vw_booksjkrowling;


CREATE OR REPLACE VIEW vw_books
AS
SELECT booktitle, price
FROM items;

SELECT DISTINCT booktitle, MAX(price) 
FROM vw_books
WHERE price > 8.50
GROUP BY booktitle;


------------------------------------
--Triggers
USE bookstore;

SELECT * FROM items;

-- Before we start our trigger we need to:
-- Change the delimiter ( how we end the statement )

-- whenever it seems // it will know that this is the end of all of the queries 
-- that we want to run for our Trigger
DELIMITER // 

CREATE TRIGGER iteminsert

BEFORE INSERT ON items

FOR EACH ROW

BEGIN
	SET NEW.booktitle = UPPER(NEW.booktitle);
END //

DELIMITER ;


INSERT INTO items
(id, booktitle, author, price)
VALUES
(23, 'test', 'testauthor', 8.50);


------------------------------------------
--EVENTS
USE bookstore;

CREATE TABLE information(
	id INT PRIMARY KEY AUTO_INCREMENT,
	info VARCHAR(255) NOT NULL,
	infoCreatedAt DATETIME NOT NULL
);


-- Every time we call this event on a schedule of the current datestamp
-- it's going to insert into our information table the values
-- FirstEvent for the info and the time at infoCreatedAt columns
CREATE EVENT IF NOT EXISTS eventOne
ON SCHEDULE AT CURRENT_TIMESTAMP()
DO
INSERT INTO information(info, infoCreatedAt)
VALUES('FirstEvent', NOW() );

-- Let's create another event but this time 
-- we want to be an interval of one minute 
-- so every time a minute occurs it's going to hit our event
CREATE EVENT IF NOT EXISTS eventTwo
ON SCHEDULE AT CURRENT_TIMESTAM() + INTERVAL 1 MINUTE
-- once an event expired, it would be automatically dropped
ON COMPLETION PRESERVE
DO 
INSERT INTO information(info, infoCreatedAt)
VALUES('SecondEvent', NOW());



SELECT * FROM information;









/*
----
QUIZ:

	1. Which of the following is not a data manipulation language (DML) command?
Transaction - A transaction is not a DML and is a transaction control language (TCL) command.
 
	2. What is a Transaction?
A sequential group of operations which is used to perform a single unit of work.
A transaction is a sequential group of operations which is performed as if it was one single unit of work. It will never be successful until each part of the work unit is completed successfully. So, if any operation within the transaction fails, the whole transaction will fail - this means that everything will revert back to its previous state. Refer back to lesson two to understand the meaning of a transaction.

	3. What is a view?
A View is a virtual table

	4. What is a Trigger
A trigger is a procedure that automatically involved when a special event occurs.

	5. What is one of the ways a trigger is useful?
A trigger is useful to execute a particular query when a certain event has occurred.
To execute a particular query when a certain event has occured.

	6. What is an event in SQL?
An event is tasks that execute according to a specified schedule.
An event are tasks that execute according to a specified schedule.
*/

-- https://www.coursera.org/programs/wpp-ai-academy-neo-world-huddu/projects/sql-functions