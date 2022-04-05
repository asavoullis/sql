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


*/

SELECT employee.name, employee.age
FROM employee
WHERE employee.salary > 30000;


-- Create a TABLE
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

INSERT INTO student VALUES(6, 'George', NULL');

-- selects everything from the student table (to check)
SELECT * FROM student;




