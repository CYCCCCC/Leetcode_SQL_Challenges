-- Table Variables:

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | name          | varchar |
-- | value         | int     |
-- +---------------+---------+
-- In SQL, name is the primary key for this table.
-- This table contains the stored variables and their values.
 

-- Table Expressions:

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | left_operand  | varchar |
-- | operator      | enum    |
-- | right_operand | varchar |
-- +---------------+---------+
-- In SQL, (left_operand, operator, right_operand) is the primary key for this table.
-- This table contains a boolean expression that should be evaluated.
-- operator is an enum that takes one of the values ('<', '>', '=')
-- The values of left_operand and right_operand are guaranteed to be in the Variables table.
 
-- Evaluate the boolean expressions in Expressions table.
-- Return the result table in any order.



select a.*, 
       case when operator = '>' and b.value > c.value then 'true'
            when operator = '=' and b.value = c.value then 'true'
            when operator = '<' and b.value < c.value then 'true'
            else 'false' end as value
from Expressions a
left join Variables b on a.left_operand = b.name
left join Variables c on a.right_operand = c.name;


-- -- solution 2
-- SELECT E.*,
-- CASE E.operator
-- WHEN ">" THEN IF(V1.value>V2.value,"true","false")
-- WHEN "=" THEN IF(V1.value=V2.value,"true","false")
-- WHEN "<" THEN IF(V1.value<V2.value,"true","false")
-- END AS value
-- FROM Expressions E LEFT JOIN Variables V1
-- ON E.left_operand=V1.name
-- LEFT JOIN Variables V2
-- ON E.right_operand = V2.name