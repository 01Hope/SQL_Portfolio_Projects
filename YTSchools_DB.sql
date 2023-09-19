-- View Tables
SELECT *
FROM courses;

SELECT *
FROM departments;

SELECT *
FROM scores;

-- Use SQL queries to extract the following:
-- • YtSchools would like to know their performance in terms of number of students enrolled in each department and each course. To help them, you are to find out:
-- ■ The number of students in each department.
SELECT  department, COUNT(DISTINCT student_id) AS number_of_students
FROM scores AS s
JOIN courses AS c
ON s.course = c.course_id
GROUP BY department;

-- ■ What are the names of the courses that have at least 4 students enrolled.
SELECT course_name, COUNT(DISTINCT student_id) AS number_of_students
FROM courses AS c
JOIN scores AS s
ON c.course_id = s.course
GROUP BY course_name
HAVING COUNT(student_id) >= 4;

-- 2. The Head of Operations at YTSchools will like to know the name of the department with the highest average score.
WITH avg_score_table AS
(SELECT "Department_Name", ROUND(AVG(score), 2) AS average_score
FROM scores AS s
JOIN courses AS c
ON s.course = c.course_id
JOIN departments AS d
ON c.department = d."Department_ID"
GROUP BY "Department_Name")

SELECT "Department_Name", average_score
FROM avg_score_table
WHERE average_score = (SELECT MAX(average_score)
					  FROM avg_score_table);

-- 3. YTSchools would like to know which departments do not have courses yet.
SELECT "Department_Name", "Department_ID"
FROM departments AS d
FULL JOIN courses AS c
ON d."Department_ID" = c.department
WHERE course_id IS NULL;

-- 4. YTSchools will like to know the courses offered by the ‘Power BI’ Department and the most performing student in these courses.
WITH pbi_performance AS
(SELECT "Department_ID", course_name, student_name, score
FROM departments AS d
JOIN courses AS c
ON d."Department_ID" = c.department
JOIN scores AS s
ON c.course_id = s.course
WHERE "Department_Name" = 'Power BI')

SELECT course_name, student_name, score
FROM pbi_performance
WHERE score IN (SELECT MAX(score)
				from pbi_performance
				GROUP BY course_name);

-- 5. If the pass mark is 70, how many students passed in each department.
SELECT department,
SUM(CASE
	WHEN score >= 70 THEN 1
	ELSE 0
END) AS pass_or_not
FROM courses AS c
JOIN scores AS s
ON c.course_id = s.course
GROUP BY department;

--Create a new table for teachers’ information in the YTSchools database.
CREATE TABLE teachers (
	teacher_id varchar(4) primary key,
	teacher_name varchar(50),
	sex varchar(1),
	teacher_salary bigint,
	teacher_course varchar(5),
	foreign key (teacher_course) references courses(course_id)
);

select * from teachers;

-- Using the .csv file Alice handed over to you, insert rows into the table.
-- Update the table relationships and show the updated Entity Relationship Diagram(ERD)(Although this has already been done when creating the table).
ALTER TABLE teachers
ADD CONSTRAINT 
teacher_course foreign key
(teacher_course) references courses(course_id);
