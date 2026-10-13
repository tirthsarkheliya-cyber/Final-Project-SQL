
mysql> CREATE DATABASE IF NOT EXISTS UniversityDB;
Query OK, 1 row affected (0.38 sec)

mysql> USE UniversityDB;
Database changed
mysql>
mysql> CREATE TABLE Departments (
    ->     DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    ->     DepartmentName VARCHAR(100) NOT NULL
    -> );
Query OK, 0 rows affected (0.47 sec)

mysql> CREATE TABLE Students (
    ->     StudentID INT PRIMARY KEY AUTO_INCREMENT,
    ->     FirstName VARCHAR(50) NOT NULL,
    ->     LastName VARCHAR(50) NOT NULL,
    ->     Email VARCHAR(100) UNIQUE NOT NULL,
    ->     BirthDate DATE,
    ->     EnrollmentDate DATE NOT NULL
    -> );
Query OK, 0 rows affected (0.06 sec)

mysql> CREATE TABLE Courses (
    ->     CourseID INT PRIMARY KEY AUTO_INCREMENT,
    ->     CourseName VARCHAR(100) NOT NULL,
    ->     DepartmentID INT,
    ->     Credits INT DEFAULT 3,
    ->     FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) ON DELETE SET NULL
    -> );
Query OK, 0 rows affected (0.45 sec)

mysql> CREATE TABLE Instructors (
    ->     InstructorID INT PRIMARY KEY AUTO_INCREMENT,
    ->     FirstName VARCHAR(50) NOT NULL,
    ->     LastName VARCHAR(50) NOT NULL,
    ->     Email VARCHAR(100) UNIQUE NOT NULL,
    ->     Salary DECIMAL(10, 2),
    ->     DepartmentID INT,
    ->     FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) ON DELETE SET NULL
    -> );
Query OK, 0 rows affected (0.06 sec)

mysql> CREATE TABLE Enrollments (
    ->     EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    ->     StudentID INT NOT NULL,
    ->     CourseID INT NOT NULL,
    ->     EnrollmentDate DATE NOT NULL,
    ->     FOREIGN KEY (StudentID) REFERENCES Students(StudentID) ON DELETE CASCADE,
    ->     FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE
    -> );
Query OK, 0 rows affected (0.38 sec)

mysql> INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
    -> (1, 'Computer Science'),
    -> (2, 'Mathematics'),
    -> (3, 'Physics');
