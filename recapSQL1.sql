-- MySQL is a Relation Database System (RDBS)

/*Revision:*/

/*Basic common Data Types:

INT                --WHOLE NUMBERS
DECIMAL(M,N)       --Decimal Numbers - Exact VALUE   
      M = total digits , N = number of digits after the decimal place
VARCHAR(1)         --String of text of length 1
BLOB               --Binary Large Object, Stores Large Data
DATE               --'YYYY-MM-DD'
TIMESTAMP          --'YYYY-MM-DD HH:MM:SS' used for recording

https://www.youtube.com/watch?v=HXV3zeQKqGY
*/

SELECT employee.name, employee.age
FROM employee
WHERE employee.salary > 30000;


---  Create a TABLE   with constraints
CREATE TABLE student (
	student_id INT PRIMARY KEY,
	name VARCHAR(20),
	major VARCHAR(20)
);


-- Primary Key is both NOT NULL & UNIQUE

-- Create a TABLE example2
CREATE TABLE student (
	student_id INT,
	name VARCHAR(20),
	major VARCHAR(20),
	PRIMARY KEY(student_id)
);

-- Create a TABLE example3, not null and unique
CREATE TABLE student (
	student_id INT,
	name VARCHAR(20) NOT NULL,
	major VARCHAR(20) UNIQUE,
	PRIMARY KEY(student_id)
);





-- Create a TABLE example4, default
CREATE TABLE student (
	student_id INT,
	name VARCHAR(20) NOT NULL,
	major VARCHAR(20) DEFAULT 'undecided',
	PRIMARY KEY(student_id)
);


INSERT INTO student(student_id, name) VALUES(7, 'Ben');



-- Create a TABLE example5, AUTO_INCREMENT
CREATE TABLE student (
	student_id INT  AUTO_INCREMENT,
	name VARCHAR(20) NOT NULL,
	major VARCHAR(20) DEFAULT 'undecided',
	PRIMARY KEY(student_id)
);

INSERT INTO student(name, major) VALUES('Claire', 'Chemistry');
INSERT INTO student(name, major) VALUES( 'Katie', 'History');



-- pull info on the fields of the table
DESCRIBE student;



--- Delete and Modify the TABLE

-- delete table
DROP TABLE student;

-- delete 1 Column
ALTER TABLE student DROP COLUMN gpa;

-- modify the table, add another column named gpa of type decimal
ALTER TABLE student ADD gpa DECIMAL(3,2);
-- 3 total digits, 2 after the decimal place



--- Inserting data into database tables

-- inserts the values into the student DB
INSERT INTO student VALUES(1, 'Jack', 'Biology');

INSERT INTO student VALUES(2, 'Kate', 'Sociology');

-- inserts only into the 2 columns of the DB
-- her major is NULL 
INSERT INTO student(student_id, name) VALUES(3, 'Claire');

INSERT INTO student VALUES(4, 'Jack', 'Biology');

INSERT INTO student VALUES(5, 'Mike', 'Computer Science');

INSERT INTO student VALUES(6, 'George', NULL);

-- selects everything from the student table (to check)
SELECT * FROM student;



-- Updating entries in the DB
SELECT * FROM student;

-- set the entries of Biology to Bio in the Major Column
UPDATE student
SET major = 'Bio'
WHERE major = 'Biology'


-- update for an exact student_id
UPDATE student
SET major = 'Bio'
WHERE student_id = 4;


-- update 2 entries of a column
UPDATE student
SET major = 'BioChemistry'
WHERE major = 'Bio' OR major = 'Chemistry';


-- set the name to TOM and the major to undecided for the student_id = 1
update student
SET name = 'Tom'. major = 'undecided'
WHERE student_id = 1;


-- Update all of the entries of the column major from the Table
UPDATE student
SET major = 'undefined';



-- Deleting from DB

-- deletries the entries of the row with student_id = 5 
DELETE FROM student
WHERE student_id = 5;


-- deletries the entries of the row with student_id = 5 
DELETE FROM student
WHERE name = 'Tom' AND major = 'undecided';

-- delete everything
DELETE FROM student;


-- Select every column from the student table 
SELECT * 
FROM student;

-- select all of the names of the student table 
SELECT named
FROM student;

-- just to make sure which table(DB) the name is comming from
SELECT student.name, studnet.major
FROM student;



--- Ordering
SELECT student.name, studnet.major
FROM student
ORDER BY name;


-- Ordering descending
SELECT student.name, studnet.major
FROM student
ORDER BY name DESC;


-- Ordering by another column
SELECT student.name, studnet.major
FROM student
ORDER BY student_id DESC;

-- Ordering by another column ascending
SELECT student.name, studnet.major
FROM student
ORDER BY student_id ASC;


-- Ordering by 2 columns, by major first then student_id
SELECT *
FROM student
ORDER BY major, student_id;



--- Limit the results we get
SELECT *
FROM student
Limit 2;


--- Ordering and Limit
SELECT student.name, studnet.major
FROM student
ORDER BY student_id DESC;
LIMIT 2;


--- Filtering
SELECT *
FROM student
WHERE major = 'Biology';


-- Filtering only get selected columns 
SELECT name, major
FROM student
WHERE major = 'Biology';


-- Filtering
SELECT name, major
FROM student
WHERE major = 'Biology' OR major = 'Chemistry';


-- Filtering in 2 columns 
SELECT name, major
FROM student
WHERE major = 'Biology' OR name = 'Kate';


/*
Comparisson Operators
<, >, <=, >=, =, <>, AND, OR, NOT

*/


-- Not equal to Biology
SELECT name, major
FROM student
WHERE major <> 'Biology';


-- get all records with student_id less than 3
SELECT *
FROM student
WHERE student_id < 3;

-- get all records with student_id less than 3 and name is not Jack
SELECT *
FROM student
WHERE student_id < 3 and name <> 'Jack';



-- IN  - where the name is in this group of values
SELECT *
FROM student
WHERE name IN ('Claire', 'Kate', 'Mike');







