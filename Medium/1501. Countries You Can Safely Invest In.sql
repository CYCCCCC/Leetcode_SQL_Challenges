-- Table Person:

-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | id             | int     |
-- | name           | varchar |
-- | phone_number   | varchar |
-- +----------------+---------+
-- id is the column of unique values for this table.
-- Each row of this table contains the name of a person and their phone number.
-- Phone number will be in the form 'xxx-yyyyyyy' where xxx is the country code (3 characters) and yyyyyyy is the phone number (7 characters) where x and y are digits. Both can contain leading zeros.
 

-- Table Country:

-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | name           | varchar |
-- | country_code   | varchar |
-- +----------------+---------+
-- country_code is the column of unique values for this table.
-- Each row of this table contains the country name and its code. country_code will be in the form 'xxx' where x is digits.
 

-- Table Calls:

-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | caller_id   | int  |
-- | callee_id   | int  |
-- | duration    | int  |
-- +-------------+------+
-- This table may contain duplicate rows.
-- Each row of this table contains the caller id, callee id and the duration of the call in minutes. caller_id != callee_id
 

-- A telecommunications company wants to invest in new countries. The company intends to invest in the countries where the average call duration of the calls in this country is strictly greater than the global average call duration.
-- Write a solution to find the countries where this company can invest.
-- Return the result table in any order.


with person_table as (
    select a.id, b.name as country
    from Person a
    left join Country b on substring(phone_number, 1, 3) = b.country_code
),
call_table as (
    select caller_id as id, duration
    from Calls
    union all
    select callee_id as id, duration
    from Calls
)

select country
from call_table a
left join person_table b on a.id = b.id
group by country
having avg(duration) > (select avg(duration)
                        from call_table);
