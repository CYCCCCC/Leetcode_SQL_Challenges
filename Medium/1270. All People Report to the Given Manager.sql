-- Table: Employees

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | employee_id   | int     |
-- | employee_name | varchar |
-- | manager_id    | int     |
-- +---------------+---------+
-- employee_id is the column of unique values for this table.
-- Each row of this table indicates that the employee with ID employee_id and name employee_name reports his work to his/her direct manager with manager_id
-- The head of the company is the employee with employee_id = 1.
 

-- Write a solution to find employee_id of all employees that directly or indirectly report their work to the head of the company.
-- The indirect relation between managers will not exceed three managers as the company is small.
-- Return the result table in any order.


select t1.employee_id
from Employees t1
left join Employees t2 on t1.manager_id = t2.employee_id
left join Employees t3 on t2.manager_id = t3.employee_id
left join Employees t4 on t3.manager_id = t4.employee_id
where t4.manager_id = 1 and t1.employee_id <> 1;
