
-- Table: Numbers

-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | num         | int  |
-- | frequency   | int  |
-- +-------------+------+
-- num is the primary key (column with unique values) for this table.
-- Each row of this table shows the frequency of a number in the database.
 

-- The median is the value separating the higher half from the lower half of a data sample.
-- Write a solution to report the median of all the numbers in the database after decompressing the Numbers table. 
-- Round the median to one decimal point.


select round(avg(num), 1) as median
from(
    select *, 
        sum(frequency) over(order by num) as accu_num_1,
        sum(frequency) over(order by num desc) as accu_num_2,
        sum(frequency) over() as total_num
    from Numbers
) a
-- Over half the figures rank above it, and over half rank below.
-- If the total frequency is even, then get two figures.
where accu_num_1 >= total_num/2 and accu_num_2 >= total_num/2;

