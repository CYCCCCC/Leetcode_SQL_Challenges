-- Table: Teams

-- +---------------+----------+
-- | Column Name   | Type     |
-- +---------------+----------+
-- | team_id       | int      |
-- | team_name     | varchar  |
-- +---------------+----------+
-- team_id is the column with unique values of this table.
-- Each row of this table represents a single football team.
 

-- Table: Matches

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | match_id      | int     |
-- | host_team     | int     |
-- | guest_team    | int     | 
-- | host_goals    | int     |
-- | guest_goals   | int     |
-- +---------------+---------+
-- match_id is the column of unique values of this table.
-- Each row is a record of a finished match between two different teams. 
-- Teams host_team and guest_team are represented by their IDs in the Teams table (team_id), and they scored host_goals and guest_goals goals, respectively.
 

-- You would like to compute the scores of all teams after all matches. Points are awarded as follows:
-- A team receives three points if they win a match (i.e., Scored more goals than the opponent team).
-- A team receives one point if they draw a match (i.e., Scored the same number of goals as the opponent team).
-- A team receives no points if they lose a match (i.e., Scored fewer goals than the opponent team).
-- Write a solution that selects the team_id, team_name and num_points of each team in the tournament after all described matches.
-- Return the result table ordered by num_points in decreasing order. In case of a tie, order the records by team_id in increasing order.


with score_table as(
    select *,
        case when host_goals > guest_goals then 3
                when host_goals = guest_goals then 1
                else 0 end as host_point,
        case when guest_goals > host_goals then 3
                when guest_goals = host_goals then 1
                else 0 end as guest_point
    from Matches
) 

select a.team_id, a.team_name, ifnull(sum(num_point), 0) as num_points
from Teams a
left join (
    -- concat team_id and score no matter as host or guest
    select host_team as team_id, host_point as num_point
    from score_table
    union all
    select guest_team as team_id, guest_point as num_point
    from score_table
) b
on a.team_id = b.team_id
group by a.team_id, a.team_name
order by num_points desc, a.team_id;
