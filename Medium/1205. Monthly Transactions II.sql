-- Table: Transactions

-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | id             | int     |
-- | country        | varchar |
-- | state          | enum    |
-- | amount         | int     |
-- | trans_date     | date    |
-- +----------------+---------+
-- id is the column of unique values of this table.
-- The table has information about incoming transactions.
-- The state column is an ENUM (category) of type ["approved", "declined"].
-- Table: Chargebacks

-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | trans_id       | int     |
-- | trans_date     | date    |
-- +----------------+---------+
-- Chargebacks contains basic information regarding incoming chargebacks from some transactions placed in Transactions table.
-- trans_id is a foreign key (reference column) to the id column of Transactions table.
-- Each chargeback corresponds to a transaction made previously even if they were not approved.
 

-- Write a solution to find for each month and country: the number of approved transactions and their total amount, the number of chargebacks, and their total amount.
-- Note: In your solution, given the month and country, ignore rows with all zeros.
-- Return the result table in any order.



with tran_table as (
    select *
    from Transactions
    where state = 'approved'
    union all
    select trans_id as id, country, 'back' as state,
        amount, a.trans_date 
    from Chargebacks a
    left join Transactions b on a.trans_id = b.id
)

select date_format(trans_date, '%Y-%m') as month, country,
       sum(state='approved') as approved_count,
       sum((state='approved')*amount) as approved_amount,
       sum(state='back') as chargeback_count,
       sum((state='back')*amount) as chargeback_amount
from tran_table
group by month, country;

