-- Table: Events

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | business_id   | int     |
-- | event_type    | varchar |
-- | occurrences   | int     | 
-- +---------------+---------+
-- (business_id, event_type) is the primary key (combination of columns with unique values) of this table.
-- Each row in the table logs the info that an event of some type occurred at some business for a number of times.
-- The average activity for a particular event_type is the average occurrences across all companies that have this event.

-- An active business is a business that has more than one event_type such that their occurrences is strictly greater than the average activity for that event.
-- Write a solution to find all active businesses.
-- Return the result table in any order.


select business_id
from(
    select *,
        avg(occurrences) over(partition by event_type) as event_avg
    from Events
) a
group by business_id
having sum(case when occurrences > event_avg then 1 else 0 end) > 1;
