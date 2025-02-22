
-- Table: Scores

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | player_name   | varchar |
-- | gender        | varchar |
-- | day           | date    |
-- | score_points  | int     |
-- +---------------+---------+
-- (gender, day) is the primary key (combination of columns with unique values) for this table.
-- A competition is held between the female team and the male team.
-- Each row of this table indicates that a player_name and with gender has scored score_point in someday.
-- Gender is 'F' if the player is in the female team and 'M' if the player is in the male team.
 
-- Write a solution to find the total score for each gender on each day.
-- Return the result table ordered by gender and day in ascending order.


select gender, day,
       sum(score_points) over(partition by gender order by day) as total
from Scores
order by gender, day;
