-- Table: Sales

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | sale_date     | date    |
-- | fruit         | enum    | 
-- | sold_num      | int     | 
-- +---------------+---------+
-- (sale_date, fruit) is the primary key (combination of columns with unique values) of this table.
-- This table contains the sales of "apples" and "oranges" sold each day.
 
-- Write a solution to report the difference between the number of apples and oranges sold each day.
-- Return the result table ordered by sale_date.


select sale_date,
       sum(case when fruit = 'apples' then sold_num else -sold_num end) as diff
from Sales
group by sale_date;


-- -- solution 2
-- select a.sale_date, apple_no-orange_no as diff
-- from (
--     select sale_date, sold_num as apple_no
--     from Sales
--     where fruit = 'apples'
-- ) a
-- left join (
--     select sale_date, sold_num as orange_no
--     from Sales
--     where fruit = 'oranges'
-- ) b on a.sale_date = b.sale_date
-- order by a.sale_date;
