--  Sample employee database 
--  See changelog table for details
--  Copyright (C) 2007,2008, MySQL AB
--  
--  Original data created by Fusheng Wang and Carlo Zaniolo
--  http://www.cs.aau.dk/TimeCenter/software.htm
--  http://www.cs.aau.dk/TimeCenter/Data/employeeTemporalDataSet.zip
-- 
--  Current schema by Giuseppe Maxia 
--  Data conversion from XML to relational by Patrick Crews
-- 
-- This work is licensed under the 
-- Creative Commons Attribution-Share Alike 3.0 Unported License. 
-- To view a copy of this license, visit 
-- http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to 
-- Creative Commons, 171 Second Street, Suite 300, San Francisco, 
-- California, 94105, USA.
-- 
--  DISCLAIMER
--  To the best of our knowledge, this data is fabricated, and
--  it does not correspond to real people. 
--  Any similarity to existing people is purely coincidental.


DROP DATABASE IF EXISTS employees;
CREATE DATABASE IF NOT EXISTS employees;
USE employees;

SELECT 'CREATING DATABASE STRUCTURE' as 'INFO';

DROP TABLE IF EXISTS dept_emp,
                     dept_manager,
                     titles,
                     salaries, 
                     employees, 
                     departments;

/*!50503 set default_storage_engine = InnoDB */;
/*!50503 select CONCAT('storage engine: ', @@default_storage_engine) as INFO */;

CREATE TABLE employees (
    emp_no      INT NOT NULL AUTO_INCREMENT,
    birth_date  DATE            NOT NULL,
    first_name  VARCHAR(14)     NOT NULL,
    last_name   VARCHAR(16)     NOT NULL,
    gender      ENUM ('M','F')  NOT NULL,    
    hire_date   DATE            NOT NULL,
    PRIMARY KEY (emp_no)
);
-- Insert into TABLE
INSERT INTO employees (birth_date, first_name, last_name, gender, hire_date) 
	VALUES ('2004-03-29', 'Jhon', 'Smith', 'M', '2022-06-09'),
		('2000-05-19', 'Rohard', 'Smith', 'M', '2017-06-09'),
        ('1990-08-25', 'Sarah', 'Williams', 'F', '2018-06-09'),
        ('1987-02-02', 'Jennifer', 'Brown', 'F', '2012-06-09'),
        ('2001-01-04', 'David', 'Lopez', 'M', '2021-06-09'),
        ('1994-11-23', 'Sarah', 'Wilson', 'F', '2016-06-09'),
        ('1989-08-09', 'Thomas', 'Davis', 'M', '2013-06-09'),
        ('1999-07-24', 'Betty', 'Johnson', 'F', '2017-06-09'),
        ('1993-04-12', 'BARBERA', 'SMITH', 'F', '2017-06-09'),
        ('2003-08-04', 'Joseph', 'Anderson', 'M', '2019-06-09'),
        ('1997-09-06', 'Micheal', 'Gonzales', 'M', '2012-06-09'),
        ('1995-02-19', 'Steven', 'Jackson', 'M', '2011-06-09'),
        ('2001-12-21', 'Emily', 'Smith', 'F', '2020-06-09'),
        ('2002-11-07', 'Jessica', 'Perez', 'F', '2021-06-09'),
        ('1978-03-14', 'SARAH', 'Martin', 'F', '2010-06-09');

-- Update DATA
UPDATE employees SET first_name = 'Robert' WHERE birth_date = '2000-05-19' AND first_name = 'Rohard' AND last_name = 'Smith';



CREATE TABLE departments (
    dept_no     CHAR(4)         NOT NULL,
    dept_name   VARCHAR(40)     NOT NULL,
    PRIMARY KEY (dept_no),
    UNIQUE  KEY (dept_name)
);

INSERT INTO departments (dept_no, dept_name) 
	VALUES (0931, 'Customer_service'),
		(0932, 'Accounting_and_finance'),
		(0933, 'Marketing_and_sales'),
		(0934, 'Human_resources'),
        (0935, 'Engineering'),
        (0936, 'Research_and_development'),
        (0937, 'Education');

