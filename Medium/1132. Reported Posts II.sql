-- Table: Actions

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | user_id       | int     |
-- | post_id       | int     |
-- | action_date   | date    | 
-- | action        | enum    |
-- | extra         | varchar |
-- +---------------+---------+
-- This table may have duplicate rows.
-- The action column is an ENUM (category) type of ('view', 'like', 'reaction', 'comment', 'report', 'share').
-- The extra column has optional information about the action, such as a reason for the report or a type of reaction.
 

-- Table: Removals

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | post_id       | int     |
-- | remove_date   | date    | 
-- +---------------+---------+
-- post_id is the primary key (column with unique values) of this table.
-- Each row in this table indicates that some post was removed due to being reported or as a result of an admin review.
-- Write a solution to find the average daily percentage of posts that got removed after being reported as spam, rounded to 2 decimal places.


select round(avg(daily_pct), 2) as average_daily_percent
from(
    select action_date, 
        sum(case when remove_date is not null then 1 else 0 end)/count(*)*100 as daily_pct
    from(
        select distinct action_date, post_id  -- deduplicate repeated date and post
        from Actions
        where extra = 'spam'
    ) a
    left join Removals b on a.post_id = b.post_id
    group by action_date
) a;

