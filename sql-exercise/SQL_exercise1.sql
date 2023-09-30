show databases;
use BOOTCAMP_EXERCISE1;
show tables;

-- 1.Create tables
CREATE TABLE LOCATIONS (
	location_id INTEGER PRIMARY KEY,
    street_address VARCHAR(25),
    postal_code VARCHAR(12),
    city VARCHAR(30),
    state_province VARCHAR(12),
    country_id VARCHAR(2),
    FOREIGN KEY(country_id) REFERENCES COUNTRIES(country_id)
);

CREATE TABLE COUNTRIES (
	country_id VARCHAR(2) PRIMARY KEY,
    country_name VARCHAR(40),
    region_id INTEGER,
    FOREIGN KEY(region_id) REFERENCES REGIONS(region_id)
);

CREATE TABLE DEPARTMENTS (
	department_id INTEGER PRIMARY KEY,
    department_name VARCHAR(30),
    manager_id INTEGER,
    location_id INTEGER,
    FOREIGN KEY(location_id) REFERENCES LOCATIONS(location_id)
);

CREATE TABLE EMPLOYEES (
	employee_id INTEGER PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    email VARCHAR(25),
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id VARCHAR(10),
    salary INTEGER,
    commission_pct INTEGER,
    manager_id INTEGER,
    department_id INTEGER,
    FOREIGN KEY(job_id) REFERENCES JOBS(job_id),
    FOREIGN KEY(department_id) REFERENCES DEPARTMENTS(department_id)
);

CREATE TABLE JOB_HISTORY (
	employee_id INTEGER,
    start_date DATE,
    end_date DATE,
    job_id VARCHAR(10),
    department_id INTEGER,
    PRIMARY KEY(employee_id, start_date),
    FOREIGN KEY(employee_id) REFERENCES EMPLOYEES(employee_id),
    FOREIGN KEY(department_id) REFERENCES DEPARTMENTS(department_id),
    FOREIGN KEY(job_id) REFERENCES JOBS(job_id)
);

CREATE TABLE JOBS (
	job_id VARCHAR(10) PRIMARY KEY,
    job_title VARCHAR(35),
    min_salary INTEGER,
    max_salary INTEGER
);

CREATE TABLE REGIONS (
	region_id INTEGER PRIMARY KEY,
    region_name VARCHAR(25)
);

-- 2.Insert data
-- Regions
INSERT INTO REGIONS VALUES (1, 'Americas');
INSERT INTO REGIONS VALUES (2, 'Asia Pacific');
INSERT INTO REGIONS VALUES (3, 'Europe');
INSERT INTO REGIONS VALUES (4, 'Middle East/Africa');

-- Countries
INSERT INTO COUNTRIES VALUES ('CA', 'Canada', 1);
INSERT INTO COUNTRIES VALUES ('CN', 'China', 2);
INSERT INTO COUNTRIES VALUES ('JP', 'Japan', 2);
INSERT INTO COUNTRIES VALUES ('DE', 'Germany', 3);
INSERT INTO COUNTRIES VALUES ('EG', 'Egypt', 4);

-- Locations
INSERT INTO LOCATIONS VALUES (1000, '1111 street', '100', 'Toronto', 'Ontario', 'CA');
INSERT INTO LOCATIONS VALUES (2000, '2222 street', '200', 'Shijiazhuang', 'Hebei', 'CN');
INSERT INTO LOCATIONS VALUES (3000, '3333 street', '300', 'Sapporo', 'Hokkaido', 'JP');
INSERT INTO LOCATIONS VALUES (4000, '4444 street', '400', 'hamburg', null, 'DE');
INSERT INTO LOCATIONS VALUES (5000, '5555 street', '500', 'Cairo', null, 'EG');

-- Departments
INSERT INTO DEPARTMENTS VALUES (10, 'Information Technology', 101, 1000);
INSERT INTO DEPARTMENTS VALUES (20, 'Marketing', 202, 2000);
INSERT INTO DEPARTMENTS VALUES (30, 'Purchasing', 303, 3000);
INSERT INTO DEPARTMENTS VALUES (40, 'Human Resources', 404, 4000);
INSERT INTO DEPARTMENTS VALUES (50, 'Accounting', 505, 5000);

-- Jobs
INSERT INTO JOBS VALUES (1, 'CEO', 100000, 1000000);
INSERT INTO JOBS VALUES (2, 'Manager', 20000, 200000);
INSERT INTO JOBS VALUES (3, 'Cleaner', 3000, 30000);