-- Update department name
UPDATE departments SET dept_name = 'Manager' WHERE dept_no = 0931;
UPDATE departments SET dept_name = 'Administration' WHERE dept_no = 0932;
UPDATE departments SET dept_name = 'Research and development' WHERE dept_no = 0933;
UPDATE departments SET dept_name = 'Marketing and sales' WHERE dept_no = 0934;
UPDATE departments SET dept_name = 'Human resources' WHERE dept_no = 0935;
UPDATE departments SET dept_name = 'Customer service' WHERE dept_no = 0936;
UPDATE departments SET dept_name = 'Accounting and finance' WHERE dept_no = 0937;



CREATE TABLE dept_manager (
   emp_no       INT             NOT NULL,
   dept_no      CHAR(4)         NOT NULL,
   from_date    DATE            NOT NULL,
   to_date      DATE            NOT NULL,
   FOREIGN KEY (emp_no)  REFERENCES employees (emp_no)    ON DELETE CASCADE,
   FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE,
   PRIMARY KEY (emp_no,dept_no)
); 
-- Manager of Department Managers
INSERT INTO dept_manager (emp_no, dept_no, from_date, to_date) VALUES (15, 0931, '2012-01-15', '2035-01-15');

-- Manager of Department Administration
INSERT INTO dept_manager (emp_no, dept_no, from_date, to_date) VALUES (13, 0932, '2020-01-15', '2030-01-15');

-- Manager of Department Research and development
INSERT INTO dept_manager (emp_no, dept_no, from_date, to_date) VALUES (14, 0933, '2022-06-09', '2030-01-15');

-- Manager of Department Marketing and sales
INSERT INTO dept_manager (emp_no, dept_no, from_date, to_date) VALUES (10, 0934, '2020-01-15', '2030-01-15');

-- Manager of Department Human resources
INSERT INTO dept_manager (emp_no, dept_no, from_date, to_date) VALUES (12, 0935, '2020-01-15', '2030-01-15');

-- Manager of Department Customer service
INSERT INTO dept_manager (emp_no, dept_no, from_date, to_date) VALUES (11, 0936, '2022-06-09', '2030-01-15');

-- Manager of Department Accounting and finance
INSERT INTO dept_manager (emp_no, dept_no, from_date, to_date) VALUES (9, 0937, '2020-01-15', '2030-01-15');



CREATE TABLE dept_emp (
    emp_no      INT             NOT NULL,
    dept_no     CHAR(4)         NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE            NOT NULL,
    FOREIGN KEY (emp_no)  REFERENCES employees   (emp_no)  ON DELETE CASCADE,
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no,dept_no)
);

-- All Employees of Department Managers
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date) 
	VALUES (15, 0931, '2012-01-15', '2035-01-15'),
		(13, 0931, '2019-01-15', '2024-01-15'),
		(14, 0931, '2012-01-15', '2035-01-15'),
		(10, 0931, '2019-01-15', '2024-01-15'),
		(12, 0931, '2020-01-15', '2025-01-15'),
		(11, 0931, '2021-01-15', '2026-01-15'),
		(9, 0931, '2021-06-09', '2027-01-15');

-- All Employees of Department Administration
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date) 
	VALUES (2, 0932, '2020-01-15', '2030-01-15'),
		(6, 0932, '2020-01-15', '2030-01-15'),
		(5, 0932, '2021-06-09', '2030-01-15');

-- All Employees of Department Research and development
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date) 
	VALUES (1, 0933, '2022-06-09', '2030-01-15'),
		(3, 0933, '2020-01-15', '2030-01-15'),
        (4, 0933, '2020-01-15', '2030-01-15');

-- All Employees of Department Marketing and sales
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date) 
	VALUES (6, 0934, '2020-01-15', '2030-01-15'),
		(3, 0934, '2020-01-15', '2030-01-15'),
		(8, 0934, '2020-06-09', '2030-01-15');

-- All Employees of Department Human resources
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date) 
	VALUES (1, 0935, '2020-01-15', '2030-01-15'),
		(2, 0935, '2020-01-15', '2030-01-15'),
		(7, 0935, '2020-01-15', '2030-01-15');

