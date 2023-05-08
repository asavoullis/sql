-- 2356. Number of Unique Subjects Taught by Each Teacher
-- https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/


/*

Table: Teacher

+-------------+------+
| Column Name | Type |
+-------------+------+
| teacher_id  | int  |
| subject_id  | int  |
| dept_id     | int  |
+-------------+------+
(subject_id, dept_id) is the primary key (combinations of columns with unique values) of this table.
Each row in this table indicates that the teacher with teacher_id teaches the subject subject_id in the department dept_id.
 

Write a solution to calculate the number of unique subjects each teacher teaches in the university.

Return the result table in any order.

The result format is shown in the following example.

 

Example 1:

Input: 
Teacher table:
+------------+------------+---------+
| teacher_id | subject_id | dept_id |
+------------+------------+---------+
| 1          | 2          | 3       |
| 1          | 2          | 4       |
| 1          | 3          | 3       |
| 2          | 1          | 1       |
| 2          | 2          | 1       |
| 2          | 3          | 1       |
| 2          | 4          | 1       |
+------------+------------+---------+
Output:  
+------------+-----+
| teacher_id | cnt |
+------------+-----+
| 1          | 2   |
| 2          | 4   |
+------------+-----+
Explanation: 
Teacher 1:
  - They teach subject 2 in departments 3 and 4.
  - They teach subject 3 in department 3.
Teacher 2:
  - They teach subject 1 in department 1.
  - They teach subject 2 in department 1.
  - They teach subject 3 in department 1.
  - They teach subject 4 in department 1.
  
*/


SELECT teacher_id, count(distinct(subject_id)) AS cnt
FROM Teacher 
Group by teacher_id;


--
 select t.teacher_id, max(t.rn) as cnt from (
 select teacher_id, subject_id, row_number() over (partition by subject_id, teacher_id) as rn from teacher) t group by t.teacher_id; 

 select t2.teacher_id, count(t2.subject_id) as cnt 
   from (select t.teacher_id, t.subject_id, t.rn 
     from (select t.teacher_id, t.subject_id, row_number() over (partition by t.subject_id, t.teacher_id) as rn from teacher t order by t.teacher_id )) 
   where t.rn = 1) t2 
   group by t2.teacher_id;

select t3.teacher_id, count(t3.subject_id) as cnt from 
(select t2.teacher_id, t2.subject_id, t2.rn from 
(select t.teacher_id, t.subject_id, row_number() over (partition by t.subject_id, t.teacher_id) as rn from teacher t order by t.teacher_id) t2 where t2.rn = 1) t3 group by t3.teacher_id; 
--