-- Employees
INSERT INTO EMPLOYEES VALUES (101, 'Ada', 'Amy', 'a@email.com', '11111111', '2001-01-01', 1, 100000, 10, 101, 10);
INSERT INTO EMPLOYEES VALUES (202, 'Boey', 'Bonnie', 'b@email.com', '22222222', '2002-02-02', 1, 200000, 20, 202, 20);
INSERT INTO EMPLOYEES VALUES (303, 'Cony', 'Connie', 'c@email.com', '33333333', '2003-03-03', 1, 300000, 30, 303, 30);
INSERT INTO EMPLOYEES VALUES (100, 'Dannie', 'Dora', 'd@email.com', '44444444', '2004-04-04', 2, 40000, 30, 101, 10);
INSERT INTO EMPLOYEES VALUES (200, 'Emily', 'Elaine', 'e@email.com', '55555555', '2005-05-05', 2, 50000, 30, 202, 20);
INSERT INTO EMPLOYEES VALUES (300, 'Fong', 'Fiona', 'f@email.com', '666666', '2006-06-06', 3, 6000, 30, 303, 30);

select * from JOB_HISTORY;

-- Job_History
INSERT INTO JOB_HISTORY VALUES (101, '2001-02-01', '2010-12-31', 2, 10);
INSERT INTO JOB_HISTORY VALUES (101, '2011-01-01', null, 1, 10);
INSERT INTO JOB_HISTORY VALUES (202, '2002-03-01', '2012-02-28', 2, 20);
INSERT INTO JOB_HISTORY VALUES (202, '2012-03-01', null, 1, 20);
INSERT INTO JOB_HISTORY VALUES (303, '2003-04-01', '2013-03-31', 1, 30);
INSERT INTO JOB_HISTORY VALUES (100, '2004-04-04', null, 2, 10);
INSERT INTO JOB_HISTORY VALUES (200, '2005-05-05', null, 2, 20);
INSERT INTO JOB_HISTORY VALUES (300, '2006-06-06', null, 3, 30);

-- 3. 
SELECT l.location_id, l.street_address, l.city, l.state_province, c.country_name
FROM LOCATIONS l, COUNTRIES c
;

-- 4.
SELECT first_name, last_name, department_id
FROM EMPLOYEES
;

-- 5. work in Japan
SELECT e.first_name, e.last_name, e.job_id, e.department_id
FROM EMPLOYEES e, DEPARTMENTS d, LOCATIONS l, COUNTRIES c
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id
AND l.country_id = 'JP'
GROUP BY e.employee_id
;

-- 6. find manager
SELECT m.employee_id, m.last_name
FROM EMPLOYEES e, EMPLOYEES m
WHERE m.employee_id = m.manager_id
GROUP BY m.employee_id
;

-- 7. hire after 'Cony Connie'
With ConyTbl AS (
	SELECT *
    FROM EMPLOYEES
    WHERE first_name = 'Cony'
    AND last_name = 'Connie'
)
SELECT e.first_name, e.last_name, e.hire_date
FROM EMPLOYEES e, ConyTbl c
where e.hire_date > c.hire_date
;

-- 8. each department
SELECT d.department_name,
count(e.employee_id) AS number_of_employees
FROM DEPARTMENTS d LEFT JOIN EMPLOYEES e
ON d.department_id = e.department_id
GROUP BY d.department_id
;

-- 9. department id 30
SELECT e.employee_id, j.job_title,
DATEDIFF(jh.end_date, jh.start_date) AS number_of_days
FROM EMPLOYEES e, JOBS j, JOB_HISTORY jh
WHERE e.employee_id = jh.employee_id
AND jh.job_id = j.job_id
AND jh.department_id = 30
;

-- 10. 
SELECT d.department_name,
e.first_name AS manager_first_name,
e.last_name AS manager_last_name,
l.city,
c.country_name
FROM DEPARTMENTS d, LOCATIONS l, COUNTRIES c, EMPLOYEES e
WHERE d.location_id = l.location_id
AND l.country_id = c.country_id
AND d.manager_id = e.employee_id
;

-- 11. avg salary
SELECT avg(e.salary) AS average_salary
FROM DEPARTMENTS d, EMPLOYEES e
WHERE d.department_id = e.department_id
;

-- 12. Normalization, re-design JOBS
ALTER TABLE JOBS ADD grade_level VARCHAR(2);
ALTER TABLE JOBS ADD FOREIGN KEY(grade_level) REFERENCES JOB_GRADES(grade_level);

CREATE TABLE JOB_GRADES (
	grade_level VARCHAR(2) PRIMARY KEY,
    lowest_sal INTEGER,
    highest_sal INTEGER
);