-- All Employees of Department Customer service
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date) 
	VALUES (1, 0936, '2022-06-09', '2030-01-15'),
		(2, 0936, '2020-01-15', '2030-01-15'),
		(3, 0936, '2020-01-15', '2030-01-15'),
		(4, 0936, '2020-01-15', '2030-01-15'),
		(5, 0936, '2021-06-09', '2030-01-15'),
		(6, 0936, '2020-01-15', '2030-01-15'),
		(7, 0936, '2020-01-15', '2030-01-15'),
		(8, 0936, '2020-01-15', '2030-01-15');

-- All Employees of Department Accounting and finance
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date) 
	VALUES (6, 0937, '2020-01-15', '2030-01-15'),
		(7, 0937, '2020-01-15', '2030-01-15'),
        (8, 0937, '2020-01-15', '2030-01-15');



CREATE TABLE titles (
    emp_no      INT             NOT NULL,
    title       VARCHAR(50)     NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no,title, from_date)
);

-- All Employees with Marketing and Business titles
INSERT INTO titles (emp_no, title, from_date, to_date) 
	VALUES (1, 'Marketing and Business', '2020-01-20', '2024-03-23'),
		(3, 'Marketing and Business', '2020-03-23', '2024-03-23'),
		(5, 'Marketing and Business', '2020-08-18', '2024-03-23'),
		(7, 'Marketing and Business', '2020-05-25', '2024-03-23'),
		(9, 'Marketing and Business', '2020-07-12', '2024-03-23'),
		(11, 'Marketing and Business', '2019-03-05', '2024-03-23'),
		(13, 'Marketing and Business', '2017-03-23', '2024-03-23'),
		(15, 'Marketing and Business', '2010-03-13', '2024-03-23');

-- All Employees with Health Professions titles
INSERT INTO titles (emp_no, title, from_date, to_date) 
	VALUES (1, 'Health Professions', '2019-03-23', '2024-03-23'),
		(3, 'Health Professions', '2020-11-23', '2024-03-23'),
        (5, 'Health Professions', '2020-03-23', '2024-03-23'),
        (7, 'Health Professions', '2010-03-23', '2024-03-23'),
        (9, 'Health Professions', '2012-03-23', '2024-03-23'),
        (11, 'Health Professions', '2020-02-14', '2024-03-23'),
        (13, 'Health Professions', '2020-09-23', '2024-03-23'),
        (15, 'Health Professions', '2020-12-12', '2024-03-23');


-- All Employees with Social Sciences and History titles
INSERT INTO titles (emp_no, title, from_date, to_date) 
	VALUES (1, 'Social Sciences and History', '2020-03-23', '2024-03-23'),
		(3, 'Social Sciences and History', '2020-03-23', '2024-03-23'),
        (5, 'Social Sciences and History', '2020-03-23', '2024-03-23'),
        (7, 'Social Sciences and History', '2020-03-23', '2024-03-23'),
        (9, 'Social Sciences and History', '2020-03-23', '2024-03-23'),
        (11, 'Social Sciences and History', '2020-03-23', '2024-03-23'),
        (13, 'Social Sciences and History', '2020-03-23', '2024-03-23'),
        (15, 'Social Sciences and History', '2020-03-23', '2024-03-23');

-- All Employees with Engineering titles
INSERT INTO titles (emp_no, title, from_date, to_date) 
	VALUES (1, 'Engineering', '2020-03-23', '2024-03-23'),
		(3, 'Engineering', '2020-03-23', '2024-03-23'),
        (5, 'Engineering', '2020-03-23', '2024-03-23'),
        (7, 'Engineering', '2020-03-23', '2024-03-23'),
        (9, 'Engineering', '2020-03-23', '2024-03-23'),
        (11, 'Engineering', '2020-03-23', '2024-03-23'),
        (13, 'Engineering', '2020-03-23', '2024-03-23'),
        (15, 'Engineering', '2020-03-23', '2024-03-23');

-- All Employees with Biological and Biomedical Sciences titles
INSERT INTO titles (emp_no, title, from_date, to_date) 
	VALUES (1, 'Biological and Biomedical Sciences', '2020-03-23', '2024-03-23'),
		(3, 'Biological and Biomedical Sciences', '2020-03-23', '2024-03-23'),
        (5, 'Biological and Biomedical Sciences', '2020-03-23', '2024-03-23'),
        (7, 'Biological and Biomedical Sciences', '2020-03-23', '2024-03-23'),
        (9, 'Biological and Biomedical Sciences', '2020-03-23', '2024-03-23'),
        (11, 'Biological and Biomedical Sciences', '2020-03-23', '2024-03-23'),
        (13, 'Biological and Biomedical Sciences', '2020-03-23', '2024-03-23'),
        (15, 'Biological and Biomedical Sciences', '2020-03-23', '2024-03-23');

