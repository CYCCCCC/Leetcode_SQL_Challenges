-- Table: Friendship

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | user1_id      | int     |
-- | user2_id      | int     |
-- +---------------+---------+
-- (user1_id, user2_id) is the primary key (combination of columns with unique values) for this table.
-- Each row of this table indicates that there is a friendship relation between user1_id and user2_id.
 

-- Table: Likes

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | user_id     | int     |
-- | page_id     | int     |
-- +-------------+---------+
-- (user_id, page_id) is the primary key (combination of columns with unique values) for this table.
-- Each row of this table indicates that user_id likes page_id.
 
-- Write a solution to recommend pages to the user with user_id = 1 using the pages that your friends liked. It should not recommend pages you already liked.
-- Return result table in any order without duplicates.


with friend_table as (
    select distinct user_id
    from (
        select user1_id as user_id
        from Friendship
        where user2_id = 1
        union
        select user2_id as user_id
        from Friendship
        where user1_id = 1
    )
)

select distinct page_id as recommended_page
from Likes
where user_id in (select user_id
                  from friend_table
                  )
and page_id not in (select page_id
                    from Likes
                    where user_id = 1
                    );

