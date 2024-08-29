DROP DATABASE audit;

CREATE DATABASE audit;

\c audit

CREATE TABLE Employees (
    id INT PRIMARY KEY, 
    name VARCHAR(50) NOT NULL
); 

CREATE TABLE EmployeesAudit (
    seq SERIAL PRIMARY KEY, 
    date DATE NOT NULL, 
    descr VARCHAR(200) NOT NULL
);

--- CREATE FUNCTION employee_audit_after_insert() RETURNS TRIGGER
CREATE FUNCTION employee_audit_after_insert() RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO EmployeesAudit(date, descr)
    VALUES (CURRENT_DATE, NEW.id || ',' || NEW.name);
    RETURN NEW;
END;
$$;

-- CREATE TRIGGER employee_audit
CREATE TRIGGER employee_audit
AFTER INSERT ON Employees
FOR EACH ROW EXECUTE FUNCTION employee_audit_after_insert();

-- use the following insert statements to test your trigger
INSERT INTO Employees VALUES (101, 'Samuel Adams'); 
INSERT INTO Employees VALUES (202, 'Adolph Coors');
INSERT INTO Employees VALUES (303, 'Arthur Guinness');

SELECT * FROM EmployeesAudit;
SELECT * FROM Employees;