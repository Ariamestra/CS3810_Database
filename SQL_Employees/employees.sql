CREATE DATABASE employees;

\c employees

-- TODO: create table departments
CREATE TABLE departments (
    code VARCHAR (2) PRIMARY KEY,
    "desc" VARCHAR (20) NOT NULL
);

-- TODO: populate table departments
Insert Into Departments
    ('HR', 'Human Resources'),
    ('IT', 'Information Technology'),
    ('SL', 'Sales');

-- TODO: create table employees
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR (55) NOT NULL,
    sal DECIMAL(7,2) NOT NULL, 
    deptCode CHAR (2),
    FOREIGN KEY (deptcode) REFERENCES Departments (code)
);

-- TODO: populate table Employees // Done one by one in class
INSERT INTO Employees (name, sal, deptcode) VALUES
    ('Sam Mai Tai', 50000, 'HR'),
    ('James Brandy', 55000, 'HR'),
    ('Whisky Strauss', 60000, 'HR'),
    ('Romeo Curcacau', 65000, 'IT'),
    ('Jose Caipirinha', 65000, 'IT'),
    ('Tony Gin and Tonic', 80000, 'SL'),
    ('Debby Derby', 85000, 'SL'),
    ('Morbid Mojito', 150000, NULL);

-- TODO: a) list all rows in Departments.
SELECT * From Departments;

-- TODO: b) list only the codes in Departments.
SELECT code From Departments;

-- TODO: c) list all rows in Employees.
SELECT * From Employees;

-- TODO: d) list only the names in Employees in alphabetical order.
SELECT name From Employees ORDER BY name;

-- TODO: e) list only the names and salaries in Employees, from the highest to the lowest salary.
Select name, sal From Employees ORDER BY sal DESC;

-- TODO: f) list the cartesian product of Employees and Departments.
SELECT * From Employees, Departments;

-- TODO: g) do the natural join of Employees and Departments; the result should be exactly the same as the cartesian product; do you know why?
SELECT * From Employees NATURAL JOIN Departments;

-- TODO: i) do an equi join of Employees and Departments matching the rows by Employees.deptCode and Departments.code (hint: use JOIN and the ON clause).
SELECT * From Employees E INNER JOIN Departments D ON E.deptCode = D.code;

-- TODO: j) same as previous query but project name and salary of the employees plus the description of their departments.
SELECT E.name, E.sal, D.desc From Employees E JOIN Departments D ON E.deptCode = D.code;

-- TODO: k) same as previous query but only the employees that earn less than 60000.
SELECT E.name, E.sal, D.desc From Employees E JOIN Departments D ON E.deptCode = D.code Where E.sal < 60000;

-- TODO: l) same as query ‘i’  but only the employees that earn more than ‘Jose Caipirinha’.
SELECT * From Employees E JOIN Departments D ON E.deptCode = D.code Where E.sal > (SELECT sal FROM Employees WHERE name = 'Jose Caipirinha');

-- TODO: m) list the left outer join of Employees and Departments (use the ON clause to match by department code); how does the result of this query differs from query ‘i’?
SELECT * From Employees E LEFT JOIN Departments D ON E.deptCode = D.code;

-- TODO: n) from query ‘m’, how would you do the left anti-join?
SELECT * From Employees E LEFT JOIN Departments D ON E.deptCode = D.code; WHERE e.deptCode IS NULL;

SELECT * FROM Employees WHERE deptCode IS NULL;

-- DEpartments that don't have employees
Select * FROM Employees E RIGHT JOIN Departments D ON E.deptCode = D.code WHERE D.deptCode = NULL;

-- TODO: o) show the number of employees per department.
Select deptCode AS department, COUNT(deptCode) AS total FROM Employees E GROUP BY deptCode HAVING COUNT(deptCode) > 0 ORDER BY deptCode;

-- TODO: p) same as query ‘o’ but I want to see the description of each department (not just their codes).
Select E.deptCode AS department, D.description, COUNT (E.deptCode) AS total 
FROM Employees E 
JOIN Departments D
On E.deptCode = D.code
GROUP BY department
ORDER BY department;