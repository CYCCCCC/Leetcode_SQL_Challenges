-- Table: Salary

-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | id          | int  |
-- | employee_id | int  |
-- | amount      | int  |
-- | pay_date    | date |
-- +-------------+------+
-- In SQL, id is the primary key column for this table.
-- Each row of this table indicates the salary of an employee in one month.
-- employee_id is a foreign key (reference column) from the Employee table.
 

-- Table: Employee

-- +---------------+------+
-- | Column Name   | Type |
-- +---------------+------+
-- | employee_id   | int  |
-- | department_id | int  |
-- +---------------+------+
-- In SQL, employee_id is the primary key column for this table.
-- Each row of this table indicates the department of an employee.
-- Find the comparison result (higher/lower/same) of the average salary of employees in a department to the company's average salary.
-- Return the result table in any order.


with comparion_tab as (
    select a.*, date_format(pay_date, '%Y-%m') as pay_month, department_id, 
        -- calculate avg for every month and by department
        avg(amount) over(partition by date_format(pay_date, '%Y-%m')) as total_avg,
        avg(amount) over(partition by date_format(pay_date, '%Y-%m'), department_id) as dep_avg
    from Salary a
    left join Employee b on a.employee_id = b.employee_id
)

select pay_month, department_id,
       case when avg(dep_avg) > avg(total_avg) then 'higher'
            when avg(dep_avg) < avg(total_avg) then 'lower'
            else 'same' end as comparison
from comparion_tab
group by pay_month, department_id;

