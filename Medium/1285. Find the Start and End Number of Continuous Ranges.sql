-- Table: Logs

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | log_id        | int     |
-- +---------------+---------+
-- log_id is the column of unique values for this table.
-- Each row of this table contains the ID in a log Table.
 
-- Write a solution to find the start and end number of continuous ranges in the table Logs.
-- Return the result table ordered by start_id.


with seq_table as (
    select log_id,
           log_id - row_number() over(order by log_id) as seq_no  -- consecutive number would get the same seq_no
    from Logs
)

select min(log_id) as start_id, max(log_id) as end_id
from seq_table
group by seq_no;

