-- SQL Exercise 2
create database org;
show databases;
use org;
show tables;

-- Task 1: insert data into table BONUS
insert into BONUS values (6, 32000, '2021-11-02');
insert into BONUS values (6, 20000, '2022-11-02');
insert into BONUS values (5, 21000, '2021-11-02');
insert into BONUS values (9, 30000, '2021-11-02');
insert into BONUS values (8, 4500, '2022-11-02');

-- Task 2: Show the second highest salary
select salary
from WORKER
order by salary desc
limit 1 offset 1;

-- Task 3: print the name of employees having the highest salary in each department
with MAXSALARY as (
	select department, max(salary) as max_salary
    from WORKER
    group by department
    )
select w.first_name, w.last_name, m.max_salary
from WORKER w, MAXSALARY m
where w.department = m.department
and w.salary = m.max_salary
;

-- Task 4: fetch the list of employees with the same salary
with SAMESALARY as (
	select salary
    from WORKER
    group by salary
    having count(*) > 1
)
select w.first_name, w.last_name, w.salary
from SAMESALARY s, Worker w
where s.salary = w.salary
;

-- Task 5: find the worker names with salaries + bouns in 2021
with BONUS21 as ( 
	select *
	from BONUS
	where DATE_FORMAT(bonus_date, '%Y') = '2021'
)
select w.first_name, w.last_name,
b.bonus_amount + w.salary as total_salary
from BONUS21 b, WORKER w
where b.worker_ref_id = w.worker_id
;

-- Task 6: delete all records in table WORKER; study why cannot be deleted?
delete from WORKER;
-- * referential integrity constraints (invalid references)
-- -> the records of WORKER_ID in table WORKER are being referenced by the records of WORKER_REF_ID in table BONUS through a foreign key constraint
-- -> deleting a record from the table WORKER would result in invalid references in the table BONUS
-- -> violating the referential integrity constraint

-- Task 7: drop table WORKER, study why cannot be dropped
drop table WORKER;
-- * referential integrity constraints (constraint violation)
-- -> the table BONUS still has a foreign key constraint that references the primary key of the table WORKER
-- -> dropping the table WORKER would leave the foreign key constraint in the table BONUS without a valid reference
-- -> violating the referential integrity constraint
