Table: Logs

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| log_id        | int     |
+---------------+---------+
log_id is the primary key for this table.
Each row of this table contains the ID in a log Table.
 

Write an SQL query to find the start and end number of continuous ranges in the table Logs.

Return the result table ordered by start_id.

The query result format is in the following example.

 

Example 1:

Input: 
Logs table:
+------------+
| log_id     |
+------------+
| 1          |
| 2          |
| 3          |
| 7          |
| 8          |
| 10         |
+------------+
Output: 
+------------+--------------+
| start_id   | end_id       |
+------------+--------------+
| 1          | 3            |
| 7          | 8            |
| 10         | 10           |
+------------+--------------+
Explanation: 
The result table should contain all ranges in table Logs.
From 1 to 3 is contained in the table.
From 4 to 6 is missing in the table
From 7 to 8 is contained in the table.
Number 9 is missing from the table.
Number 10 is contained in the table.

# Write your MySQL query statement below
# ROW_NUMBER() function: add sequential integer number to each row  这儿的Table A的num列 就是从1开始到6

SELECT min(log_id) as start_id, max(log_id) as end_id
FROM
(SELECT log_id, ROW_NUMBER() OVER(ORDER BY log_id) as num
FROM Logs) TableA
GROUP BY log_id - num #就是difference

# +------------+------------+------------+
# | log_id     | num        | log_id-num |
# +------------+------------+------------+
# | 1          | 1          | 0          |
# | 2          | 2          | 0          |
# | 3          | 3          | 0          |
# | 7          | 4          | 3          |
# | 8          | 5          | 3          |
# | 10         | 6          | 4          |
# +------------+------------+------------+