-- Table: Views

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | article_id    | int     |
-- | author_id     | int     |
-- | viewer_id     | int     |
-- | view_date     | date    |
-- +---------------+---------+
-- This table may have duplicate rows.
-- Each row of this table indicates that some viewer viewed an article (written by some author) on some date. 
-- Note that equal author_id and viewer_id indicate the same person.
 

-- Write a solution to find all the people who viewed more than one article on the same date.
-- Return the result table sorted by id in ascending order.

select distinct viewer_id as id
from Views
group by viewer_id, view_date
having count(distinct article_id) > 1  -- deduplicate repeated data
order by viewer_id;

