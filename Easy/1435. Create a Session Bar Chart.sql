Table: Sessions

+---------------------+---------+
| Column Name         | Type    |
+---------------------+---------+
| session_id          | int     |
| duration            | int     |
+---------------------+---------+
session_id is the primary key for this table.
duration is the time in seconds that a user has visited the application.
 

You want to know how long a user visits your application. You decided to create bins of "[0-5>", "[5-10>", "[10-15>", and "15 minutes or more" and count the number of sessions on it.

Write an SQL query to report the (bin, total).

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Sessions table:
+-------------+---------------+
| session_id  | duration      |
+-------------+---------------+
| 1           | 30            |
| 2           | 199           |
| 3           | 299           |
| 4           | 580           |
| 5           | 1000          |
+-------------+---------------+
Output: 
+--------------+--------------+
| bin          | total        |
+--------------+--------------+
| [0-5>        | 3            |
| [5-10>       | 1            |
| [10-15>      | 0            |
| 15 or more   | 1            |
+--------------+--------------+
Explanation: 
For session_id 1, 2, and 3 have a duration greater or equal than 0 minutes and less than 5 minutes.
For session_id 4 has a duration greater or equal than 5 minutes and less than 10 minutes.
There is no session with a duration greater than or equal to 10 minutes and less than 15 minutes.
For session_id 5 has a duration greater than or equal to 15 minutes.

# Write your MySQL query statement below
# 会丢失
# +--------------+--------------+
# | bin          | total        |
# +--------------+--------------+
# | [10-15>      | 0            |
# +--------------+--------------+

# with TableA as (select case when duration < 5*60 then '[0-5>' when duration >=5*60 and duration < 10*60 then '[5-10>'
# when duration >=10*60 and duration < 15*60 then '[10-15>' else '15 or more' end as bin
# from Sessions)


# select distinct TableA.bin, total 
# from TableA
# left join
# (select bin, count(bin) as total 
# from 
# TableA
# group by bin)TableB
# on TableA.bin = TableB.bin


#正确解法
select "[0-5>" as bin, ifnull(sum(case when duration < 300 then 1 end), 0) as total from Sessions
union all
select "[5-10>" as bin, ifnull(sum(case when duration >= 300 and duration < 600 then 1 end), 0) as total from Sessions
union all
select "[10-15>" as bin, ifnull(sum(case when duration >= 600 and duration < 900 then 1 end), 0) as total from Sessions
union all
select "15 or more" as bin, ifnull(sum(case when duration >= 900 then 1 end), 0) as total from Sessions