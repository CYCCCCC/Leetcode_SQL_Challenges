
-- Table Salaries:

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | company_id    | int     |
-- | employee_id   | int     |
-- | employee_name | varchar |
-- | salary        | int     |
-- +---------------+---------+
-- In SQL,(company_id, employee_id) is the primary key for this table.
-- This table contains the company id, the id, the name, and the salary for an employee.
 

-- Find the salaries of the employees after applying taxes. Round the salary to the nearest integer.

-- The tax rate is calculated for each company based on the following criteria:

-- 0% If the max salary of any employee in the company is less than $1000.
-- 24% If the max salary of any employee in the company is in the range [1000, 10000] inclusive.
-- 49% If the max salary of any employee in the company is greater than $10000.
-- Return the result table in any order.


with tax_table as (
select company_id, 
       case when max(salary) < 1000 then 0
            when max(salary) between 1000 and 10000 then 0.24
            else 0.49 end as tax_rate
from Salaries
group by company_id
)

select a.company_id, employee_id, employee_name,
       round(salary * (1-tax_rate)) as salary
from Salaries a
left join tax_table b on a.company_id = b.company_id;

