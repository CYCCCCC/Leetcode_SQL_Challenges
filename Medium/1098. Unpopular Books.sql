-- Table: Books

-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | book_id        | int     |
-- | name           | varchar |
-- | available_from | date    |
-- +----------------+---------+
-- book_id is the primary key (column with unique values) of this table.
 

-- Table: Orders

-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | order_id       | int     |
-- | book_id        | int     |
-- | quantity       | int     |
-- | dispatch_date  | date    |
-- +----------------+---------+
-- order_id is the primary key (column with unique values) of this table.
-- book_id is a foreign key (reference column) to the Books table.
 
-- Write a solution to report the books that have sold less than 10 copies in the last year, 
-- excluding books that have been available for less than one month from today. Assume today is 2019-06-23.
-- Return the result table in any order.


select book_id, name
from Books 
where available_from <= date_sub('2019-06-23', interval 1 month)
and book_id not in (
    select book_id
    from Orders
    where dispatch_date >= date_sub('2019-06-23', interval 1 year)
    group by book_id
    having sum(quantity) >= 10
);

