-- Table: Customers

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | customer_id   | int     |
-- | name          | varchar |
-- +---------------+---------+
-- customer_id is the column with unique values for this table.
-- This table contains information about customers.
 

-- Table: Orders

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | order_id      | int     |
-- | order_date    | date    |
-- | customer_id   | int     |
-- | cost          | int     |
-- +---------------+---------+
-- order_id is the column with unique values for this table.
-- This table contains information about the orders made by customer_id.
-- Each customer has one order per day.
 
-- Write a solution to find the most recent three orders of each user. If a user ordered less than three orders, return all of their orders.
-- Return the result table ordered by customer_name in ascending order and in case of a tie by the customer_id in ascending order. If there is still a tie, order them by order_date in descending order.



select b.name as customer_name, a.customer_id, a.order_id, a.order_date
from (
    select order_id, order_date, customer_id,
           row_number() over(partition by customer_id order by order_date desc) as order_rank
    from Orders
) a
left join Customers b on a.customer_id = b.customer_id
where order_rank <= 3
order by b.name, a.customer_id, a.order_date desc;
