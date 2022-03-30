Table: Accounts

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| name          | varchar |
+---------------+---------+
id is the primary key for this table.
This table contains the account id and the user name of each account.
 

Table: Logins

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| login_date    | date    |
+---------------+---------+
There is no primary key for this table, it may contain duplicates.
This table contains the account id of the user who logged in and the login date. A user may log in multiple times in the day.
 

Active users are those who logged in to their accounts for five or more consecutive days.

Write an SQL query to find the id and the name of active users.

Return the result table ordered by id.

The query result format is in the following example.

 

Example 1:

Input: 
Accounts table:
+----+----------+
| id | name     |
+----+----------+
| 1  | Winston  |
| 7  | Jonathan |
+----+----------+
Logins table:
+----+------------+
| id | login_date |
+----+------------+
| 7  | 2020-05-30 |
| 1  | 2020-05-30 |
| 7  | 2020-05-31 |
| 7  | 2020-06-01 |
| 7  | 2020-06-02 |
| 7  | 2020-06-02 |
| 7  | 2020-06-03 |
| 1  | 2020-06-07 |
| 7  | 2020-06-10 |
+----+------------+
Output: 
+----+----------+
| id | name     |
+----+----------+
| 7  | Jonathan |
+----+----------+
Explanation: 
User Winston with id = 1 logged in 2 times only in 2 different days, so, Winston is not an active user.
User Jonathan with id = 7 logged in 7 times in 6 different days, five of them were consecutive days, so, Jonathan is an active user.

# Write your MySQL query statement below

select distinct id, name
from
(select id,login_date,
        lead(login_date, 4) over (partition by id order by login_date) lag_date
from (select distinct id, login_date from logins) t1) t2
inner join accounts
using (id)
where datediff(lag_date, login_date) = 4
order by id


# select id,login_date,
#         lead(login_date, 4) over (partition by id order by login_date) lag_date
# from (select distinct id, login_date from logins) t1

# +----+------------+-------------+
# | id | login_date |   lag_date  |
# +----+------------+-------------+
# | 1  | 2020-05-30 |    null     |
# | 1  | 2020-06-07 |    null     |
# | 7  | 2020-05-30 | 2020-06-03  |
# | 7  | 2020-05-31 | 2020-06-10  |
# | 7  | 2020-06-01 |    null     |
# | 7  | 2020-06-02 |    null     |
# | 7  | 2020-06-03 |    null     |
# | 7  | 2020-06-10 |    null     |
# +----+------------+-------------+

#approach1
# SELECT DISTINCT a.id
#     , (SELECT name FROM accounts WHERE id=a.id) AS name
# FROM logins a, logins b
# WHERE a.id = b.id AND DATEDIFF(a.login_date, b.login_date) BETWEEN 1 AND 4
# GROUP BY a.id, a.login_date
# HAVING COUNT(DISTINCT b.login_date) = 4