-- All Employees with Psychology titles
INSERT INTO titles (emp_no, title, from_date, to_date) 
	VALUES (2, 'Psychology', '2012-01-05', '2016-01-05'),
		(4, 'Psychology', '2012-01-05', '2016-01-05'),
        (6, 'Psychology', '2012-01-05', '2016-01-05'),
        (8, 'Psychology', '2012-01-05', '2016-01-05'),
        (10, 'Psychology', '2012-01-05', '2016-01-05'),
        (12, 'Psychology', '2012-01-05', '2016-01-05'),
        (14, 'Psychology', '2012-01-05', '2016-01-05');

-- All Employees with Communication and Journalism titles
INSERT INTO titles (emp_no, title, from_date, to_date) 
	VALUES (2, 'Communication and Journalism', '2012-01-05', '2016-01-05'),
		(4, 'Communication and Journalism', '2012-01-05', '2016-01-05'),
		(6, 'Communication and Journalism', '2012-01-05', '2016-01-05'),
		(8, 'Communication and Journalism', '2012-01-05', '2016-01-05'),
		(10, 'Communication and Journalism', '2012-01-05', '2016-01-05'),
		(12, 'Communication and Journalism', '2012-01-05', '2016-01-05'),
		(14, 'Communication and Journalism', '2012-01-05', '2016-01-05');

-- All Employees with Visual and Performing Arts titles
INSERT INTO titles (emp_no, title, from_date, to_date) 
	VALUES (2, 'Visual and Performing Arts', '2012-01-05', '2016-01-05'),
		(4, 'Visual and Performing Arts', '2012-01-05', '2016-01-05'),
        (6, 'Visual and Performing Arts', '2012-01-05', '2016-01-05'),
        (8, 'Visual and Performing Arts', '2012-01-05', '2016-01-05'),
        (10, 'Visual and Performing Arts', '2012-01-05', '2016-01-05'),
        (12, 'Visual and Performing Arts', '2012-01-05', '2016-01-05'),
        (14, 'Visual and Performing Arts', '2012-01-05', '2016-01-05');

-- All Employees with Education titles
INSERT INTO titles (emp_no, title, from_date, to_date) 
	VALUES (2, 'Education', '2012-01-05', '2016-01-05'),
		(4, 'Education', '2012-01-05', '2016-01-05'),
		(6, 'Education', '2012-01-05', '2016-01-05'),
		(8, 'Education', '2012-01-05', '2016-01-05'),
		(10, 'Education', '2012-01-05', '2016-01-05'),
		(12, 'Education', '2012-01-05', '2016-01-05'),
		(14, 'Education', '2012-01-05', '2016-01-05');

-- All Employees with Computer and Information Sciences titles
INSERT INTO titles (emp_no, title, from_date, to_date) 
	VALUES (2, 'Computer and Information Sciences', '2012-01-05', '2016-01-05'),
		(4, 'Computer and Information Sciences', '2012-01-05', '2016-01-05'),
        (6, 'Computer and Information Sciences', '2012-01-05', '2016-01-05'),
        (8, 'Computer and Information Sciences', '2012-01-05', '2016-01-05'),
        (10, 'Computer and Information Sciences', '2012-01-05', '2016-01-05'),
        (12, 'Computer and Information Sciences', '2012-01-05', '2016-01-05'),
        (14, 'Computer and Information Sciences', '2012-01-05', '2016-01-05');



CREATE TABLE salaries (
    emp_no      INT             NOT NULL,
    salary      INT             NOT NULL,
    from_date   DATE            NOT NULL,
    to_date     DATE            NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no, from_date)
); 

