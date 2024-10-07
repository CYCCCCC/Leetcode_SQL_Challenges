-- Table: Project

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | project_id  | int     |
-- | employee_id | int     |
-- +-------------+---------+
-- (project_id, employee_id) is the primary key (combination of columns with unique values) of this table.
-- employee_id is a foreign key (reference column) to Employee table.
-- Each row of this table indicates that the employee with employee_id is working on the project with project_id.
 

-- Table: Employee

-- +------------------+---------+
-- | Column Name      | Type    |
-- +------------------+---------+
-- | employee_id      | int     |
-- | name             | varchar |
-- | experience_years | int     |
-- +------------------+---------+
-- employee_id is the primary key (column with unique values) of this table.
-- Each row of this table contains information about one employee.
 
-- Write a solution to report the most experienced employees in each project. In case of a tie, 
-- report all employees with the maximum number of experience years.
-- Return the result table in any order.



select project_id, employee_id
from(
    select a.project_id, a.employee_id, 
        dense_rank() over(partition by a.project_id order by experience_years desc) as exp_rank
    from Project a
    left join Employee b on a.employee_id = b.employee_id
) a
where exp_rank = 1;
