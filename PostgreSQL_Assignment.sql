--1.Database setup
-- create a database
create DATABASE university_db2

--2.Table creation
--Create a "students" table  
create table students(
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    frontend_mark INT NOT NULL,
    backend_mark INT NOT NULL,
    status VARCHAR(20) DEFAULT 'null'
)

--insert data into students table
INSERT INTO students(student_name,age,email,frontend_mark,backend_mark,status) 
VALUES
('Sameer',21,'sameer@example.com',48,60,'NULL'),
('Zoya',23,'zoya@example.com',52,58,'NULL'),
('Nabil',22,'nabil@example.com',37,46,'NULL'),
('Rafi',24,'rafi@example.com',41,40,'NULL'),
('Sophia',22,'sophia@example.com',50,52,'NULL'),
('Hasan',23,'hasan@gmail.com',43,39,'NULL');

select * from students;


--Create a "courses" table
 create table courses(
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL
 )

 --insert data into courses table
 INSERT INTO courses(course_name,credits)
 VALUES
 ('Next.js',3),('React.js',4),('Databases',3),('Prisma',3);

 select * from courses;

 --Create an "enrollment" table
 create table enrollment(
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    course_id INT,
    Foreign Key (course_id) REFERENCES courses(course_id)
 )

--insert data into enrollment table
INSERT INTO enrollment(student_id,course_id)
VALUES
(1,1),(1,2),(2,1),(3,2);

select * from enrollment;

--SQL queries 
--Query 1:Insert a new student record
INSERT INTO students(student_name,age,email,frontend_mark,backend_mark,status)
VALUES
('Tina',23,'tina@gmail.com',45,52,'NULL') 

--Query 2: Retrieve the names of all students who are enrolled in the course titled 'Next.js'.
--JOIN
SELECT s.student_name
 FROM enrollment e
 JOIN students s ON e.student_id = s.student_id
 WHERE course_id = 1

 --Query 3: Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.
  
 
UPDATE students
SET status = 'Awarded' 
WHERE(frontend_mark+backend_mark)=(
     SELECT MAX(frontend_mark + backend_mark)
    FROM students
); 

--Query 4: Delete all courses that have no students enrolled.
   
DELETE FROM courses
WHERE course_id NOT IN (SELECT course_id FROM enrollment);

-- Query 5: Retrieve the names of students using a limit of 2, starting from the 3rd student.
SELECT student_name
FROM students
ORDER BY student_id
LIMIT 2 OFFSET 2 ;

--Query 6: Retrieve the course names and the number of students enrolled in each course.
 SELECT c.course_name, COUNT(e.course_id) AS students_enrolled
FROM enrollment e
JOIN courses c ON e.course_id = c.course_id
GROUP BY c.course_name;

--Query 7: Calculate and display the average age of all students.
SELECT ROUND(AVG(age)) AS average_age
FROM students 

--Query 8; Retrieve the names of students whose email addresses contain 'example.com'.
SELECT student_name
FROM students 
WHERE email ILIKE '%example.com'
ORDER BY student_id;
