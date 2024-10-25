
-- Table: Activity

-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | player_id    | int     |
-- | device_id    | int     |
-- | event_date   | date    |
-- | games_played | int     |
-- +--------------+---------+
-- (player_id, event_date) is the primary key (combination of columns with unique values) of this table.
-- This table shows the activity of players of some games.
-- Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 
-- The install date of a player is the first login day of that player.
-- We define day one retention of some date x to be the number of players whose install date is x and they logged back in on the day right after x, divided by the number of players whose install date is x, rounded to 2 decimal places.
-- Write a solution to report for each install date, the number of players that installed the game on that day, and the day one retention.
-- Return the result table in any order.


with log_tab as (
select *,
    row_number() over(partition by player_id order by event_date) as log_no,
    -- calculate the duration between 1st and 2nd login
    datediff(lead(event_date, 1) over(partition by player_id order by event_date), event_date) as duration
from Activity 
)

select event_date as install_dt, count(player_id) as installs,
       round(sum(case when duration = 1 then 1 else 0 end) / count(player_id), 2) as Day1_retention
from log_tab
where log_no = 1
group by install_dt;