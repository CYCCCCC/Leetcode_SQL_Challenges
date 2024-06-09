
-- Table: Logs

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | num         | varchar |
-- +-------------+---------+
-- In SQL, id is the primary key for this table.
-- id is an autoincrement column.
 

-- Find all numbers that appear at least three times consecutively.

-- Return the result table in any order.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Logs table:
-- +----+-----+
-- | id | num |
-- +----+-----+
-- | 1  | 1   |
-- | 2  | 1   |
-- | 3  | 1   |
-- | 4  | 2   |
-- | 5  | 1   |
-- | 6  | 2   |
-- | 7  | 2   |
-- +----+-----+
-- Output: 
-- +-----------------+
-- | ConsecutiveNums |
-- +-----------------+
-- | 1               |
-- +-----------------+
-- Explanation: 1 is the only number that appears consecutively for at least three times.


-- solution 1

select distinct l1.num as ConsecutiveNums
from Logs l1
inner join Logs l2 on l1.id+1 = l2.id
inner join Logs l3 on l1.id+2 = l3.id
where l1.num = l2.num and l1.num = l3.num



-- solution 2

select distinct num as ConsecutiveNums
from(
    select num, id, 
    lag(num, 1) over(order by id) as num1, 
    lag(num, 2) over(order by id) as num2,
    lag(id, 1) over(order by id) as id1,
    lag(id, 2) over(order by id) as id2
    from Logs
) a
where num = num1 and num = num2
and id1 = id-1 and id2 = id-2