INSERT INTO salaries (emp_no, salary, from_date, to_date) 
	VALUES (1, 5000, '2020-01-05', '2024-01-05'),
		
        (2, 10000, '2018-01-05', '2030-01-05'),
        
        (3, 20000, '2016-01-05', '2040-01-05'),
        
        (4, 20000, '2016-01-05', '2023-02-05'),
        (4, 30000, '2023-02-05', '2026-02-05'),
        
        (5, 20000, '2016-01-05', '2023-02-05'),
        (5, 30000, '2023-02-05', '2026-02-05'),
        
        (6, 20000, '2016-01-05', '2023-02-05'),
        (6, 30000, '2023-02-05', '2026-02-05'),
        
        (7, 20000, '2016-01-05', '2023-02-05'),
        (7, 30000, '2023-02-05', '2026-02-05'),
        
        (8, 20000, '2016-01-05', '2023-02-05'),
        (8, 30000, '2023-02-05', '2026-02-05'),
        
        (9, 5000, '2020-01-05', '2024-01-05'),
        
        (10, 10000, '2018-01-05', '2030-01-05'),
        
        (11, 20000, '2016-01-05', '2040-01-05'),
        
        (12, 5000, '2020-01-05', '2024-01-05'),
        
        (13, 10000, '2018-01-05', '2030-01-05'),
        
        (14, 40000, '2016-01-05', '2040-01-05'),
        
        (15, 50000, '2016-01-05', '2040-01-05');



CREATE OR REPLACE VIEW dept_emp_latest_date AS
    SELECT emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM dept_emp
    GROUP BY emp_no;

# shows only the current department for each employee
CREATE OR REPLACE VIEW current_dept_emp AS
    SELECT l.emp_no, dept_no, l.from_date, l.to_date
    FROM dept_emp d
        INNER JOIN dept_emp_latest_date l
        ON d.emp_no=l.emp_no AND d.from_date=l.from_date AND l.to_date = d.to_date;

-- # 1.4.3 GET DATA #
-- Select all employees with a salary greater than 20,000
select e.emp_no, e.first_name, e.birth_date, e.first_name, e.last_name, e.gender, e.hire_date, s.salary from employees e left join salaries s on e.emp_no = s.emp_no where s.salary > 20000;

-- Select all employees with a salary below 10,000
select e.emp_no, e.first_name, e.birth_date, e.first_name, e.last_name, e.gender, e.hire_date, s.salary from employees e left join salaries s on e.emp_no = s.emp_no where s.salary < 10000;

-- Select all employees who have a salary between 14,000 and 50,000,
select e.emp_no, e.first_name, e.birth_date, e.first_name, e.last_name, e.gender, e.hire_date, s.salary from employees e left join salaries s on e.emp_no = s.emp_no where s.salary >= 14000 and s.salary <= 50000;

-- Select the total number of employees 
select COUNT(*) from employees;

-- Select the total number of employees who have worked in more than one department
select emp_no, COUNT(*) from dept_emp group by emp_no having COUNT(*) >= 2;

-- Select the titles of the year 2020
select from_date, title from titles where year(from_date)='2020';

-- Select the name of all employees with capital letters
SELECT first_name FROM employees WHERE BINARY first_name = BINARY UPPER(first_name);

-- Select the name, surname and name of the current department of each employee
select e.first_name, e.last_name, d.dept_name from employees e 
	join dept_emp de on e.emp_no = de.emp_no 
    join departments d on de.dept_no = d.dept_no;
    
-- DID NOT SOLVE Select the name, surname and number of times the employee has worked as a manager
-- INSERT INTO employees (birth_date, first_name, last_name, gender, hire_date) VALUES ('2004-03-29', 'Jhon', 'Smith', 'M', '2022-06-09');
-- INSERT INTO departments (dept_no, dept_name) VALUES (0931, 'Customer_service');
-- INSERT INTO dept_manager (emp_no, dept_no, from_date, to_date) VALUES (15, 0931, '2012-01-15', '2035-01-15');
select e.first_name, e.last_name, d.dept_name from employees e 
	join dept_manager de on e.emp_no = de.emp_no 
    join departments d on de.dept_no = d.dept_no;

-- Select the name of employees without any being repeated
SELECT DISTINCT first_name from employees;

-- # 1.4.4 DELETE DATA #
delete employees from employees left join salaries on employees.emp_no = salaries.emp_no where salaries.salary > 20000;