Query OK, 3 rows affected (0.02 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Students (StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate) VALUES
    -> (1, 'John', 'Doe', 'john.doe@example.com', '2001-05-15', '2021-08-20'),
    -> (2, 'Jane', 'Smith', 'jane.smith@example.com', '2002-11-23', '2023-01-10'),
    -> (3, 'Alice', 'Brown', 'alice.brown@example.com', '2000-02-10', '2020-09-01'),
    -> (4, 'Bob', 'White', 'bob.white@example.com', '2003-07-19', '2024-02-15');
Query OK, 4 rows affected (0.01 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Courses (CourseID, CourseName, DepartmentID, Credits) VALUES
    -> (101, 'Introduction to SQL', 1, 4),
    -> (102, 'Data Structures', 1, 4),
    -> (103, 'Linear Algebra', 2, 3),
    -> (104, 'Calculus I', 2, 3),
    -> (105, 'Quantum Mechanics', 3, 4);
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Instructors (InstructorID, FirstName, LastName, Email, Salary, DepartmentID) VALUES
    -> (1, 'Alice', 'Johnson', 'alice.johnson@example.com', 85000.00, 1),
    -> (2, 'Bob', 'Lee', 'bob.lee@example.com', 92000.00, 1),
    -> (3, 'Charlie', 'Davis', 'charlie.davis@example.com', 78000.00, 2);
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, EnrollmentDate) VALUES
    -> (1, 1, 101, '2021-08-21'),
    -> (2, 1, 102, '2021-08-22'),
    -> (3, 2, 102, '2023-01-11'),
    -> (4, 3, 101, '2020-09-02'),
    -> (5, 3, 102, '2020-09-03');
Query OK, 5 rows affected (0.07 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Students (FirstName, LastName, Email, BirthDate, EnrollmentDate)
    -> VALUES ('Charlie', 'Green', 'charlie.green@example.com', '2002-04-12', '2023-08-15');
Query OK, 1 row affected (0.01 sec)

mysql> SELECT * FROM Students;
+-----------+-----------+----------+---------------------------+------------+----------------+
| StudentID | FirstName | LastName | Email                     | BirthDate  | EnrollmentDate |
+-----------+-----------+----------+---------------------------+------------+----------------+
|         1 | John      | Doe      | john.doe@example.com      | 2001-05-15 | 2021-08-20     |
|         2 | Jane      | Smith    | jane.smith@example.com    | 2002-11-23 | 2023-01-10     |
|         3 | Alice     | Brown    | alice.brown@example.com   | 2000-02-10 | 2020-09-01     |
|         4 | Bob       | White    | bob.white@example.com     | 2003-07-19 | 2024-02-15     |
|         5 | Charlie   | Green    | charlie.green@example.com | 2002-04-12 | 2023-08-15     |
+-----------+-----------+----------+---------------------------+------------+----------------+
5 rows in set (0.00 sec)

mysql> UPDATE Students
    -> SET Email = 'john.doe_updated@example.com'
    -> WHERE StudentID = 1;
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> DELETE FROM Students
    -> WHERE StudentID = 4;
Query OK, 1 row affected (0.01 sec)

mysql> SELECT *
    -> FROM Students
    -> WHERE YEAR(EnrollmentDate) > 2022;
+-----------+-----------+----------+---------------------------+------------+----------------+
| StudentID | FirstName | LastName | Email                     | BirthDate  | EnrollmentDate |
+-----------+-----------+----------+---------------------------+------------+----------------+
|         2 | Jane      | Smith    | jane.smith@example.com    | 2002-11-23 | 2023-01-10     |
|         5 | Charlie   | Green    | charlie.green@example.com | 2002-04-12 | 2023-08-15     |
+-----------+-----------+----------+---------------------------+------------+----------------+
2 rows in set (0.01 sec)

mysql>
mysql> SELECT c.*
    -> FROM Courses c
    -> JOIN Departments d ON c.DepartmentID = d.DepartmentID
    -> WHERE d.DepartmentName = 'Mathematics'
    -> LIMIT 5;
+----------+----------------+--------------+---------+
| CourseID | CourseName     | DepartmentID | Credits |
+----------+----------------+--------------+---------+
|      103 | Linear Algebra |            2 |       3 |
|      104 | Calculus I     |            2 |       3 |
+----------+----------------+--------------+---------+
2 rows in set (0.00 sec)

mysql> SELECT CourseID, COUNT(StudentID) AS TotalStudents
    -> FROM Enrollments
    -> GROUP BY CourseID
    -> HAVING COUNT(StudentID) > 5;
Empty set (0.00 sec)

mysql> SELECT s.StudentID, s.FirstName, s.LastName
    -> FROM Students s
    -> JOIN Enrollments e1 ON s.StudentID = e1.StudentID
    -> JOIN Courses c1 ON e1.CourseID = c1.CourseID AND c1.CourseName = 'Introduction to SQL'
    -> JOIN Enrollments e2 ON s.StudentID = e2.StudentID
    -> JOIN Courses c2 ON e2.CourseID = c2.CourseID AND c2.CourseName = 'Data Structures';
+-----------+-----------+----------+
| StudentID | FirstName | LastName |
+-----------+-----------+----------+
|         1 | John      | Doe      |
|         3 | Alice     | Brown    |
+-----------+-----------+----------+
2 rows in set (0.00 sec)

mysql> SELECT DISTINCT s.StudentID, s.FirstName, s.LastName
    -> FROM Students s
    -> JOIN Enrollments e ON s.StudentID = e.StudentID
    -> JOIN Courses c ON e.CourseID = c.CourseID
    -> WHERE c.CourseName IN ('Introduction to SQL', 'Data Structures');
+-----------+-----------+----------+
| StudentID | FirstName | LastName |
+-----------+-----------+----------+
|         1 | John      | Doe      |
|         2 | Jane      | Smith    |
|         3 | Alice     | Brown    |
+-----------+-----------+----------+
3 rows in set (0.00 sec)

mysql> SELECT AVG(Credits) AS AverageCredits
    -> FROM Courses;
+----------------+
| AverageCredits |
+----------------+
|         3.6000 |
+----------------+
1 row in set (0.00 sec)

mysql> SELECT MAX(i.Salary) AS MaxCSInstructorSalary
    -> FROM Instructors i
    -> JOIN Departments d ON i.DepartmentID = d.DepartmentID
    -> WHERE d.DepartmentName = 'Computer Science';
+-----------------------+
| MaxCSInstructorSalary |
+-----------------------+
|              92000.00 |
+-----------------------+
1 row in set (0.00 sec)

mysql> SELECT d.DepartmentName, COUNT(DISTINCT e.StudentID) AS EnrolledStudentsCount
    -> FROM Departments d
    -> JOIN Courses c ON d.DepartmentID = c.DepartmentID
    -> JOIN Enrollments e ON c.CourseID = e.CourseID
    -> GROUP BY d.DepartmentID, d.DepartmentName;
+------------------+-----------------------+
| DepartmentName   | EnrolledStudentsCount |
+------------------+-----------------------+
| Computer Science |                     3 |
+------------------+-----------------------+
1 row in set (0.00 sec)

mysql> SELECT s.StudentID, s.FirstName, s.LastName, c.CourseName
    -> FROM Students s
    -> INNER JOIN Enrollments e ON s.StudentID = e.StudentID
    -> INNER JOIN Courses c ON e.CourseID = c.CourseID;
+-----------+-----------+----------+---------------------+
| StudentID | FirstName | LastName | CourseName          |
+-----------+-----------+----------+---------------------+
|         1 | John      | Doe      | Introduction to SQL |
|         1 | John      | Doe      | Data Structures     |
|         2 | Jane      | Smith    | Data Structures     |
|         3 | Alice     | Brown    | Introduction to SQL |
|         3 | Alice     | Brown    | Data Structures     |
+-----------+-----------+----------+---------------------+
5 rows in set (0.00 sec)

mysql>
mysql> SELECT s.StudentID, s.FirstName, s.LastName, c.CourseName
    -> FROM Students s
    -> LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
    -> LEFT JOIN Courses c ON e.CourseID = c.CourseID;
+-----------+-----------+----------+---------------------+
| StudentID | FirstName | LastName | CourseName          |
+-----------+-----------+----------+---------------------+
|         1 | John      | Doe      | Data Structures     |
|         1 | John      | Doe      | Introduction to SQL |
|         2 | Jane      | Smith    | Data Structures     |
|         3 | Alice     | Brown    | Data Structures     |
|         3 | Alice     | Brown    | Introduction to SQL |
|         5 | Charlie   | Green    | NULL                |
+-----------+-----------+----------+---------------------+
6 rows in set (0.00 sec)

mysql> SELECT DISTINCT s.StudentID, s.FirstName, s.LastName
    -> FROM Students s
    -> JOIN Enrollments e ON s.StudentID = e.StudentID
    -> WHERE e.CourseID IN (
    ->     SELECT CourseID
    ->     FROM Enrollments
    ->     GROUP BY CourseID
    ->     HAVING COUNT(StudentID) > 10
    -> );
Empty set (0.00 sec)

mysql> SELECT StudentID, FirstName, LastName, YEAR(EnrollmentDate) AS EnrollmentYear
    -> FROM Students;
+-----------+-----------+----------+----------------+
| StudentID | FirstName | LastName | EnrollmentYear |
+-----------+-----------+----------+----------------+
|         1 | John      | Doe      |           2021 |
|         2 | Jane      | Smith    |           2023 |
|         3 | Alice     | Brown    |           2020 |
|         5 | Charlie   | Green    |           2023 |
+-----------+-----------+----------+----------------+
4 rows in set (0.00 sec)

mysql> SELECT InstructorID, CONCAT(FirstName, ' ', LastName) AS FullName
    -> FROM Instructors;
+--------------+---------------+
| InstructorID | FullName      |
+--------------+---------------+
|            1 | Alice Johnson |
|            2 | Bob Lee       |
|            3 | Charlie Davis |
+--------------+---------------+
3 rows in set (0.10 sec)

mysql> SELECT EnrollmentID, CourseID, EnrollmentDate,
    ->        COUNT(StudentID) OVER (ORDER BY EnrollmentDate, EnrollmentID) AS RunningTotalStudents
    -> FROM Enrollments;
+--------------+----------+----------------+----------------------+
| EnrollmentID | CourseID | EnrollmentDate | RunningTotalStudents |
+--------------+----------+----------------+----------------------+
|            4 |      101 | 2020-09-02     |                    1 |
|            5 |      102 | 2020-09-03     |                    2 |
|            1 |      101 | 2021-08-21     |                    3 |
|            2 |      102 | 2021-08-22     |                    4 |
|            3 |      102 | 2023-01-11     |                    5 |
+--------------+----------+----------------+----------------------+
5 rows in set (0.00 sec)

mysql> SELECT StudentID, FirstName, LastName, EnrollmentDate,
    ->        CASE
    ->            WHEN TIMESTAMPDIFF(YEAR, EnrollmentDate, CURDATE()) > 4 THEN 'Senior'
    ->            ELSE 'Junior'
    ->        END AS StudentStatus
    -> FROM Students;
+-----------+-----------+----------+----------------+---------------+
| StudentID | FirstName | LastName | EnrollmentDate | StudentStatus |
+-----------+-----------+----------+----------------+---------------+
|         1 | John      | Doe      | 2021-08-20     | Senior        |
|         2 | Jane      | Smith    | 2023-01-10     | Junior        |
|         3 | Alice     | Brown    | 2020-09-01     | Senior        |
|         5 | Charlie   | Green    | 2023-08-15     | Junior        |
+-----------+-----------+----------+----------------+---------------+
4 rows in set (0.01 sec)

mysql>